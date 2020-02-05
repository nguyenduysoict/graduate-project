import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SupplierRoutingModule } from './supplier-routing.module';
import { SuppilerComponent } from './suppiler.component';
import { NgZorroAntdModule } from 'ng-zorro-antd';
import { DxDateBoxModule, DxDataGridModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxButtonModule, DxNumberBoxModule, DxSelectBoxModule, DxTextAreaModule, DxToastModule, DxValidatorModule, DxCheckBoxModule } from 'devextreme-angular';
import { ComponentModule } from 'src/app/shared/component/component.module';


@NgModule({
  declarations: [SuppilerComponent],
  imports: [
    CommonModule,
    SupplierRoutingModule,
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
export class SupplierModule { }
