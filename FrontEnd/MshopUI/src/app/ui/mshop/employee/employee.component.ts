import { Component, OnInit } from "@angular/core";
import { Staff } from 'src/app/models/staff';
import { StaffService } from 'src/app/services/staff/staff.service';
import { Gender, WorkTimeStatus, WorkStatus, RoleType, Nations, Provinces, Towns, Districts } from 'src/app/services/common/constant/constant';
import { FormMode } from 'src/app/services/common/enumeration/enumeration';

import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import * as cloneDeep from 'lodash/cloneDeep';
import { ShopService } from 'src/app/services/shop/shop.service';
import { Shop } from 'src/app/models/shop';

@Component({
  selector: "app-employee",
  templateUrl: "./employee.component.html",
  styleUrls: ["./employee.component.css"]
})
export class EmployeeComponent implements OnInit {

  isShowDataGrid = true;
  employeePicSrc = "";
  formMode : FormMode;
  popupDeleteObj = new PopupDelObject();
  isLoading = true;
  visibleDelPopup = false;
  
  employeeForm = [
    { id: 1, title: "Thông tin cơ bản", icon:"far fa-user", template: "basic-info" },
    { id: 2, title: "Thông tin liên hệ",  icon:"fas fa-phone-square-alt", template: "contact-info" },
    { id: 3, title: "Thông tin hồ sơ",  icon:"far fa-id-card", template: "document-info" }
  ];

  widthConfig = [
    "150px",
    "300px",
    "100px",
    "150px",
    "150px",
    "",
    "100px"
  ];

  scrollConfig = { y: "600px" };

  roleTypes = RoleType;
  workStatus = WorkStatus;
  workTimeStatus = WorkTimeStatus;
  gender = Gender;
  nations = Nations;
  provinces = Provinces;
  districts = Districts;
  towns = Towns; 
  

  staffObj = new Staff();
  shopList : Shop[] = [];
  listOfDisplayData: Staff[] = [];

  constructor(
    private staffService: StaffService,
    private transferService: TransferDataService,
    private shopService: ShopService) {
  }
  ngOnInit() {
    this.getStaffs();
    this.getShopList();
  }

  getStaffs(){
    this.staffService.getAll().subscribe(res=>{
      this.isLoading = false;
      if(res && res.Success){
        this.listOfDisplayData = [...res.Data];
        console.log(res.Data);
      }
    });
  }

  getNewestNo(){
    this.staffService.getNo().subscribe(res=>{
      if(res && res.Success){
        this.staffObj.StaffCode = res.Data;
      }
    })
  }

  //Nhấn thêm mới 1 nhân viên
  onClickAddItem() {
    this.isShowDataGrid = false;
    this.employeePicSrc = "";
    this.formMode = FormMode.Insert;
    this.staffObj = new Staff();
    this.getNewestNo();
  }

  //Lấy danh sách cửa hàng
  getShopList(){
    this.shopService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.shopList = [...res.Data];
      }
    })
  }

  //Nhấn sửa 1 nhân viên
  onClickEditItem(item){
    this.formMode = FormMode.Update;
    this.staffService.getByID(item.StaffID).subscribe(res=>{
      if(res && res.Success && res.Data){
        this.isShowDataGrid  = false;
        this.staffObj = res.Data;
        this.employeePicSrc = this.staffObj.Avatar;
      }
    })
  }


  //Click icon xóa
  onClickRemoveItem(item){
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa nhân viên";
    this.popupDeleteObj.content = 'Bạn có đồng ý xóa nhân viên <b>'+ item.StaffName +'</b> không?';
    this.popupDeleteObj.itemDelId = item.StaffID;
    this.popupDeleteObj.visible = true;
  }

  //Xác nhận xóa
  confirmDelele(itemID){
    this.staffService.delete(itemID).subscribe(res=>{
      if(res && res.Success){
        this.listOfDisplayData = this.listOfDisplayData.filter(item=>item.StaffID != itemID);
        this.transferService.showToast(true);
        this.visibleDelPopup = false;
      } else {
        this.transferService.showToast(false);
      }
    })
  }

   //Hủy không xóa
   cancelDel(){
    this.visibleDelPopup = false;
  }


  uploadImage(e) {
    let imageFile = <File>e.target.files[0];
    if (imageFile) {
      const fileReader = new FileReader();
      fileReader.readAsDataURL(imageFile);
      fileReader.onload = _event => {
        this.employeePicSrc = fileReader.result.toString();
      };
      const itemImage = new FormData();
      itemImage.append('file', imageFile);
      this.staffService.upload(itemImage).subscribe(res=>{
        if(res && res.Success){
          this.staffObj.Avatar = res.Data;
        } else if(res && !res.Success && res.Message){
          this.transferService.showToast(false, res.Message)
        } else {
          this.transferService.showToast(false);
        }
      })
    }
   
  }

  onSave(e, mode?){
    let result = e.validationGroup.validate();
    if (result.isValid) {
      this.save();
    }
  }

  //Thực hiện gửi request lưu đến server
  save(){
    this.staffObj.FormMode = this.formMode;
    this.staffService.save(this.staffObj).subscribe(res=>{
      if(res && res.Success){
        console.log(res);
        this.isShowDataGrid = true;
        this.transferService.showToast(true);
        if(this.formMode == FormMode.Insert){
          this.staffObj.StaffID = res.Data;
          this.listOfDisplayData = [this.staffObj,...this.listOfDisplayData];
        } else if(this.formMode == FormMode.Update) {
          this.staffObj = res.Data;
          const updateItemIndex = this.listOfDisplayData.findIndex(item=> item.StaffID == this.staffObj.StaffID);
          this.listOfDisplayData[updateItemIndex] = res.Data;
          this.listOfDisplayData = this.listOfDisplayData.filter(item=> item.StaffID != "");
        }
      } else {
        this.transferService.showToast(false);
      }
    })
  }

  //Tắt form nhân viên
  cancelEmployeeForm(){
    this.isShowDataGrid = true;
  }

}
