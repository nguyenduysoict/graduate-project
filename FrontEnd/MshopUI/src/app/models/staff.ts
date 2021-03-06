import { BaseModel } from './base-model/base-model';

export class Staff extends BaseModel{
      StaffID : string = "";
      StaffCode: string = "";
      StaffName: string = "";
      ShopID: string = "";
      Password: string = "123456";
      Birthday?: Date ;
      Gender :string = "Nam";
      RoleType : number = 1;
      IdentityNumber: string = "";
      DateOfIssued?: Date ;
      PlaceOfIssued: string = "";
      Avatar : string= "";
      TimeWorkingStatus :string= "";
      MobilePhone : string= "";
      HomePhone : string= "";
      Email : string= "";
      RegularAddress : string= "";
      RegularNation : string= "Việt Nam";
      RegularProvince : string= "";
      RegularDistrict : string= "";
      RegularTown : string= "";
      RecentAddress : string= "";
      RecentNation : string= "Việt Nam";
      RecentProvince : string= "";
      RecentDistrict : string= "";
      RecentTown : string= "";
      EmerContactName : string= "";
      EmerContactRelation : string= "";
      EmerContactMobilePhone : string= "";
      EmerContactHomePhone : string= "";
      EmerContactEmail : string= "";
      EmerContactAddress : string= "";
      Salary : string= "";
      WokingStatus: string= "";
      TryingWorkFrom?: Date  ;
      TryingWorkTo? : Date ;
      OffcialWorkFrom? :Date;
      OffcialWorkTo? : Date;
}