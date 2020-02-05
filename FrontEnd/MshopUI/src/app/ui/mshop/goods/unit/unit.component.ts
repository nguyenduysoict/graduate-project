import { Component, OnInit } from '@angular/core';
import { UnitService } from 'src/app/services/unit/unit.service';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { ToastType, FormMode } from 'src/app/services/common/enumeration/enumeration';
import { Unit } from 'src/app/models/unit';
import { Toast } from 'src/app/models/shared/toast';
import * as cloneDeep from "lodash/cloneDeep";
import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';

@Component({
  selector: 'app-unit',
  templateUrl: './unit.component.html',
  styleUrls: ['./unit.component.css']
})
export class UnitComponent implements OnInit {

  popupTitle = "";
  popupVisible = false;
  isLoading = true;
  unitObj = new Unit();
  pageIndex: number = 1;

  formMode : FormMode;
  visibleDelPopup = false;
  popupDeleteObj = new PopupDelObject();

  listOfDisplayData: Unit[] = [
  ];
  popupDelete = {
  };
  widthConfig = [
    "200px",
    "",
    "200px",
    "100px"
  ];

  scrollConfig = { y: "600px" };
  constructor(
    private unitService: UnitService,
    private transferService: TransferDataService) { }

  ngOnInit() {
    this.getUnits();
  }

  getUnits(){
    this.isLoading = true;
    this.unitService.getAll().subscribe(res=>{
      this.isLoading = false;
      if(res && res.Success && res.Data.length) {
        this.listOfDisplayData = [...res.Data];
      } else {
        this.transferService.showToast(false);
      }
    });
  }

  onClickAddNew(){
    this.formMode = FormMode.Insert;
    this.unitObj = new Unit();
    this.popupTitle = "Thêm mới đơn vị tính";
    this.showPopupItem();
  }

  showPopupItem(){
    this.popupVisible = true;
  }


  onSave(){
    console.log(this.unitObj);
    this.unitObj.FormMode = this.formMode;
    this.unitService.save(this.unitObj).subscribe(res=>{
      this.popupVisible = false;
      if(res && res.Success){
        this.getUnits();
        // this.unitObj.UnitID = res.Data;
        // this.listOfDisplayData = [this.unitObj,...this.listOfDisplayData];
        this.transferService.showToast(true);
      } else {
        this.transferService.showToast(false);
      }
    })
  }


  editItem(item){
    this.formMode = FormMode.Update;
    this.unitObj = cloneDeep(item);
    this.popupTitle = "Sửa đơn vị tính";
    this.showPopupItem();
  }

  onClickRemove(item){
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa đơn vị tính";
    this.popupDeleteObj.content =
      "Bạn có đồng ý xóa đơn vị tính <b>" +
      item.UnitName +
      "</b> không?";
    this.popupDeleteObj.itemDelId = item.UnitID;
    this.popupDeleteObj.visible = true;
  }

   //Xác nhận xóa
   confirmDelele(itemID) {
    this.unitService.delete(itemID).subscribe(res => {
      if (res && res.Success) {
        this.listOfDisplayData = this.listOfDisplayData.filter(
          item => item.UnitID != itemID
        );
        this.transferService.showToast(true);
        this.visibleDelPopup = false;
      } else {
        this.transferService.showToast(false);
      }
    });
  }

  onCancel(){
    this.popupVisible = false;
  }
}
