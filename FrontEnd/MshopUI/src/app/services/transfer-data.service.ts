import { Injectable, Output, EventEmitter } from '@angular/core';
import { Toast } from '../models/shared/toast';

@Injectable({
  providedIn: 'root'
})
export class TransferDataService {


  //Hàm xử lý khi chọn lại cửa hàng 
  @Output() shopChange = new EventEmitter();
  changeShop(shop){
    this.shopChange.emit(shop);
  }

  @Output() toastShow = new EventEmitter();
  showToast(isSuccess: boolean, message?: string){
    if(message){
      if(isSuccess){
        var toast = new Toast("success", message);
      } else {
        var toast = new Toast("error", message);
      }
      this.toastShow.emit(toast);
    } else {
      this.toastShow.emit(isSuccess);
    }
  }
  
  constructor() { }
}
