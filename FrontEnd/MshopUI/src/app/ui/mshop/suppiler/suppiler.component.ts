import { Component, OnInit } from '@angular/core';
import { FormMode } from 'src/app/services/common/enumeration/enumeration';
import { Supplier } from 'src/app/models/supplier';
import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';
import { SupplierService } from 'src/app/services/supplier/supplier.service';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import * as cloneDeep from 'lodash/cloneDeep';

@Component({
  selector: 'app-suppiler',
  templateUrl: './suppiler.component.html',
  styleUrls: ['./suppiler.component.css']
})
export class SuppilerComponent implements OnInit {

  popupTitle = "";
  popupVisible = false;
  isLoading = true;
  formMode : FormMode;
  
  supplierObj = new Supplier();
  
  listOfDisplayData: Supplier[] = [
  ];
  
  popupDeleteObj = new PopupDelObject();
  visibleDelPopup = false;

  widthConfig = [
    "250px",
    "200px",
    "250px",
    "",
    "100px"
  ];

  scrollConfig = { y: "600px" };
  constructor(
    private supplierService: SupplierService,
    private transferService: TransferDataService) { }

  ngOnInit() {
    this.getSupplier();
  }

  getSupplier(){
    this.isLoading = true;
    this.supplierService.getAll().subscribe(res=>{
      this.isLoading = false;
      if(res && res.Success && res.Data.length) {
        this.listOfDisplayData = [...res.Data];
      } else {
        this.transferService.showToast(false);
      }
    });
  }


  showPopupItem(){
    this.supplierObj = new Supplier();
    this.popupVisible = true;
    this.popupTitle = "Thêm nhà cung cấp";
    this.formMode = FormMode.Insert;
  }


  //Hàm lưu lại dữ liệu popup
  onSave(){
    this.supplierObj.FormMode = this.formMode;
    this.supplierService.save(this.supplierObj).subscribe(res=>{
      if(res && res.Success){
        this.transferService.showToast(true);
        if(this.formMode == FormMode.Insert){
          this.supplierObj.SupplierID = res.Data;
          this.listOfDisplayData = [this.supplierObj,...this.listOfDisplayData];
        } else if(this.formMode == FormMode.Update){
          const updateItemIndex = this.listOfDisplayData.findIndex(item=> item.SupplierID == this.supplierObj.SupplierID);
          this.listOfDisplayData[updateItemIndex] = this.supplierObj;
          this.listOfDisplayData = this.listOfDisplayData.filter(item=> item.SupplierID != "");
        }
        this.popupVisible = false;
      } else {
        this.transferService.showToast(false);
      }
    })
  }

  //Mở popup truyền dữ liệu mode sửa
  onClickEditItem(item){
    this.supplierObj = cloneDeep(item);
    this.popupVisible = true;
    this.popupTitle = "Sửa thông tin nhà cung cấp";
    this.formMode = FormMode.Update;
    this.supplierService.getByID(item.SupplierID).subscribe(res=>{
      if(res && res.Success){
        this.supplierObj = res.Data;
      }
    });
  }

  //Click vào icon xóa
  onClickRemoveItem(item){
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa nhà cung cấp";
    this.popupDeleteObj.content = 'Bạn có đồng ý xóa nhà cung cấp <b>'+ item.SupplierName +'</b> không?';
    this.popupDeleteObj.itemDelId = item.SupplierID;
    this.popupDeleteObj.visible = true;
  }


  //Xác nhận xóa
  confirmDelele(itemID){
    this.supplierService.delete(itemID).subscribe(res=>{
      if(res && res.Success){
        this.listOfDisplayData = this.listOfDisplayData.filter(item=>item.SupplierID != itemID);
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
