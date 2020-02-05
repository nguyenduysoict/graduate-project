import { BaseModel } from '../base-model/base-model';
import { Inward } from './inward';
import { InwardDetail } from './inward-detail';

export class InwardObject extends BaseModel{
    Inward: Inward;
    InwardDetails: InwardDetail[];
}