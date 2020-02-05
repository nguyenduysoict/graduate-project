import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SaleRoutingModule } from './sale-routing.module';
import { SaleComponent } from './sale.component';
import { NzIconModule, NgZorroAntdModule } from 'ng-zorro-antd';
import { DxPopupModule, DxTextBoxModule, DxSelectBoxModule, DxDateBoxModule, DxNumberBoxModule, DxRadioGroupModule } from 'devextreme-angular';
import { InvoiceComponent } from './invoice/invoice.component';
import { InvoiceGridComponent } from './invoice-grid/invoice-grid.component';
import { ComponentModule } from 'src/app/shared/component/component.module';
import { SharePipeModule } from 'src/app/shared/pipe/share-pipe.module';


@NgModule({
  declarations: [
    SaleComponent,
    InvoiceComponent,
    InvoiceGridComponent
  ],
  imports: [
    CommonModule,
    SaleRoutingModule,
    NzIconModule,
    NgZorroAntdModule,
    DxPopupModule,
    DxTextBoxModule,
    DxSelectBoxModule,
    DxDateBoxModule,
    ComponentModule,
    DxNumberBoxModule,
    DxRadioGroupModule,
    SharePipeModule

  ]
})
export class SaleModule { }
