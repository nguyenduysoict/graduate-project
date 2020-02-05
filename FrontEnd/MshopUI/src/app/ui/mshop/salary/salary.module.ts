import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SalaryRoutingModule } from './salary-routing.module';
import { SalaryComponent } from './salary.component';
import { NgZorroAntdModule, NzRadioModule } from 'ng-zorro-antd';
import { DxDateBoxModule, DxDataGridModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxButtonModule, DxNumberBoxModule, DxSelectBoxModule, DxTextAreaModule, DxTabPanelModule, DxChartModule, DxSchedulerModule } from 'devextreme-angular';
import { FormsModule } from '@angular/forms';
import { SharePipeModule } from 'src/app/shared/pipe/share-pipe.module';


@NgModule({
  declarations: [
    SalaryComponent
  ],
  imports: [
    CommonModule,
    SalaryRoutingModule,
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
    DxChartModule,
    DxSchedulerModule,
    SharePipeModule

  ]
})
export class SalaryModule { }
