import { BaseModel } from './base-model/base-model';
import { Status } from '../services/common/enumeration/enumeration';

export class Unit extends BaseModel{
    UnitID: string;
    UnitName: string = "";
    Status: Status = 0;
    Description: string = "";
    constructor(){
        super();
    }
}