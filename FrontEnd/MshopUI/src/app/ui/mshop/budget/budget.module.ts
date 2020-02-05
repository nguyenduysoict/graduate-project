import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { BudgetRoutingModule } from './budget-routing.module';
import { IncomeComponent } from './income/income.component';
import { BudgetComponent } from './budget.component';
import { NzIconModule, NgZorroAntdModule, NzRadioModule } from 'ng-zorro-antd';
import { DxDateBoxModule, DxDataGridModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxNumberBoxModule, DxSelectBoxModule } from 'devextreme-angular';
import { FormsModule } from '@angular/forms';
import { ComponentModule } from 'src/app/shared/component/component.module';


@NgModule({
  declarations: [
    IncomeComponent,
    BudgetComponent
  ],
  imports: [
    CommonModule,
    BudgetRoutingModule,
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
    ComponentModule
  ]
})
export class BudgetModule { }
