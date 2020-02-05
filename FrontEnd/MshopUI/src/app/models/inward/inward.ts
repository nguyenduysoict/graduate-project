import { BaseModel } from '../base-model/base-model';

export class Inward extends BaseModel{
        InwardID: string = "";
        InwardNo: string = "";
        InwardDate: Date = new Date();
        ShopID: string ="";
        TotalMoney: number;
        OutStaffName: string = "";
        IsFromSupplier: boolean = false;
        OutStaffCode: string ="";
        InStaffName: string ="";
        InStaffCode: string ="";
        Deliver: string ="";
        Description: string="";
        IsSelected?: boolean = false;
}