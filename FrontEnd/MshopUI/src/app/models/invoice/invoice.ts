import { BaseModel } from '../base-model/base-model';

export class Invoice extends BaseModel {
    InvoiceID: string;
    ShopID: string;
    InvoiceNo: string;
    StaffCode: string;
    StaffName: string;
    CustomerPhone: string;
    IsCash: boolean = true;
    Description: number;
    CustomerAddress: string;
    CustomerName: string;
    InvoiceDate?: Date = new Date();
    TotalMoney: number = 0;
}