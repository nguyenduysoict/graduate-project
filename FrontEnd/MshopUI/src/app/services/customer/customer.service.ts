import { Injectable } from '@angular/core';
import { BaseService } from '../base-service/base.service';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class CustomerService extends BaseService{ 
  controller = "Customer";
  customerList = [
    {id: 1,  customerName : "Nguyễn Mạnh Đức"},
    {id: 2, customerName : "Nguyễn Mạnh Duy"},
    {id: 3,  customerName : "Đoàn Văn Đức"},
    {id: 4,  customerName : "Đỗ Mạnh Quỳnh"},
    {id: 5,  customerName : "Phạm Mạnh Trọng"},
    {id: 6,  customerName : "Lê Mạnh Hoàn"},
  ]

  constructor(private http: HttpClient) {
    super(http);
  }

  getCustomers(){
    return this.customerList;
  }
}
