using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;
using System;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace backend.Middleware
{
    public class KeycloakMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IConfiguration _configuration;
        private readonly ILogger<KeycloakMiddleware> _logger;

        private readonly string ADMIN_ROLE = "admin";
        private readonly string ROLE_KEY = "carwash-role";

        public KeycloakMiddleware(RequestDelegate next, IConfiguration configuration, ILogger<KeycloakMiddleware> logger)
        {
            _next = next;
            _configuration = configuration;
            _logger = logger;
        }
        public async Task InvokeAsync(HttpContext context)
        {
            string keycloakUrl = _configuration["KeycloakUserInfoUrl"];

            HttpClient client = new HttpClient();
            HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, new Uri(keycloakUrl));
            request.Headers.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
            foreach (var header in context.Request.Headers)
            {
                request.Headers.Add(header.Key, header.Value.AsEnumerable());
            }

            _logger.LogInformation("Sending admin request to: \n" + context.Request.GetDisplayUrl());

            var response = await client.SendAsync(request);
            var contentString = await response.Content.ReadAsStringAsync();
            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Keycloak request failed\n" + "Status code: " + (int)response.StatusCode + "\nPhrase: " + response.ReasonPhrase + "\nContent: " + contentString);
                context.Response.StatusCode = (int)response.StatusCode;
                await context.Response.WriteAsync(contentString);
                return;
            }
            var content = JObject.Parse(contentString);

            if (content[ROLE_KEY] == null)
            {
                _logger.LogWarning("User does not have roles array");
                context.Response.StatusCode = 403;
                await context.Response.WriteAsync("Forbidden");
                return;
            }
            var roles = (content[ROLE_KEY] as JArray)?.ToObject<string[]>();
            if (!(roles?.Contains(ADMIN_ROLE) ?? false))
            {
                _logger.LogWarning("User is not an admin");
                context.Response.StatusCode = 403;
                await context.Response.WriteAsync("Forbidden");
                return;
            }
            _logger.LogInformation("Keycloak auth succeeded");
            await _next.Invoke(context);
        }
    }
}
