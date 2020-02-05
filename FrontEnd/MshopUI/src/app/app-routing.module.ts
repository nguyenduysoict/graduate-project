import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './ui/login/login.component';
import { NotFoundComponent } from './ui/not-found/not-found.component';


const routes: Routes = [
  { path: 'mshop', loadChildren: ()=>import('./ui/mshop/mshop.module').then(mod=>mod.MshopModule) },
  { path: 'login', component: LoginComponent },
  { path: '', redirectTo: 'mshop', pathMatch: 'full' },
  { path: '**', component: NotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
