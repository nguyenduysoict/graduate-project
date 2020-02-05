import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SuppilerComponent } from './suppiler.component';


const routes: Routes = [
  {path: '', component: SuppilerComponent}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SupplierRoutingModule { }
