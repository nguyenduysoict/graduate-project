import { Injectable } from "@angular/core";
import { BaseService } from '../base-service/base.service';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: "root"
})
export class SaleReportService extends BaseService{
  controller = "SaleReport";
  constructor(private http: HttpClient) {super(http)}
}