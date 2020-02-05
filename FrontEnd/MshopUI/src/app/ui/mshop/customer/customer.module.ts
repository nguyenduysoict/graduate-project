import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CustomerRoutingModule } from './customer-routing.module';
import { CustomerComponent } from './customer.component';
import { NgZorroAntdModule } from 'ng-zorro-antd';
import { DxDateBoxModule, DxDataGridModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxButtonModule, DxNumberBoxModule, DxSelectBoxModule, DxTextAreaModule, DxToastModule, DxValidatorModule, DxCheckBoxModule } from 'devextreme-angular';
import { ComponentModule } from 'src/app/shared/component/component.module';


@NgModule({
  declarations: [CustomerComponent],
  imports: [
    CustomerRoutingModule,
    CommonModule,
    NgZorroAntdModule,
    DxDateBoxModule,
    DxDataGridModule,
    DxPopupModule,
    DxRadioGroupModule,
    DxFormModule,
    DxTextBoxModule,
    DxButtonModule,
    DxNumberBoxModule,
    DxSelectBoxModule,
    DxTextAreaModule,
    DxPopupModule,
    ComponentModule,
    DxToastModule,
    DxValidatorModule,
    DxCheckBoxModule
  ]
})
export class CustomerModule { }
