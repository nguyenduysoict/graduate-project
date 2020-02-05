import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SettingsRoutingModule } from './settings-routing.module';
import { SettingsComponent } from './settings.component';
import { NgZorroAntdModule, NzRadioModule } from 'ng-zorro-antd';
import { DxDateBoxModule, DxDataGridModule, DxPopupModule, DxRadioGroupModule, DxFormModule, DxTextBoxModule, DxButtonModule, DxNumberBoxModule, DxSelectBoxModule, DxTextAreaModule, DxTabPanelModule } from 'devextreme-angular';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    SettingsComponent
  ],
  imports: [
    CommonModule,
    SettingsRoutingModule,
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
    FormsModule
  ]
})
export class SettingsModule { }
