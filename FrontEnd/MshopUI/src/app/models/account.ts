import { BaseModel } from './base-model/base-model';

export class Account extends BaseModel{
    UserID: string;
    UserName: string;
    Password: string;
    ShopID?: string;
    StaffCode: string;
    StaffName: string;
    RoleType: number;
}