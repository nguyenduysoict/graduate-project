import { BaseModel } from './base-model/base-model';

export class GoodsGroup extends BaseModel{
    ItemGroupID: string;
    ItemGroupCode: string;
    ItemGroupName: string;
    Description: string;
    Status: boolean;
    constructor(){
        super();
        this.Status = true;
    }
}