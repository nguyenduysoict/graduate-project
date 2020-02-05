import { BaseModel } from '../base-model/base-model';
import { Receipt } from './receipt';
import { ReceiptDetail } from './receipt-detail';

export class ReceiptObject extends BaseModel {
    Receipt: Receipt;
    ReceiptDetails: ReceiptDetail[]; 
}