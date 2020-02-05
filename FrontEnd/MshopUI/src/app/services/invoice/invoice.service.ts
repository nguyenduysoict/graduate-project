import { Injectable } from '@angular/core';
import { BaseService } from '../base-service/base.service';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class InvoiceService extends BaseService {

  controller = "Invoice";
  constructor(private http: HttpClient) { super(http); }
}
