import { Component, OnInit, OnDestroy } from "@angular/core";
import { OverviewService } from "src/app/services/overview/overview.service";
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { CommonService } from 'src/app/services/common/common.service';
import { PeriodList, MonthSelections } from 'src/app/services/common/constant/constant';
import { QueryCondition } from 'src/app/models/shared/query-condition';
import { PeriodType, OverviewDataType } from 'src/app/services/common/enumeration/enumeration';

@Component({
  selector: "app-overview",
  templateUrl: "./overview.component.html",
  styleUrls: ["./overview.component.css"]
})
export class OverviewComponent implements OnInit, OnDestroy {
  today = new Date();

  shopName = "";
  shopID = "";
  isLoading = true;
  selectedPeriod1 = "Tháng này";
  selectedPeriod2 = "Tháng này";
  selectedPeriod3 = "Tháng này";
  selectedPeriod4 = "Tháng này";
  startFilterDate : Date = new Date();
  endFilterDate : Date = new Date();
  incomeData = [];
  incomeDataByDay = [];
  incomeByItemValue = [];
  incomeByItemAmount = [];

  subList = [];
  periods = [];
  

  constructor(private overviewService: OverviewService,
            private transferDataService: TransferDataService,
            private commonService: CommonService
            ) {
  }
 

  ngOnInit() {
    this.shopID = localStorage.getItem("ShopID");
    this.periods = PeriodList;
    this.startFilterDate = this.commonService.getStartDate(PeriodType.ThisMonth);
    this.endFilterDate = this.commonService.getEndDate(PeriodType.ThisMonth);
    const sub = this.transferDataService.shopChange.subscribe(res=>{
        this.shopID = localStorage.getItem("ShopID");
        this.getIncomeData();
        this.getIncomeDataByDay();
        this.getIncomeByItemValue();
        this.getIncomeByItemAmount();
    });
    this.getIncomeData();
    this.getIncomeDataByDay();
    this.getIncomeByItemValue();
    this.getIncomeByItemAmount();
  }

  getIncomeData(){
    var queryCondition = new QueryCondition();
    queryCondition.ReportType = OverviewDataType.IncomeData;
    queryCondition.ShopID = this.shopID;
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    this.overviewService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      this.isLoading = false
      if(res && res.Success){
        this.incomeData = [];
        var data = {
          state: "",
          income: res.Data[0].Income,
          outcome: res.Data[0].Outcome,
          profits: res.Data[0].Income - res.Data[0].Outcome
        }
        this.incomeData.push(data);
      }
    })
  }

  getIncomeDataByDay(){
    var queryCondition = new QueryCondition();
    queryCondition.ReportType = OverviewDataType.IncomeDataByDay;
    queryCondition.ShopID = this.shopID;
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    this.overviewService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      this.isLoading = false
      if(res && res.Success){
        this.incomeDataByDay = []
        for (let i = 1; i < 31; i++) {
          var data;
          var item = res.Data.find(item => (new Date(item.InvoiceDate).getDate()) == i);
          if(item){
            data = {
              day: i,
              val: item.TotalMoney
            }
          } else {
            data = {
              day: i,
              val: 0
            }
          }
          this.incomeDataByDay.push(data);
        }
      }
    })
  }

  getIncomeByItemValue(){
    var queryCondition = new QueryCondition();
    queryCondition.ReportType = OverviewDataType.IncomeByItemValue;
    queryCondition.ShopID = this.shopID;
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    this.overviewService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      this.isLoading = false
      console.log(res.Data);
      if(res && res.Success){
        this.incomeByItemValue = [];
        if(res.Data.length){
          var sumValue = 0;
          for (let i = 0; i < res.Data.length; i++) {
            const element = res.Data[i];
            sumValue += element.TotalMoney;
            var item = {
              ItemName: element.ItemName,
              Percentage: ""
            }
            this.incomeByItemValue.push(item);
          }
          for (let j = 0; j < res.Data.length; j++) {
            const element = res.Data[j];
            var percentage = ((element.TotalMoney/sumValue) * 100).toFixed(2);
            this.incomeByItemValue[j].Percentage = percentage;
          }
        }
      }
    })
  }

  getIncomeByItemAmount(){
    var queryCondition = new QueryCondition();
    queryCondition.ReportType = OverviewDataType.IncomeByItemAmount;
    queryCondition.ShopID = this.shopID;
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    this.overviewService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      this.isLoading = false

      console.log(res.Data);
      if(res && res.Success){
        this.incomeByItemAmount = res.Data;
      }
    })
  }


 
  onChangePeriod1(filterPeriod) {
    this.selectedPeriod1 = filterPeriod.periodName;
    this.startFilterDate = this.commonService.getStartDate(filterPeriod.id);
    this.endFilterDate = this.commonService.getEndDate(filterPeriod.id);
    this.getIncomeData();
  }

  onChangePeriod2(filterPeriod) {
    this.selectedPeriod2 = filterPeriod.periodName;
    this.startFilterDate = this.commonService.getStartDate(filterPeriod.id);
    this.endFilterDate = this.commonService.getEndDate(filterPeriod.id);
    this.getIncomeDataByDay();
  }

  onChangePeriod3(filterPeriod) {
    this.selectedPeriod3 = filterPeriod.periodName;
    this.startFilterDate = this.commonService.getStartDate(filterPeriod.id);
    this.endFilterDate = this.commonService.getEndDate(filterPeriod.id);
    this.getIncomeByItemAmount();
  }

  onChangePeriod4(filterPeriod) {
    this.selectedPeriod4 = filterPeriod.periodName;
    this.startFilterDate = this.commonService.getStartDate(filterPeriod.id);
    this.endFilterDate = this.commonService.getEndDate(filterPeriod.id);
    this.getIncomeByItemValue();
  }

  customizePoint (pointInfo: any) {
    console.log(pointInfo);
    // return pointInfo.value > 1 ? { color: 'red' } : { }
  };



  onPointClick(e) {
    e.target.select();
  }
  
  pointClickHandler(e) {
    this.toggleVisibility(e.target);
  }

  legendClickHandler(e) {
    let arg = e.target,
      item = e.component.getAllSeries()[0].getPointsByArg(arg)[0];
    this.toggleVisibility(item);
  }

  toggleVisibility(item) {
    if (item.isVisible()) {
      item.hide();
    } else {
      item.show();
    }
  }

  ngOnDestroy(){
    this.subList.forEach(sub => {
      sub.unsubscribe();
    });
  }


}
