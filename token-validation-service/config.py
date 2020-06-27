import os

HTTP_PORT = 3000
HTTP_HOST = "127.0.0.1"

KEYCLOAK_URL = "http://localhost:8080/auth/"
USER_INFO_URL = f"{KEYCLOAK_URL}realms/carwash/protocol/openid-connect/userinfo"
