import { Component, OnInit } from '@angular/core';
import { InwardService } from 'src/app/services/store/inward.service';
import { Inward } from 'src/app/models/inward/inward';
import { InwardDetail } from 'src/app/models/inward/inward-detail';
import { ShopService } from 'src/app/services/shop/shop.service';
import { Shop } from 'src/app/models/shop';
import { GoodsService } from 'src/app/services/goods/goods.service';
import { Item } from 'src/app/models/item';
import { InwardObject } from 'src/app/models/inward/inward-object';
import { FormMode, PeriodType } from 'src/app/services/common/enumeration/enumeration';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { StaffService } from 'src/app/services/staff/staff.service';
import { Staff } from 'src/app/models/staff';
import { Supplier } from 'src/app/models/supplier';
import { SupplierService } from 'src/app/services/supplier/supplier.service';
import { PopupWarning } from 'src/app/models/shared/popup-warning';
import * as cloneDeep from "lodash/cloneDeep";
import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';
import { CommonService } from 'src/app/services/common/common.service';
import { QueryCondition } from 'src/app/models/shared/query-condition';
import { PeriodList } from 'src/app/services/common/constant/constant';


@Component({
  selector: 'app-inward',
  templateUrl: './inward.component.html',
  styleUrls: ['./inward.component.css']
})

export class InwardComponent implements OnInit {
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

  inwardObj = new Inward();
  listOfDisplayData: Inward[] = [];
  listOfDetailData : InwardDetail[] = [];
  gridDetailData: InwardDetail[] = [];
  popupWarning = new PopupWarning();
  shopList: Shop[] = [];
  supplierList :Supplier[] = [];
  goodsList: Item[] =[];
  visibleDelPopup: boolean = false;
  popupDeleteObj = new PopupDelObject();
  staffList: Staff[] = [];


  periods = [];
  selectedPeriodId : number; // ID kỳ báo cáo ;
  selectedPeriod = "";


  startFilterDate: Date = new Date();
  endFilterDate: Date = new Date();

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
    private inwardService: InwardService,
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
    this.getInwards();
    this.getSupplierList();
    this.transferService.shopChange.subscribe(res=>{
      this.currentShop = res.ShopID;
      this.getInwards();
    })
  }
  
  getInwards(){
    var queryCondition = new QueryCondition();
    queryCondition.ShopID = this.currentShop;
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    this.gridDetailData = [];
    this.inwardService.getDataByQueryCondition(queryCondition).subscribe(res=>{
      if(res && res.Data){
        console.log(res.Data);
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

  showInwardReceipt(option){
    this.exportObjectList = [];
    this.formMode = FormMode.Insert;
    if(option == FormMode.Insert){
      this.isShowPopup = true;
      this.clearForm();
      this.inwardObj = new Inward();
      this.inwardObj.InStaffName = localStorage.getItem("StaffName");
      this.inwardObj.InStaffCode = localStorage.getItem("StaffCode");
      this.popupTitle = "Thêm mới phiếu nhập kho";
      this.getInwardNo();
    } else {
      const selectedIndex = this.listOfDisplayData.findIndex(
        item => item.IsSelected == true
      );
      if(selectedIndex != -1){
        this.inwardObj = cloneDeep(this.listOfDisplayData[selectedIndex]);
        this.listOfDetailData = cloneDeep(this.gridDetailData);
        if (option == FormMode.Duplicate) {
          this.popupTitle = "Nhân bản phiếu nhập kho";          
          this.isShowPopup = true;
          this.getInwardNo();
          this.inwardObj.InwardID = "";
          for (let i = 0; i < this.listOfDetailData.length; i++) {
            this.listOfDetailData[i].InwardID = "";
            this.listOfDetailData[i].InwardDetailID = "";
            this.listOfDetailData[i].IsShow = true;
          }
          this.pushNewOnGrid();
        } else if (option == FormMode.Update) {
          this.popupTitle = "Sửa phiếu nhập kho";
          this.isShowPopup = true;
          this.formMode = FormMode.Update;
          for (let i = 0; i < this.listOfDetailData.length; i++) {
            this.listOfDetailData[i].IsShow = true;
          }
          this.pushNewOnGrid();
        } else if (option == FormMode.Delete) {
          this.formMode = FormMode.Delete;
          this.onClickRemoveItem(this.inwardObj);
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
        this.bindSupplierToSourceItem();
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

  getSupplierList(){
    this.supplierService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.supplierList = res.Data;
      }
    })
  }

  bindSupplierToSourceItem(){
    this.supplierList.forEach(element => {
      var sourceItem = {
        id: element.SupplierID,
        name: element.SupplierName
      }
      this.itemSourceList.push(sourceItem);
    });
  }


  getInwardNo(){
    this.inwardService.getNo().subscribe(res=>{
      if(res && res.Success){
        this.inwardObj.InwardNo = res.Data;
      }
    })
  }

  getStaffList(){
    this.staffService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.bindStaffToExportObject(res.Data);
        this.bindSupplierToExportObject();
      }
    })
  }

  bindStaffToExportObject(data){
    data.forEach(element => {
      var exportObject = {
        Code: element.StaffCode,
        Name: element.StaffName,
        IsFromSupplier: false
      }
      this.exportObjectList.push(exportObject);
    });
  }

  bindSupplierToExportObject(){
    this.supplierList.forEach(element => {
      var exportObject = {
        Code: element.ContactPhone,
        Name: element.ContactName,
        IsFromSupplier: true
      }
      this.exportObjectList.push(exportObject);
    });
  }

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
      this.inwardObj.OutStaffName = staff.StaffName;
      this.inwardObj.OutStaffCode = staff.StaffCode;
    }
  }

  //sự kiện chọn đối tượng xuất
  onSelectExportObject(e){
    const object = this.exportObjectList.find(item=>item.Name == e.value)
    if(object){
      this.inwardObj.OutStaffCode = object.Code;
      this.inwardObj.IsFromSupplier = object.IsFromSupplier;
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
      const newRow = new InwardDetail();
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
      this.inwardObj.ShopID = this.currentShop;
      this.listOfDetailData = this.listOfDetailData.filter(item=> item.IsShow && item.SKUCode && item.Amount);
      for (let i = 0; i < this.listOfDetailData.length; i++) {
        this.listOfDetailData[i].ShopID = this.currentShop;
      }
      const inwardObject = new InwardObject();
      inwardObject.Inward = this.inwardObj;
      inwardObject.InwardDetails = this.listOfDetailData;
      inwardObject.FormMode = this.formMode;
      this.inwardService.save(inwardObject).subscribe(res=>{
        if(res && res.Success){
          this.isShowPopup = false;
          this.startFilterDate = new Date();
          this.endFilterDate = new Date();
          this.getInwards();
          // if(this.formMode == FormMode.Insert){
          //   this.inwardObj.InwardID = res.Data;
          //   this.listOfDisplayData = [this.inwardObj,...this.listOfDisplayData];
          // } else {
          // }
          this.transferService.showToast(true);
        } else {
          this.transferService.showToast(false);
        }
      });

    }
    
  }

  onSelectMaster(inwardID, index){
    this.listOfDisplayData.map(item => (item.IsSelected = false));
    this.listOfDisplayData[index].IsSelected = true;
    this.inwardService.getByFieldName(inwardID).subscribe(res=>{
      if(res && res.Success){
        this.gridDetailData = [...res.Data];
      }
    })
  }

  onClickNo(e, inwardID, index){
    this.listOfDisplayData.map(item => (item.IsSelected = false));
    this.listOfDisplayData[index].IsSelected = true;
    this.inwardService.getByFieldName(inwardID).subscribe(res=>{
      if(res && res.Success){
        this.gridDetailData = [...res.Data];
        this.showInwardReceipt(2);
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
    this.inwardObj = new Inward();
    this.listOfDetailData = [];
    this.pushNewOnGrid();
  }

  //Hàm tính tổng tiền trên hóa đơn
  calculateTotalMoney(){
    this.inwardObj.TotalMoney = 0;
    for (let i = 0; i < this.listOfDetailData.length; i++) {
      const element = this.listOfDetailData[i];
      if(element.TotalMoney){
        this.inwardObj.TotalMoney += element.TotalMoney;
      }
    }
  }


  onClickDeleteInward() {
    if (this.formMode == FormMode.Update && this.inwardObj.InwardID) {
      this.onClickRemoveItem(this.inwardObj);
    }
  }

  //Click vào icon xóa
  onClickRemoveItem(item) {
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa phiếu nhập kho";
    this.popupDeleteObj.content =
      "Bạn có đồng ý xóa phiếu nhập kho <b>" +
      item.InwardNo +
      "</b> không?";
    this.popupDeleteObj.itemDelId = item.InwardID;
    this.popupDeleteObj.visible = true;
  }

  //Xác nhận xóa
  confirmDelele(itemID) {
    this.inwardService.delete(itemID).subscribe(res => {
      if (res && res.Success) {
        this.listOfDisplayData = this.listOfDisplayData.filter(
          item => item.InwardID != itemID
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
