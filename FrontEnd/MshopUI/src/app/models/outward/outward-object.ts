import { BaseModel } from '../base-model/base-model';
import { Outward } from './Outward';
import { OutwardDetail } from './outward-detail';

export class OutwardObject extends BaseModel{
    Outward: Outward;
    OutwardDetails: OutwardDetail[];
}