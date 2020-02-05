import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { GoodsRoutingModule } from './goods-routing.module';
import { GoodsGroupComponent } from './goods-group/goods-group.component';
import { GoodsListComponent } from './goods-list/goods-list.component';
import { UnitComponent } from './unit/unit.component';
import { GoodsComponent } from './goods.component';
import { NgZorroAntdModule } from 'ng-zorro-antd';
import { DxDateBoxModule, DxDataGridModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxButtonModule, DxNumberBoxModule, DxSelectBoxModule, DxTextAreaModule, DxToastModule, DxValidatorModule, DxCheckBoxModule, DxValidationGroupModule } from 'devextreme-angular';
import { ComponentModule } from 'src/app/shared/component/component.module';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [GoodsComponent, GoodsGroupComponent, GoodsListComponent, UnitComponent],
  imports: [
    GoodsRoutingModule,
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
    DxCheckBoxModule,
    DxValidationGroupModule
  ]
})
export class GoodsModule { }
