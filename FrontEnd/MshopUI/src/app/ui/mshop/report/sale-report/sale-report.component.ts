import { Component, OnInit } from "@angular/core";
import { StaffService } from "src/app/services/staff/staff.service";
import { SaleReportType, PeriodList, StatisticsByItem } from 'src/app/services/common/constant/constant';
import { SaleReport } from 'src/app/services/common/enumeration/enumeration';
import { ShopService } from 'src/app/services/shop/shop.service';
import { CommonService } from 'src/app/services/common/common.service';
import { QueryCondition } from 'src/app/models/shared/query-condition';
import { SaleReportService } from 'src/app/services/report/sale-report.service';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { SaleByDay } from 'src/app/models/sale-report/sale-by-day';
import { IncomeByItem } from 'src/app/models/sale-report/income-by-item';
import { IncomeByGroupItem } from 'src/app/models/sale-report/income-by-group-item';
import { IncomeByStaff } from 'src/app/models/sale-report/income-by-staff';
import { InvoiceAndItemTable } from 'src/app/models/sale-report/invoice-and-item-table';
import { Shop } from 'src/app/models/shop';

@Component({
  selector: "app-sale-report",
  templateUrl: "./sale-report.component.html",
  styleUrls: ["./sale-report.component.css"]
})
export class SaleReportComponent implements OnInit {
  
  isLoading = true; //Biến show loading

  saleByDayData :SaleByDay[] = []; // Mảng dữ liệu tổng hợp bán hàng theo ngày
  isSaleByDay = true; //Biến check bảng dữ liệu hiện tại là kiểu báo cáo nào

  incomeByItemData: IncomeByItem [] = [];
  isIncomeByItem = false;

  incomeByGroupItemData: IncomeByGroupItem [] = [];
  isIncomeByGroupItem = false;

  incomeByStaffData: IncomeByStaff [] = [];
  isIncomeByStaff = false;

  invoiceAndItemData: InvoiceAndItemTable [] = [];
  isInvoiceAndItem = false;

  isShowPopup = false //tham số mới;
  reportName = "" //Chi nhánh cửa hàng;
  shopName = "" //Tên cửa hàng ; 
  selectedPeriod : string; // Tên kỳ báo cáo;
  selectedPeriodId : number; // ID kỳ báo cáo ;

  periods = [] // Các kỳ báo cáo;
  
  statisticsByTime = []; // Dropdown chọn thống kê theo thời gian
  statisticsByItem = []; // Thống kê theo loại hàng hóa
  
  reportTypeList = []; //Danh sách các loại báo cáo
  
  staffList = []; //Danh sách nhân viên
  
  shopList = []; //Danh sách cửa hàng
  
  currentReportType :number; //Loại báo cáo được chọn

  currentSelectedStaff = ""; //Mã nhân viên được chọn
  
  currentSelectedShop = ""; //ID shop được chọn

  currentOrderByItem : number; //Kiểu thống kê theo loại mặt hàng

  startFilterDate: Date = new Date();
  endFilterDate: Date = new Date();

  constructor(
    private staffService: StaffService,
    private shopService: ShopService,
    private commonService: CommonService,
    private saleReportService: SaleReportService,
    private transferService: TransferDataService
  ) {}

  ngOnInit() {
    this.currentReportType = 1;
    this.selectedPeriodId = 1;
    this.currentOrderByItem = 1;
    this.selectedPeriod = "Hôm nay";
    this.reportName = "TỔNG HỢP BÁN HÀNG THEO NGÀY";
    this.reportTypeList = SaleReportType;
    this.periods = PeriodList;
    this.statisticsByItem = StatisticsByItem;
    this.shopName = localStorage.getItem("currentShop");
    this.currentSelectedShop = localStorage.getItem("ShopID");
    this.getDataByQueryCondition();
    this.transferService.shopChange.subscribe(res=>{
      this.currentSelectedShop = res.ShopID;
      this.shopName = res.ShopName;
      this.getDataByQueryCondition();
    })
  }

  //lấy dữ liệu khi hiển thị popup
  showChooseReportPopup() {
    this.isShowPopup = true;
    this.getStaff();
    this.getShop();
  }

  // lấy danh sách nhân viên
  getStaff(){
    this.staffService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.staffList = res.Data;
        this.currentSelectedStaff = this.staffList[0].StaffCode;
      }
    });
  }

  getDataByQueryCondition(){
    this.isLoading = true;
    this.isShowPopup = false;
    const queryCondition = new QueryCondition();

    if(this.currentReportType == SaleReport.IncomeByItem && this.currentOrderByItem == 2){
      this.currentReportType = SaleReport.IncomeByGroupItem;
    }
    queryCondition.ReportType = this.currentReportType;
    queryCondition.StartDate = this.startFilterDate;

    queryCondition.EndDate = this.endFilterDate;

    if(this.currentSelectedStaff){
      queryCondition.StaffCode = this.currentSelectedStaff;
    }
    if(this.currentSelectedShop){
      queryCondition.ShopID = this.currentSelectedShop;
    }
    this.saleReportService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      if(res && res.Success){
        this.isLoading = false;
        this.handleDisplayAfterGetData(res.Data);
      } else {
        this.transferService.showToast(false);
      }
    })
  }

  onSelectStaff(e){
    if(e.value){
      this.currentSelectedStaff = e.value;
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

  //Xử lý hiển thị giao diện sau khi lấy dữ liệu thành công
  handleDisplayAfterGetData(data){
    this.isSaleByDay = false;
    this.isIncomeByItem = false;
    this.isInvoiceAndItem = false;
    this.isIncomeByGroupItem=  false;
    this.isIncomeByStaff = false;
    switch (this.currentReportType) {
      case SaleReport.SaleByDay:
        this.reportName = "TỔNG HỢP BÁN HÀNG THEO NGÀY";
        this.isSaleByDay = true;
        this.saleByDayData = [];
        if(data){
          for (let i = 0; i < data.length; i++) {
            var index = this.saleByDayData.findIndex(item => item.InvoiceDate == data[i].InvoiceDate);
            if(index == -1){
              var saleByDay = new SaleByDay();
              saleByDay.InvoiceDate = data[i].InvoiceDate;
              if(data[i].IsCash){
                saleByDay.Cash = data[i].TotalMoney;
              } else {
                saleByDay.Card = data[i].TotalMoney;
              }
              saleByDay.TotalMoney = data[i].TotalMoney;
              this.saleByDayData.push(saleByDay);
            } else {
              if(this.saleByDayData[index].Cash){
                this.saleByDayData[index].Card = data[i].TotalMoney;
              } else {
                this.saleByDayData[index].Cash = data[i].TotalMoney;
              }
              this.saleByDayData[index].TotalMoney += data[i].TotalMoney;
            }
          }
        }
        break;
      case SaleReport.InvoiceAndItemTable:
        this.reportName = "CHI TIẾT DOANH THU THEO HÓA ĐƠN VÀ MẶT HÀNG";
        this.isInvoiceAndItem = true;
        this.invoiceAndItemData = data;
        break;
      case SaleReport.IncomeByGroupItem:
        this.reportName = "DOANH THU THEO NHÓM HÀNG HÓA";
        this.isIncomeByGroupItem = true;
        this.incomeByGroupItemData = data;
        break;
      case SaleReport.IncomeByItem:
        this.reportName = "DOANH THU THEO HÀNG HÓA";
        this.isIncomeByItem = true;
        this.incomeByItemData = data;
        break;
      case SaleReport.IncomeByStaff:
        this.reportName = "DOANH THU THEO NHÂN VIÊN";
        this.isIncomeByStaff = true;
        this.incomeByStaffData = data;
        break;
      default:
        break;
    }
    const shop = this.shopList.find(item => item.ShopID == this.currentSelectedShop);
    if(shop) {
      this.shopName = shop.ShopName;
    }
    this.isShowPopup = false;
  }

  onChangeReportType(e){
    this.currentReportType = e.value;
  }

  onChangeStatisticType

  onCancel() {
    this.isShowPopup = false;
  }
}
