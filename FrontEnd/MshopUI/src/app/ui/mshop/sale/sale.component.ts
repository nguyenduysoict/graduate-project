import { Component, OnInit } from '@angular/core';

interface Invoice {
  InvoiceDate: string;
  InvoiceNo: string;
  Employee: string;
  SumMoney: string;
  Description: string;
  Customer: string;
}


@Component({
  selector: 'app-sale',
  templateUrl: './sale.component.html',
  styleUrls: ['./sale.component.css']
})
export class SaleComponent implements OnInit {

  constructor() { }

  widthConfig = [
    "150px",
    "150px",
    "200px",
    "150px",
    "200px",
    ""
  ];
  scrollConfig = { y: "350px" };
  scrollDetailConfig = { y: "200px" };
  isShowPopup = true;


  listOfDisplayData: Invoice[] = [];
  listOfData: Invoice[] = [];
  ngOnInit() {
    for (let i = 0; i < 10; i++) {
      this.listOfData.push({
        InvoiceDate: "4/11/2019",
        InvoiceNo: "NK00562053",
        Employee: "Nguyễn Mạnh Duy",
        SumMoney: "150.000.000",
        Description: "Nhập kho trả hàng",
        Customer: "Nguyễn Chí Trung"
      });
    }
    this.listOfDisplayData = [...this.listOfData];
  }

  showAddInvoicePopup(){
    this.isShowPopup = true;
  }

}
