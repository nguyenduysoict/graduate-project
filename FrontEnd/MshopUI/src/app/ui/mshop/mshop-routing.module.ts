import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MshopComponent } from './mshop.component';


const routes: Routes = [
  { path: '', component: MshopComponent,
    children:[
      { path: 'tong-quan', loadChildren: ()=>import('../mshop/overview/overview.module').then(mod=>mod.OverviewModule) },
      { path: 'bao-cao', loadChildren: ()=>import('../mshop/report/report.module').then(mod=>mod.ReportModule) },
      { path: 'kho', loadChildren: ()=>import('../mshop/store/store.module').then(mod=>mod.StoreModule) },
      { path: 'quy-tien', loadChildren: ()=>import('../mshop/budget/budget.module').then(mod=>mod.BudgetModule) },
      { path: 'hang-hoa', loadChildren: ()=>import('../mshop/goods/goods.module').then(mod=>mod.GoodsModule) },
      { path: 'khach-hang', loadChildren: ()=>import('../mshop/customer/customer.module').then(mod=>mod.CustomerModule) },
      { path: 'cua-hang', loadChildren: ()=>import('../mshop/shop/shop.module').then(mod=>mod.ShopModule) },
      { path: 'nhan-vien', loadChildren: ()=>import('../mshop/employee/employee.module').then(mod=>mod.EmployeeModule) },
      { path: 'nha-cung-cap', loadChildren: ()=>import('../mshop/suppiler/supplier.module').then(mod=>mod.SupplierModule) },
      { path: 'ban-hang', loadChildren: ()=>import('../mshop/sale/sale.module').then(mod=>mod.SaleModule) },
      { path: 'tra-cuu-luong', loadChildren: ()=>import('../mshop/salary/salary.module').then(mod=>mod.SalaryModule) },
      { path: 'thiet-lap', loadChildren: ()=>import('../mshop/settings/settings.module').then(mod=>mod.SettingsModule) },
      { path: '', redirectTo: 'tong-quan', pathMatch: 'full' },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MshopRoutingModule { }
