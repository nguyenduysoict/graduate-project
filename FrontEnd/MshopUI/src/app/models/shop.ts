import { BaseModel } from './base-model/base-model';

export class Shop extends BaseModel{
    ShopID: string = "";
    ShopCode: string ="";
    ShopName: string ="";
    Address: string ="";
    PhoneNumber:string="";
}
