import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MshopComponent } from './mshop.component';
import { MshopRoutingModule } from './mshop-routing.module';
import { NgZorroAntdModule } from 'ng-zorro-antd';
import { DxToastModule } from 'devextreme-angular';

@NgModule({
  declarations: [
    MshopComponent,
  ],
  imports: [
    CommonModule,
    MshopRoutingModule,
    NgZorroAntdModule,
    DxToastModule
  ]
})
export class MshopModule { }
