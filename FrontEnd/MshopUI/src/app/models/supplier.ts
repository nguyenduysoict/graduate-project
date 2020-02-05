import { BaseModel } from './base-model/base-model';

export class Supplier extends BaseModel{
    SupplierID: string;
    SupplierCode: string;
    SupplierName: string;
    SupplierPhone: string;
    SupplierAddress: string;
    BankAccount: string;
    BankName: string;
    BankBranch: string;
    ContactName: string;
    ContactPhone: string;
    ContactEmail: string;
    ContactAddress: string;
}