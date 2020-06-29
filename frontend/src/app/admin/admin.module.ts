import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { KeycloakAngularModule } from 'keycloak-angular';
import { AdminComponent } from './admin/admin.component';
import { Routes, RouterModule } from '@angular/router';
import { AdminService } from './admin/admin.service';
import { AdminGuard } from './admin.guard';

const routes: Routes = [
  { path: '', component: AdminComponent, canActivate: [AdminGuard] }
];

@NgModule({
  declarations: [
    AdminComponent
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes) ],
  exports: [],
  providers: [
    AdminService,
    AdminGuard
  ],
})
export class AdminModule {
  constructor() {

  }
}
