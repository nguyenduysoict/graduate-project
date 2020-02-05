import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { EmployeeRoutingModule } from './employee-routing.module';
import { EmployeeComponent } from './employee.component';
import { NgZorroAntdModule, NzRadioModule } from 'ng-zorro-antd';
import { DxDataGridModule, DxDateBoxModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxButtonModule, DxNumberBoxModule, DxSelectBoxModule, DxTextAreaModule, DxTabPanelModule, DxValidationGroupModule, DxValidatorModule } from 'devextreme-angular';
import { FormsModule } from '@angular/forms';
import { ComponentModule } from 'src/app/shared/component/component.module';


@NgModule({
  declarations: [
    EmployeeComponent
  ],
  imports: [
    CommonModule,
    EmployeeRoutingModule,
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
    DxTabPanelModule,
    DxRadioGroupModule,
    NzRadioModule,
    FormsModule,
    ComponentModule,
    DxValidationGroupModule,
    DxValidatorModule
  ]
})
export class EmployeeModule { }
