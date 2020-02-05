import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { StoreRoutingModule } from './store-routing.module';
import { InwardComponent } from './inward/inward.component';
import { OutwardComponent } from './outward/outward.component';
import { StoreComponent } from './store.component';
import { NzIconModule, NgZorroAntdModule, NzRadioModule } from 'ng-zorro-antd';
import { DxDateBoxModule, DxDataGridModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxNumberBoxModule, DxSelectBoxModule } from 'devextreme-angular';
import { FormsModule } from '@angular/forms';
import { ComponentModule } from 'src/app/shared/component/component.module';
import { SharePipeModule } from 'src/app/shared/pipe/share-pipe.module';


@NgModule({
  declarations: [
    InwardComponent,
    OutwardComponent,
    StoreComponent,
  ],
  imports: [
    CommonModule,
    StoreRoutingModule,
    NzIconModule,
    NgZorroAntdModule,
    DxDateBoxModule,
    DxDataGridModule,
    DxPopupModule,
    DxRadioGroupModule,
    DxFormModule,
    DxTextBoxModule,
    NzRadioModule,
    FormsModule,
    DxNumberBoxModule,
    DxSelectBoxModule,
    ComponentModule,
    SharePipeModule

  ]
})
export class StoreModule { }
