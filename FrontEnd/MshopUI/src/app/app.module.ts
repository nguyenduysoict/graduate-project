import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { NgZorroAntdModule, NZ_I18N, en_US } from 'ng-zorro-antd';
import { AppComponent } from './app.component';

import { registerLocaleData } from '@angular/common';
import en from '@angular/common/locales/en';
import { LoginComponent } from './ui/login/login.component';
import { NotFoundComponent } from './ui/not-found/not-found.component';
import { AppRoutingModule } from './app-routing.module';
import { ComponentModule } from './shared/component/component.module';
import { DxToastModule } from 'devextreme-angular';
registerLocaleData(en);

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    NotFoundComponent,
  ],
  imports: [
    AppRoutingModule,
    BrowserModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    ReactiveFormsModule,
    NgZorroAntdModule,
    ComponentModule,
    DxToastModule
  ],
  bootstrap: [ AppComponent ],
  providers   : [
    { provide: NZ_I18N, useValue: en_US }
  ]
})
export class AppModule { }