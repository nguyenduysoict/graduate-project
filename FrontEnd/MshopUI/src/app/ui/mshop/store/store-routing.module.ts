import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { StoreReportComponent } from '../report/store-report/store-report.component';
import { StoreComponent } from './store.component';
import { OutwardComponent } from './outward/outward.component';
import { InwardComponent } from './inward/inward.component';


const routes: Routes = [
  { path: '', component: StoreComponent,
    children: [
      { path: 'xuat-kho', component: OutwardComponent },
      { path: 'nhap-kho', component: InwardComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class StoreRoutingModule { }
