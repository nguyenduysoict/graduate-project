import { BaseModel } from './base-model/base-model';

export class Item extends BaseModel {
  ItemID: string = "";
  ItemName: string = "";
  ItemGroupName: string = "";
  ItemGroupCode: string = "";
  SupplierName: string = "";
  SKUCode: string = "";
  BuyPrice: number;
  SellPrice: number;
  UnitName: string = "";
  ItemColor: string = "";
  ItemSize: string = "";
  ItemImage: any ="";
  Description: any ="";
}