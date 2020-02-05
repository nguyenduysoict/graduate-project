import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ReportComponent } from './report.component';
import { SaleReportComponent } from './sale-report/sale-report.component';
import { StoreReportComponent } from './store-report/store-report.component';
import { MoneyReportComponent } from './money-report/money-report.component';


const routes: Routes = [
  {path: '', component: ReportComponent, 
    children: [
      { path: 'ban-hang', component: SaleReportComponent },
      { path: 'thu-chi', component: MoneyReportComponent },
      { path: 'kho', component: StoreReportComponent}
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReportRoutingModule { }
