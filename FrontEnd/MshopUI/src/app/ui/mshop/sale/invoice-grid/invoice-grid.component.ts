import { Component, OnInit } from '@angular/core';
import { InvoiceService } from 'src/app/services/invoice/invoice.service';
import { CommonService } from 'src/app/services/common/common.service';
import { PeriodType } from 'src/app/services/common/enumeration/enumeration';
import { QueryCondition } from 'src/app/models/shared/query-condition';
import { PeriodList } from 'src/app/services/common/constant/constant';
import { TransferDataService } from 'src/app/services/transfer-data.service';

@Component({
  selector: 'app-invoice-grid',
  templateUrl: './invoice-grid.component.html',
  styleUrls: ['./invoice-grid.component.css']
})
export class InvoiceGridComponent implements OnInit {

  listOfDisplayData = [];
  listOfDetailData = [];
  startFilterDate: Date = new Date();
  endFilterDate: Date = new Date();
  constructor(
    private invoiceService: InvoiceService,
    private commonService: CommonService,
    private transferService: TransferDataService) { }

  widthMasterConfig = [
    "150px",
    "",
    "150px",
    "100px",
    "",
    "150px",
    "150px",
  ];

  scrollMasterConfig = [
    {y: "600px" }
  ]

  widthDetailConfig = [
      "150px",
      "",
      "100px",
      "70px",
      "150px",
      "150px",
      "150px",
      "200px",
  ]

  scrollDetailConfig = [
    {y: "180px" }
  ]

  currentShop = "";

  periods = [];
  selectedPeriodId : number; // ID kỳ báo cáo ;
  selectedPeriod = "";

  ngOnInit() {
    this.selectedPeriodId = 1;
    this.selectedPeriod = "Hôm nay";
    this.periods = PeriodList;
    this.currentShop = localStorage.getItem("ShopID");
    this.getInvoices();
    this.transferService.shopChange.subscribe(res=>{
      this.currentShop = res.ShopID;
      this.getInvoices();
    })
  }
  
  getInvoices(){
    var queryCondition = new QueryCondition();
    queryCondition.ShopID = this.currentShop;
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    this.listOfDetailData = [];
    this.invoiceService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      if(res && res.Success){
        this.listOfDisplayData = [...res.Data];
      }
    })
  }

    // sự kiện người dùng chọn khoảng thời gian trên filter
    onChangePeriod(filterPeriod) {
      if(filterPeriod){
        this.selectedPeriodId = filterPeriod.id;
        this.selectedPeriod = filterPeriod.periodName;
      }
      this.startFilterDate = this.commonService.getStartDate(this.selectedPeriodId);
      this.endFilterDate = this.commonService.getEndDate(this.selectedPeriodId);
    }

  onSelectMaster(invoiceID){
    this.invoiceService.getByFieldName(invoiceID).subscribe(res=>{
      if(res && res.Success){
        this.listOfDetailData = [...res.Data];
      }
    })
  }
}
