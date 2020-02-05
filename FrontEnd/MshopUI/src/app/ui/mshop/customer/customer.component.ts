import { Component, OnInit } from '@angular/core';
import { FormMode } from 'src/app/services/common/enumeration/enumeration';
import { Customer } from 'src/app/models/customer';
import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';
import { CustomerService } from 'src/app/services/customer/customer.service';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import * as cloneDeep from 'lodash/cloneDeep';

@Component({
  selector: 'app-customer',
  templateUrl: './customer.component.html',
  styleUrls: ['./customer.component.css']
})
export class CustomerComponent implements OnInit {

  popupTitle = "";
  popupVisible = false;
  isLoading = true;
  formMode : FormMode;
  
  customerObj = new Customer();
  
  listOfDisplayData: Customer[] = [
  ];
  
  popupDeleteObj = new PopupDelObject();
  visibleDelPopup = false;

  widthConfig = [
    "250px",
    "200px",
    "250px",
    "200px",
    "",
    "100px"
  ];

  scrollConfig = { y: "600px" };
  constructor(
    private customerService: CustomerService,
    private transferService: TransferDataService) { }

  ngOnInit() {
    this.getCustomer();
  }

  getCustomer(){
    this.isLoading = true;
    this.customerService.getAll().subscribe(res=>{
      this.isLoading = false;
      if(res && res.Success && res.Data.length) {
        this.listOfDisplayData = [...res.Data];
      } else {
        this.transferService.showToast(false);
      }
    });
  }


  showPopupItem(){
    this.customerObj = new Customer();
    this.popupVisible = true;
    this.popupTitle = "Thêm khách hàng";
    this.formMode = FormMode.Insert;
  }


  //Hàm lưu lại dữ liệu popup
  onSave(){
    this.customerObj.FormMode = this.formMode;
    this.customerService.save(this.customerObj).subscribe(res=>{
      if(res && res.Success){
        this.transferService.showToast(true);
        if(this.formMode == FormMode.Insert){
          this.customerObj.CustomerID = res.Data;
          this.listOfDisplayData = [this.customerObj,...this.listOfDisplayData];
        } else if(this.formMode == FormMode.Update){
          const updateItemIndex = this.listOfDisplayData.findIndex(item=> item.CustomerID == this.customerObj.CustomerID);
          this.listOfDisplayData[updateItemIndex] = this.customerObj;
          this.listOfDisplayData = this.listOfDisplayData.filter(item=> item.CustomerID != "");
        }
        this.popupVisible = false;
      } else {
        this.transferService.showToast(false);
      }
    })
  }

  //Mở popup truyền dữ liệu mode sửa
  onClickEditItem(item){
    this.customerObj = cloneDeep(item);
    this.popupVisible = true;
    this.popupTitle = "Sửa thông tin khách hàng";
    this.formMode = FormMode.Update;
    this.customerService.getByID(item.ItemGroupID).subscribe(res=>{
      if(res && res.Success){
        this.customerObj = res.Data;
      }
    });
  }

  //Click vào icon xóa
  onClickRemoveItem(item){
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa khách hàng";
    this.popupDeleteObj.content = 'Bạn có đồng ý xóa khách hàng <b>'+ item.CustomerName +'</b> không?';
    this.popupDeleteObj.itemDelId = item.CustomerID;
    this.popupDeleteObj.visible = true;
  }


  //Xác nhận xóa
  confirmDelele(itemID){
    this.customerService.delete(itemID).subscribe(res=>{
      if(res && res.Success){
        this.listOfDisplayData = this.listOfDisplayData.filter(item=>item.CustomerID != itemID);
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

  //Đóng popup
  onCancel(){
    this.popupVisible = false;
  }
}
