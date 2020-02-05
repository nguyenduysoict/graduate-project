import { BaseModel } from '../base-model/base-model';

export class InwardDetail extends BaseModel{
      InwardDetailID: string = "";
          InwardID: string ="";
          ShopID: string;
          SKUCode: string ="";
          ItemName: string ="";
          ItemGroupName: string = "";
          ItemGroupCode: string = "";
          FromShop: string ="";
          Amount: number;
          Unit: string = "";
          UnitPrice: number;
          TotalMoney: number;
          IsShow : boolean = true;
}