import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MakePositivePipe } from './make-positive.pipe';
import { MoneyPipe } from './money.pipe';



@NgModule({
  declarations: [
    MakePositivePipe,
    MoneyPipe
  ],
  imports: [
    CommonModule
  ],
  exports: [
    MakePositivePipe,
    MoneyPipe
  ]
})
export class SharePipeModule { }
