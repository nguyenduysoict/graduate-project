import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SaleComponent } from './sale.component';
import { InvoiceComponent } from './invoice/invoice.component';
import { InvoiceGridComponent } from './invoice-grid/invoice-grid.component';


const routes: Routes = [
  {path: '', component: SaleComponent, children:[
    { path: 'lap-hoa-don', component: InvoiceComponent },
    { path: 'danh-sach-hoa-don', component: InvoiceGridComponent }
  ]}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SaleRoutingModule { }
