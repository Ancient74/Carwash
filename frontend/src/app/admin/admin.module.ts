import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { KeycloakService, KeycloakAngularModule } from 'keycloak-angular';
import { AdminComponent } from './admin/admin.component';
import { Routes, RouterModule } from '@angular/router';
const keycloakService = new KeycloakService();

const routes: Routes = [
  { path: '', component: AdminComponent }
];

@NgModule({
  declarations: [
    AdminComponent
  ],
  imports: [ CommonModule, KeycloakAngularModule, RouterModule.forChild(routes) ],
  exports: [],
  providers: [
    {
      provide: KeycloakService,
      useValue: keycloakService
    }
  ],
})
export class AdminModule {
  constructor() {
    keycloakService.init({
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
}
