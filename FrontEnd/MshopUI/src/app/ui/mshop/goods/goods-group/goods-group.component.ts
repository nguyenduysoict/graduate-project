import { Component, OnInit } from '@angular/core';
import { ToastType, FormMode } from 'src/app/services/common/enumeration/enumeration';
import { Toast } from 'src/app/models/shared/toast';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { GoodsGroupService } from 'src/app/services/goods/goods-group.service';
import { GoodsGroup } from 'src/app/models/good-group';
import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';
import * as cloneDeep from 'lodash/cloneDeep';

@Component({
  selector: 'app-goods-group',
  templateUrl: './goods-group.component.html',
  styleUrls: ['./goods-group.component.css']
})
export class GoodsGroupComponent implements OnInit {

  
  popupTitle = "";
  popupVisible = false;
  isLoading = true;
  formMode : FormMode;
  
  itemGroupObj = new GoodsGroup();
  
  listOfDisplayData: GoodsGroup[] = [
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
    private goodsGroupService: GoodsGroupService,
    private transferService: TransferDataService) { }

  ngOnInit() {
    this.getGoodsGroup();
  }

  getGoodsGroup(){
    this.isLoading = true;
    this.goodsGroupService.getAll().subscribe(res=>{
      this.isLoading = false;
      if(res && res.Success && res.Data.length) {
        this.listOfDisplayData = [...res.Data];
      } else {
        this.transferService.showToast(false);
      }
    });
  }

  showPopupDelete(){
  }

  showPopupItem(){
    this.itemGroupObj = new GoodsGroup();
    this.popupVisible = true;
    this.popupTitle = "Thêm mới nhóm hàng hóa";
    this.formMode = FormMode.Insert;
  }


  //Hàm lưu lại dữ liệu popup
  onSave(){
    if(this.formMode == FormMode.Insert){
      this.goodsGroupService.save(this.itemGroupObj).subscribe(res=>{
        if(res && res.Success){
          this.transferService.showToast(true);
          this.itemGroupObj.ItemGroupID = res.Data;
          this.listOfDisplayData = [this.itemGroupObj,...this.listOfDisplayData];
          this.popupVisible = false;
        } else {
          this.transferService.showToast(false);
        }
      })
    } else if(this.formMode == FormMode.Update) {
      this.goodsGroupService.update(this.itemGroupObj).subscribe(res=>{
        if(res && res.Success){
          this.transferService.showToast(true);
          const updateItemIndex = this.listOfDisplayData.findIndex(item=> item.ItemGroupID == this.itemGroupObj.ItemGroupID);
          this.listOfDisplayData[updateItemIndex] = res.Data;
          this.listOfDisplayData = this.listOfDisplayData.filter(item=> item.ItemGroupID != "");
          this.popupVisible = false;
        } else {
          this.transferService.showToast(false);
        }
      })
    }
  }



  onSaveAndAdd(){

  }


  
  //Mở popup truyền dữ liệu mode sửa
  onClickEditItem(item){
    this.itemGroupObj = cloneDeep(item);
    this.popupVisible = true;
    this.popupTitle = "Sửa nhóm hàng hóa";
    this.formMode = FormMode.Update;
    this.goodsGroupService.getByID(item.ItemGroupID).subscribe(res=>{
      if(res && res.Success){
        this.itemGroupObj = res.Data;
      }
    });
  }

  //Click vào icon xóa
  onClickRemoveItem(item){
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa nhóm hàng hóa";
    this.popupDeleteObj.content = 'Bạn có đồng ý xóa nhóm hàng hóa <b>'+ item.ItemGroupName +'</b> không?';
    this.popupDeleteObj.itemDelId = item.ItemGroupID;
    this.popupDeleteObj.visible = true;
  }


  //Xác nhận xóa
  confirmDelele(itemID){
    this.goodsGroupService.delete(itemID).subscribe(res=>{
      if(res && res.Success){
        this.listOfDisplayData = this.listOfDisplayData.filter(item=>item.ItemGroupID != itemID);
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
