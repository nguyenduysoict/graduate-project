import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ReportRoutingModule } from './report-routing.module';
import { ReportComponent } from './report.component';
import { SaleReportComponent } from './sale-report/sale-report.component';
import { StoreReportComponent } from './store-report/store-report.component';
import { DxDataGridModule, DxTemplateModule, DxDateBoxModule, DxPopupModule, DxSelectBoxModule } from 'devextreme-angular';
import { NzDropDownModule, NzIconModule, NgZorroAntdModule, NzSelectModule } from 'ng-zorro-antd';
import { FormsModule } from '@angular/forms';
import { ComponentModule } from 'src/app/shared/component/component.module';
import { SharePipeModule } from 'src/app/shared/pipe/share-pipe.module';
import { MoneyReportComponent } from './money-report/money-report.component';


@NgModule({
  declarations: [
    ReportComponent,
    SaleReportComponent,
    StoreReportComponent,
    MoneyReportComponent,
  ],
  imports: [
    CommonModule,
    ReportRoutingModule,
    DxDataGridModule,
    NzIconModule,
    NzSelectModule,
    NgZorroAntdModule,
    DxDateBoxModule,
    DxTemplateModule,
    NzDropDownModule,
    DxPopupModule,
    FormsModule,
    DxSelectBoxModule,
    ComponentModule,
    SharePipeModule
  ]
})
export class ReportModule { }
