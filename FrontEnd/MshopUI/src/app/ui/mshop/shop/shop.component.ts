import { Component, OnInit } from '@angular/core';
import { FormMode } from 'src/app/services/common/enumeration/enumeration';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';
import { Shop } from 'src/app/models/shop';
import { ShopService } from 'src/app/services/shop/shop.service';
import * as cloneDeep from 'lodash/cloneDeep';

@Component({
  selector: 'app-shop',
  templateUrl: './shop.component.html',
  styleUrls: ['./shop.component.css']
})
export class ShopComponent implements OnInit {

  popupTitle = "";
  popupVisible = false;
  isLoading = true;
  formMode : FormMode;
  
  shopObj = new Shop();
  
  listOfDisplayData: Shop[] = [
  ];
  
  popupDeleteObj = new PopupDelObject();
  visibleDelPopup = false;

  widthConfig = [
    "200px",
    "300px",
    "",
    "200px",
    "100px"
  ];

  scrollConfig = { y: "600px" };
  constructor(
    private transferService: TransferDataService,
    private shopService: ShopService) { }

  ngOnInit() {
    this.getShops();
  }

  getShops(){
    this.isLoading = true;
    this.shopService.getAll().subscribe(res=>{
      this.isLoading = false;
      if(res && res.Success && res.Data.length) {
        this.listOfDisplayData = [...res.Data];
      } else {
        this.transferService.showToast(false);
      }
    });
  }


  showPopupItem(){
    this.shopObj = new Shop();
    this.popupVisible = true;
    this.popupTitle = "Thêm mới cửa hàng";
    this.formMode = FormMode.Insert;
  }


  //Hàm lưu lại dữ liệu popup
  onSave(){
    this.shopObj.FormMode = this.formMode;
    this.shopService.save(this.shopObj).subscribe(res=>{
      if(res && res.Success){
        this.popupVisible = false;
        this.transferService.showToast(true);
        if(this.formMode == FormMode.Insert){
          this.shopObj.ShopID = res.Data;
          this.listOfDisplayData = [this.shopObj,...this.listOfDisplayData];
        } else if(this.formMode == FormMode.Update) {
          this.shopObj = res.Data;
          const updateItemIndex = this.listOfDisplayData.findIndex(item=> item.ShopID == this.shopObj.ShopID);
          this.listOfDisplayData[updateItemIndex] = res.Data;
          this.listOfDisplayData = this.listOfDisplayData.filter(item=> item.ShopID != "");
        }
      } else {
        this.transferService.showToast(false);
      }
    })
  }

  //Mở popup truyền dữ liệu mode sửa
  onClickEditItem(item){
    this.shopObj = cloneDeep(item);
    this.popupVisible = true;
    this.popupTitle = "Sửa cửa hàng";
    this.formMode = FormMode.Update;
    this.shopService.getByID(item.ShopID).subscribe(res=>{
      if(res && res.Success){
        this.shopObj = res.Data;
      }
    });
  }

  //Click vào icon xóa
  onClickRemoveItem(item){
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa cửa hàng";
    this.popupDeleteObj.content = 'Bạn có đồng ý xóa cửa hàng <b>'+ item.ShopName +'</b> không?';
    this.popupDeleteObj.itemDelId = item.ShopID;
    this.popupDeleteObj.visible = true;
  }


  //Xác nhận xóa
  confirmDelele(itemID){
    this.shopService.delete(itemID).subscribe(res=>{
      if(res && res.Success){
        this.listOfDisplayData = this.listOfDisplayData.filter(item=>item.ShopID != itemID);
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
