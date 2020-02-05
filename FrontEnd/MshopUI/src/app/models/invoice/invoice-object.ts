import { BaseModel } from '../base-model/base-model';
import { Invoice } from './invoice';
import { InvoiceDetail } from './invoice-detail';

export class InvoiceObject extends BaseModel{
    Invoice: Invoice;
    InvoiceDetails: InvoiceDetail[];
}