import { BaseModel } from '../base-model/base-model';

export class Receipt extends BaseModel{
      ReceiptID: string;
      ShopID: string;
          ReceiptNo : string;
          ReceiptDate : Date = new Date(); 
          ReceiptType : number;
          StaffName : string;
          StaffCode : string;
          AccountObjectPhone : string;
          AccountObjectName : string;
          Address :string;
          ReceiptReason :string;
          TotalMoney :number;
          IsSelected?: boolean = false;
}