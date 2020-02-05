import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { OverviewRoutingModule } from './overview-routing.module';
import { OverviewComponent } from './overview.component';
import { NzGridModule, NgZorroAntdModule } from 'ng-zorro-antd';
import { DxChartModule, DxPieChartModule } from 'devextreme-angular';
import { ComponentModule } from 'src/app/shared/component/component.module';

@NgModule({
  declarations: [
    OverviewComponent
  ],
  imports: [
    CommonModule,
    OverviewRoutingModule,
    NzGridModule,
    NgZorroAntdModule,
    DxChartModule,
    DxPieChartModule,
    ComponentModule
  ]
})
export class OverviewModule { }
