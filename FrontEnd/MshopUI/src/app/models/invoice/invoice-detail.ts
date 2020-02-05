import { BaseModel } from '../base-model/base-model';

export class InvoiceDetail extends BaseModel{
    InvoiceDetailID: string = "";
    InvoiceID: string ="";
    SKUCode: string ="";
    ShopID: string;
    ItemName: string ="";
    ItemGroupName: string ="";
    ItemGroupCode: string ="";
    Color: string ="";
    Size: string ="";
    Unit: string ="";
    UnitPrice: number;
    Amount: number;
    TotalMoney: number;
    CurrentItemID?: string;
    IsShow: boolean = false;
}