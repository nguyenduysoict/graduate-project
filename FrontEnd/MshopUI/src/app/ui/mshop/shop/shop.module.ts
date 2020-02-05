import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ShopRoutingModule } from './shop-routing.module';
import { ShopComponent } from './shop.component';
import { ComponentModule } from 'src/app/shared/component/component.module';
import { NgZorroAntdModule } from 'ng-zorro-antd';
import { DxDateBoxModule, DxDataGridModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxButtonModule, DxNumberBoxModule, DxSelectBoxModule, DxTextAreaModule, DxToastModule, DxValidatorModule, DxCheckBoxModule } from 'devextreme-angular';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [ShopComponent],
  imports: [
    CommonModule,
    ShopRoutingModule,
    DxDateBoxModule,
    DxDataGridModule,
    DxPopupModule,
    DxRadioGroupModule,
    NgZorroAntdModule,
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
    DxCheckBoxModule,
    FormsModule
  ]
})
export class ShopModule { }
