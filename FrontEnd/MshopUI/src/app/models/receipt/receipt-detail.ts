import { BaseModel } from '../base-model/base-model';

export class ReceiptDetail extends BaseModel{
      ReceiptDetailID : string;
      ReceiptID : string;
      ShopID: string;
      ReceiptCategory :string = "";
      Description : string;
      Money : number;
      IsShow : boolean = true;
}