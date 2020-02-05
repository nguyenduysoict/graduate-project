import { BaseModel } from '../base-model/base-model';

export class Outward extends BaseModel{
        OutwardID: string = "";
        OutwardNo: string = "";
        OutwardDate: Date = new Date();
        ShopID: string ="";
        TotalMoney: number;
        OutStaffName: string = "";
        OutStaffCode: string ="";
        InStaffName: string ="";
        InStaffCode: string ="";
        Deliver: string ="";
        Description: string="";
        IsSelected?: boolean = false;
}