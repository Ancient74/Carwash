import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree } from '@angular/router';
import { KeycloakAuthGuard, KeycloakService } from 'keycloak-angular';

@Injectable()
export class AdminGuard implements CanActivate {

  constructor(private keycloakService: KeycloakService) {}

  async canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    if (!this.keycloakService.getKeycloakInstance() || !this.keycloakService.getKeycloakInstance().authenticated) {
      await this.keycloakService.init({
        config: {
          url: '/auth',
          realm: 'carwash',
          clientId: 'carwash'
        },
        initOptions: {
          checkLoginIframe: false,
          onLoad: 'login-required',
        },
        enableBearerInterceptor: true
      });
    }
    return await this.keycloakService.isLoggedIn() && this.keycloakService.getUserRoles().findIndex(role => role === 'admin') >= 0;
  }
}
