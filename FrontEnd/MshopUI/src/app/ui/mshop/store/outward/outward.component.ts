import { Component, OnInit } from '@angular/core';
import { OutwardService } from 'src/app/services/store/Outward.service';
import { Outward } from 'src/app/models/outward/outward';
import { OutwardDetail } from 'src/app/models/outward/outward-detail';
import { PopupWarning } from 'src/app/models/shared/popup-warning';
import { Shop } from 'src/app/models/shop';
import { Supplier } from 'src/app/models/supplier';
import { Item } from 'src/app/models/item';
import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';
import { Staff } from 'src/app/models/staff';
import { FormMode, PeriodType } from 'src/app/services/common/enumeration/enumeration';
import { ShopService } from 'src/app/services/shop/shop.service';
import { GoodsService } from 'src/app/services/goods/goods.service';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { StaffService } from 'src/app/services/staff/staff.service';
import { SupplierService } from 'src/app/services/supplier/supplier.service';
import * as cloneDeep from "lodash/cloneDeep";
import { OutwardObject } from 'src/app/models/outward/outward-object';
import { CommonService } from 'src/app/services/common/common.service';
import { QueryCondition } from 'src/app/models/shared/query-condition';
import { PeriodList } from 'src/app/services/common/constant/constant';

@Component({
  selector: 'app-outward',
  templateUrl: './outward.component.html',
  styleUrls: ['./outward.component.css']
})
export class OutwardComponent implements OnInit {
  widthConfig = [
    "150px",
    "150px",
    "200px",
    "150px",
    "",
    "200px"
  ];
  scrollConfig = { y: "300px" };
  scrollDetailConfig = { y: "200px" };
  purposeRadioValue = 1;
  isShowPopup = false;

  OutwardObj = new Outward();
  listOfDisplayData: Outward[] = [];
  listOfDetailData : OutwardDetail[] = [];
  gridDetailData: OutwardDetail[] = [];
  popupWarning = new PopupWarning();
  shopList: Shop[] = [];
  supplierList :Supplier[] = [];
  goodsList: Item[] =[];
  visibleDelPopup: boolean = false;
  popupDeleteObj = new PopupDelObject();
  staffList: Staff[] = [];

  startFilterDate: Date = new Date();
  endFilterDate: Date = new Date();

  periods = [];
  selectedPeriodId : number; // ID kỳ báo cáo ;
  selectedPeriod = "";


  exportObjectList = [];
  formMode: FormMode;

  itemSourceList = [];
  popupTitle = "";
  currentShop = "";

  widthDetailConfig = [
    "150px",
    "",
    "250px",
    "100px",
    "100px",
    "150px",
    "150px",
  ];

  widthDetailPopupConfig = [
    "150px",
    "",
    "250px",
    "100px",
    "100px",
    "150px",
    "150px",
    "50px"
  ];



  constructor(
    private OutwardService: OutwardService,
    private shopService: ShopService,
    private goodsService: GoodsService,
    private transferService: TransferDataService,
    private staffService: StaffService,
    private supplierService: SupplierService,
    private commonService: CommonService
    ) {
   }

  ngOnInit() {
    this.selectedPeriodId = 1;
    this.selectedPeriod = "Hôm nay";
    this.periods = PeriodList;
    this.currentShop = localStorage.getItem("ShopID");
    this.getOutwards();
    this.transferService.shopChange.subscribe(res=>{
      this.currentShop = res.ShopID;
      this.getOutwards();
    })
  }
  
  getOutwards(){
    var queryCondition = new QueryCondition();
    queryCondition.ShopID = this.currentShop;
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    this.gridDetailData = [];
    this.OutwardService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      if(res && res.Data){
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


  showOutwardReceipt(option){
    this.formMode = FormMode.Insert;
    this.exportObjectList = [];
    this.itemSourceList = [];
    if(option == FormMode.Insert){
      this.isShowPopup = true;
      this.clearForm();
      this.OutwardObj = new Outward();
      this.OutwardObj.InStaffName = localStorage.getItem("StaffName");
      this.OutwardObj.InStaffCode = localStorage.getItem("StaffCode");
      this.popupTitle = "Thêm mới phiếu xuất kho";
      this.getOutwardNo();
    } else {
      const selectedIndex = this.listOfDisplayData.findIndex(
        item => item.IsSelected == true
      );
      if(selectedIndex != -1){
        this.OutwardObj = cloneDeep(this.listOfDisplayData[selectedIndex]);
        this.listOfDetailData = cloneDeep(this.gridDetailData);
        if (option == FormMode.Duplicate) {
          this.popupTitle = "Nhân bản phiếu xuất kho";          
          this.isShowPopup = true;
          this.getOutwardNo();
          this.OutwardObj.OutwardID = "";
          for (let i = 0; i < this.listOfDetailData.length; i++) {
            this.listOfDetailData[i].OutwardID = "";
            this.listOfDetailData[i].OutwardDetailID = "";
            this.listOfDetailData[i].IsShow = true;
          }
          this.pushNewOnGrid();
        } else if (option == FormMode.Update) {
          this.popupTitle = "Sửa phiếu xuất kho";
          this.isShowPopup = true;
          this.formMode = FormMode.Update;
          for (let i = 0; i < this.listOfDetailData.length; i++) {
            this.listOfDetailData[i].IsShow = true;
          }
          this.pushNewOnGrid();
        } else if (option == FormMode.Delete) {
          this.formMode = FormMode.Delete;
          this.onClickRemoveItem(this.OutwardObj);
        }
      }
    }
    this.getItemList(); 
    this.getShopList();
    this.getStaffList();
  }

  getShopList(){
    this.shopService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.bindShopListToSourceItem(res.Data);
        // this.bindSupplierToSourceItem();
      }
    });
  }

  bindShopListToSourceItem(shopList){
    shopList.forEach(element => {
      var sourceItem = {
        id: element.ShopID,
        name: element.ShopName
      }
      this.itemSourceList.push(sourceItem);
    });
  }

  // getSupplierList(){
  //   this.supplierService.getAll().subscribe(res=>{
  //     if(res && res.Success){
  //       this.supplierList = res.Data;
  //     }
  //   })
  // }

  // bindSupplierToSourceItem(){
  //   this.supplierList.forEach(element => {
  //     var sourceItem = {
  //       id: element.SupplierID,
  //       name: element.SupplierName
  //     }
  //     this.itemSourceList.push(sourceItem);
  //   });
  // }


  getOutwardNo(){
    this.OutwardService.getNo().subscribe(res=>{
      if(res && res.Success){
        this.OutwardObj.OutwardNo = res.Data;
      }
    })
  }

  getStaffList(){
    this.staffService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.bindStaffToExportObject(res.Data);
        // this.bindSupplierToExportObject();
      }
    })
  }

  bindStaffToExportObject(data){
    data.forEach(element => {
      var exportObject = {
        Code: element.StaffCode,
        Name: element.StaffName
      }
      this.exportObjectList.push(exportObject);
    });
  }

  // bindSupplierToExportObject(){
  //   this.supplierList.forEach(element => {
  //     var exportObject = {
  //       Code: element.SupplierCode,
  //       Name: element.SupplierName
  //     }
  //     this.exportObjectList.push(exportObject);
  //   });
  // }

  getItemList(){
    this.goodsService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.goodsList = [...res.Data];
      }
    })
  }

  onSelectStaff(e){
    const staff = e.value;
    if(staff){
      this.OutwardObj.OutStaffName = staff.StaffName;
      this.OutwardObj.OutStaffCode = staff.StaffCode;
    }
  }

  //sự kiện chọn đối tượng xuất
  onSelectExportObject(e){
    const object = this.exportObjectList.find(item=>item.Name == e.value)
    if(object){
      this.OutwardObj.OutStaffCode = object.Code;
    }
  }


     //Bắt sự kiện thay đổi 
  onAmountChange(e, i){
    const textboxValue = e.value;
    if(textboxValue){
      var temp = textboxValue*(this.listOfDetailData[i].UnitPrice);
      this.listOfDetailData[i].TotalMoney = temp;
      this.calculateTotalMoney();
    }
  }


  pushNewOnGrid() {
    var count = 0;
    for (let i = 0; i < this.listOfDetailData.length; i++) {
      const element = this.listOfDetailData[i];
      if(!element.SKUCode && element.IsShow){
        count+=1;
      }
    } 
    if(count==0){
      const newRow = new OutwardDetail();
      this.listOfDetailData = [...this.listOfDetailData, newRow];
    }
  }
  //Chọn 1 hàng hóa trên select box
  onSelectItem(e, i) {
    console.log(e);
    const item = e.value;
    if(item){
      this.listOfDetailData[i].SKUCode = item.SKUCode;
      this.listOfDetailData[i].ItemName = item.ItemName;
      this.listOfDetailData[i].Unit = item.UnitName;
      this.listOfDetailData[i].UnitPrice = item.SellPrice;
      this.listOfDetailData[i].ItemGroupName = item.ItemGroupName;
      this.listOfDetailData[i].ItemGroupCode = item.ItemGroupCode;

      this.pushNewOnGrid();
    }
  }
   // bắt sự kiện keyup trên dx-text-box
   onKeyUpOnTextBox(e, i){
    if(e){
      const keyCode = e.event.keyCode;
      if(keyCode == 13){
        this.pushNewOnGrid();
      }
    }
  }

  onSave(){
    if(this.checkValid()){
      this.OutwardObj.ShopID = this.currentShop;
      this.listOfDetailData = this.listOfDetailData.filter(item=> item.IsShow && item.SKUCode && item.Amount);
      for (let i = 0; i < this.listOfDetailData.length; i++) {
        this.listOfDetailData[i].ShopID = this.currentShop;
      }
      const outwardObject = new OutwardObject();
      outwardObject.Outward = this.OutwardObj;
      outwardObject.OutwardDetails = this.listOfDetailData;
      outwardObject.FormMode = this.formMode;
      this.OutwardService.save(outwardObject).subscribe(res=>{
        if(res && res.Success){
          this.isShowPopup = false;
          this.startFilterDate = new Date();
          this.endFilterDate = new Date();
          this.getOutwards();
          // if(this.formMode == FormMode.Insert){
          //   this.OutwardObj.OutwardID = res.Data;
          //   this.listOfDisplayData = [this.OutwardObj,...this.listOfDisplayData];
          // }
          this.transferService.showToast(true);
        } else {
          this.transferService.showToast(false);
        }
      });

    }
    
  }

  onSelectMaster(OutwardID, index){
    this.listOfDisplayData.map(item => (item.IsSelected = false));
    this.listOfDisplayData[index].IsSelected = true;
    this.OutwardService.getByFieldName(OutwardID).subscribe(res=>{
      if(res && res.Success){
        this.gridDetailData = [...res.Data];
      }
    })
  }

  onClickNo(e, OutwardID, index){
    this.listOfDisplayData.map(item => (item.IsSelected = false));
    this.listOfDisplayData[index].IsSelected = true;
    this.OutwardService.getByFieldName(OutwardID).subscribe(res=>{
      if(res && res.Success){
        this.gridDetailData = [...res.Data];
        this.showOutwardReceipt(2);
      }
    })
    e.stopPropagation();
  }

  onClickRemoveDetailItem(i){
    const showingItemList = this.listOfDetailData.filter(item=> item.IsShow);
    if(showingItemList.length>1){
      this.listOfDetailData[i].IsShow = false;
    }
  }
     
  clearForm(){
    this.OutwardObj = new Outward();
    this.listOfDetailData = [];
    this.pushNewOnGrid();
  }

  //Hàm tính tổng tiền trên hóa đơn
  calculateTotalMoney(){
    this.OutwardObj.TotalMoney = 0;
    for (let i = 0; i < this.listOfDetailData.length; i++) {
      const element = this.listOfDetailData[i];
      if(element.TotalMoney){
        this.OutwardObj.TotalMoney += element.TotalMoney;
      }
    }
  }


  onClickDeleteOutward() {
    if (this.formMode == FormMode.Update && this.OutwardObj.OutwardID) {
      this.onClickRemoveItem(this.OutwardObj);
    }
  }

  //Click vào icon xóa
  onClickRemoveItem(item) {
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa phiếu xuất kho";
    this.popupDeleteObj.content =
      "Bạn có đồng ý xóa phiếu xuất kho <b>" +
      item.OutwardNo +
      "</b> không?";
    this.popupDeleteObj.itemDelId = item.OutwardID;
    this.popupDeleteObj.visible = true;
  }

  //Xác nhận xóa
  confirmDelele(itemID) {
    this.OutwardService.delete(itemID).subscribe(res => {
      if (res && res.Success) {
        this.listOfDisplayData = this.listOfDisplayData.filter(
          item => item.OutwardID != itemID
        );
        this.transferService.showToast(true);
        this.visibleDelPopup = false;
      } else {
        this.transferService.showToast(false);
      }
      this.isShowPopup = false;
    });
  }

  //Hủy không xóa
  cancelDel() {
    this.visibleDelPopup = false;
  }


  checkValid(){
    const result = this.listOfDetailData.findIndex(item=> item.IsShow && item.SKUCode != null && item.Amount != null);
    if(result == -1){
      this.showPopupWarning();
      return false;
    } else {
      const check1 = this.listOfDetailData.findIndex(item=> item.IsShow && item.SKUCode != "" && item.Amount == null);
      const check2 = this.listOfDetailData.findIndex(item=> item.IsShow && item.SKUCode == "" && item.Amount != null);
      if(check1 == -1 && check2 == -1){
        return true;
      } else {
        this.showMissingFieldWarning();
        return false;
      }
    }
  }

  showMissingFieldWarning(){
    this.popupWarning.visible = true;
    this.popupWarning.content = "Mã hàng hóa không được để trống và số lượng tối thiểu phải bằng 1!";
  }

  showPopupWarning(){
    this.popupWarning.visible = true;
    this.popupWarning.content = "Phải có ít nhất một chi tiết!";
  }
  closeWarningPopup(){
    this.popupWarning.visible = false;
  }
}
