import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { GoodsComponent } from './goods.component';
import { GoodsListComponent } from './goods-list/goods-list.component';
import { GoodsGroupComponent } from './goods-group/goods-group.component';
import { UnitComponent } from './unit/unit.component';


const routes: Routes = [
  {path: '', component: GoodsComponent, children: [
    { path: '', component: GoodsListComponent },
    { path: 'nhom-hang-hoa', component: GoodsGroupComponent },
    { path: 'don-vi-tinh', component: UnitComponent },
  ]}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class GoodsRoutingModule { }
