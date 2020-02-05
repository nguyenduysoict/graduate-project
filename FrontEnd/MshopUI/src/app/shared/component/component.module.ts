import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoadingComponent } from './loading/loading.component';
import { PopupDeleteComponent } from './popup-delete/popup-delete.component';
import { DxPopupModule, DxButtonModule } from 'devextreme-angular';
import { ToastComponent } from './toast/toast.component';
import { PopupWarningComponent } from './popup-warning/popup-warning.component';



@NgModule({
  declarations: [
    LoadingComponent,
    PopupDeleteComponent,
    ToastComponent,
    PopupWarningComponent
  ],
  imports: [
    CommonModule,
    DxPopupModule,
    DxButtonModule
  ],
  exports:[
    LoadingComponent,
    PopupDeleteComponent,
    ToastComponent,
    PopupWarningComponent
  ]
})
export class ComponentModule { }
