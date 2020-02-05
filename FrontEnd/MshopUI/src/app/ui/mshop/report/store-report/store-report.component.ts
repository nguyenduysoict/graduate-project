import { Component, OnInit } from "@angular/core";
import { GoodsGroup } from 'src/app/models/good-group';
import { GoodsGroupService } from 'src/app/services/goods/goods-group.service';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { PeriodList } from 'src/app/services/common/constant/constant';
import { QueryCondition } from 'src/app/models/shared/query-condition';
import { ShopService } from 'src/app/services/shop/shop.service';
import { CommonService } from 'src/app/services/common/common.service';
import { StoreReportService } from 'src/app/services/report/store-report.service';
import { StaffService } from 'src/app/services/staff/staff.service';
import { Staff } from 'src/app/models/staff';
import { Shop } from 'src/app/models/shop';
import { StoreReport } from 'src/app/models/store-report/store-report';

@Component({
  selector: "app-store-report",
  templateUrl: "./store-report.component.html",
  styleUrls: ["./store-report.component.css"]
})
export class StoreReportComponent implements OnInit {
  widthConfig = [
    "150px",
    "200px",
    "100px",
    "200px",
    "100px",
    "150px",
    "100px",
    "150px",
    "100px",
    "150px",
    "100px",
    "150px",
  ];
  scrollConfig = { x: "1650px", y: "450px" };
  listOfDisplayData: StoreReport [];
  listOfData: [];
  storeReportData: StoreReport[] = [];

  currentShopName = "";
  selectedItem = "";
  isShowPopup = false;

  shopList = [];
  currentSelectedShop= "";
  periods = [];
  selectedPeriodId : number; // ID kỳ báo cáo ;
  selectedPeriod = "";
  isLoading = true;
  startFilterDate: Date = new Date();
  endFilterDate: Date = new Date();

  constructor(
    private itemGroupService: GoodsGroupService,
    private transferService: TransferDataService,
    private shopService: ShopService,
    private commonService: CommonService,
    private storeReportService: StoreReportService,
  ) {}

  ngOnInit() {
    this.currentShopName = localStorage.getItem("currentShop");
    this.currentSelectedShop = localStorage.getItem("ShopID");
    this.selectedPeriodId = 1;
    this.selectedPeriod = "Hôm nay";
    this.periods = PeriodList;
    this.getDataByQueryCondition();
    this.transferService.shopChange.subscribe(res=>{
      this.currentSelectedShop = res.ShopID;
      this.currentShopName = res.ShopName;
      this.getDataByQueryCondition();
    })
  }


  getDataByQueryCondition(){
    this.isLoading = true;
    const queryCondition = new QueryCondition();
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    if(this.currentSelectedShop){
      queryCondition.ShopID = this.currentSelectedShop;
      const shop = this.shopList.find(item => item.ShopID == this.currentSelectedShop);
      if(shop){
        this.currentShopName = shop.ShopName;
      }
    }
    this.storeReportService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      if(res && res.Success && res.Data){
        console.log(res.Data);
        this.isLoading = false;
        this.handleDisplayAfterGetData(res.Data);
      } else {
        this.transferService.showToast(false);
      }
    })
  }

  onChangePeriod(filterPeriod) {
    if(filterPeriod.value){
      this.selectedPeriodId = filterPeriod.value;
      this.selectedPeriod = this.periods.find(item=>item.id == filterPeriod.value).periodName;
    } else {
      this.selectedPeriodId = filterPeriod.id;
      this.selectedPeriod = filterPeriod.periodName;
    }
    this.startFilterDate = this.commonService.getStartDate(this.selectedPeriodId);
    this.endFilterDate = this.commonService.getEndDate(this.selectedPeriodId);
  }


  handleDisplayAfterGetData(data){
    this.storeReportData = [];
    if(data){
      for (let i = 0; i < data.PreStoreAmount.length; i++) {
        const element = data.PreStoreAmount[i];
        var item = new StoreReport();
        item.SKUCode = element.SKUCode;
        item.ItemName = element.ItemName;
        item.Unit = element.Unit;
        item.ItemGroupName = element.ItemGroupName;
        item.PreAmount = (element.InAmount - element.OutAmount);
        item.PreValue = item.PreAmount * element.UnitPrice;
        this.storeReportData.push(item);
      }

      for (let j = 0; j < data.CurrentStoreAmount.length; j++) {
        const element = data.CurrentStoreAmount[j];
        var index = this.storeReportData.findIndex(item => item.SKUCode == element.SKUCode);
        if(index<0){
          var item = new StoreReport();
          item.SKUCode = element.SKUCode;
          item.ItemName = element.ItemName;
          item.Unit = element.Unit;
          item.ItemGroupName = element.ItemGroupName;
          item.InCurrentAmount = element.InAmount;
          item.InCurrentValue = element.InAmount * element.UnitPrice;
          item.OutCurrentAmount = element.OutAmount;
          item.OutCurrentValue = element.OutAmount * element.UnitPrice;
          this.storeReportData.push(item);
        } else {
          this.storeReportData[index].InCurrentAmount = element.InAmount;
          this.storeReportData[index].InCurrentValue = element.InAmount * element.UnitPrice;
          this.storeReportData[index].OutCurrentAmount = element.OutAmount;
          this.storeReportData[index].OutCurrentValue = element.OutAmount * element.UnitPrice;
        }
      }
      this.listOfDisplayData = [...this.storeReportData];
    }
  }

   // lấy danh sách cửa hàng
   getShop(){
    this.shopService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.shopList = res.Data;
        var allOption = new Shop();
        allOption.ShopName = "Tất cả cửa hàng";
        this.shopList.unshift(allOption);
      }
    })
  }

  
  showChooseReportPopup(){
    this.isShowPopup = true;
    this.getShop();
  }

  onCancel(){
    this.isShowPopup = false;
  }
}
