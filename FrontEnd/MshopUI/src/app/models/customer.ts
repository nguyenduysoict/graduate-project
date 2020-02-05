import { BaseModel } from './base-model/base-model';

export class Customer extends BaseModel{
    CustomerID: string ="";
    CustomerName: string ="";
    CustomerAddress: string = "";
    PhoneNumber: string = "";
    Email: string =" ";
    Birthday?:Date;
}