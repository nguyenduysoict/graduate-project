import { Component, OnInit } from "@angular/core";
import { GoodsGroup } from 'src/app/models/good-group';
import { GoodsGroupService } from 'src/app/services/goods/goods-group.service';
import { UnitService } from 'src/app/services/unit/unit.service';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { FormMode } from 'src/app/services/common/enumeration/enumeration';
import { Unit } from 'src/app/models/unit';
import { Sizes, Colors } from 'src/app/services/common/constant/constant';
import { Item } from 'src/app/models/item';
import { GoodsService } from 'src/app/services/goods/goods.service';
import { PopupDelObject } from 'src/app/models/shared/popup-delete-object';
import * as cloneDeep from 'lodash/cloneDeep';
import { Toast } from 'src/app/models/shared/toast';

@Component({
  selector: "app-goods-list",
  templateUrl: "./goods-list.component.html",
  styleUrls: ["./goods-list.component.css"]
})
export class GoodsListComponent implements OnInit {
  isShowDataGrid = true;
  visibleDelPopup = false;
  goodsPicSrc:any;
  formMode: FormMode;
  popupDeleteObj = new PopupDelObject();
  searchModeOption: string = "contains";
  itemGroupSearchExprOption: any = "ItemGroupName";
  unitSearchExprOption: any = "UnitName";
  itemGroupList: GoodsGroup[] = [];
  unitList: Unit[] = [];
  sizes = Sizes;
  colors = Colors;
  itemObj = new Item();
  listOfDisplayData : Item[]= [];
  itemMergeName = "";

  widthConfig = [
    "200px",
    "",
    "250px",
    "150px",
    "100px"
  ];

  scrollConfig = { y: "600px" };

  constructor(
    private goodsGroupService: GoodsGroupService,
    private goodsService: GoodsService,
    private unitService: UnitService,
    private transferService: TransferDataService
  ) {}

  ngOnInit() {
    this.getItemList();
    this.getItemGroup();
    this.getUnits();
  }

 
  getItemList(){
    this.goodsService.getAll().subscribe(res=>{
      console.log(res);
      if(res && res.Success){
        this.listOfDisplayData = [...res.Data];
      }
    })
  }

  //Nhấn thêm mới 1 hàng hóa
  onClickAddItem() {
    this.isShowDataGrid = false;
    this.formMode = FormMode.Insert;
    this.itemObj = new Item();
    this.goodsPicSrc = "";
    this.itemMergeName = "";
  }

  //Nhấn sửa 1 hàng hóa
  onClickEditItem(item){
    this.isShowDataGrid = false;
    this.formMode = FormMode.Update;
    this.goodsService.getByID(item.ItemID).subscribe(res=>{
      if(res && res.Success){
        this.itemObj = res.Data;
        this.goodsPicSrc = this.itemObj.ItemImage;
      }
    })
  }


  //Click icon xóa
  onClickRemoveItem(item){
    this.visibleDelPopup = true;
    this.popupDeleteObj.title = "Xóa hàng hóa";
    this.popupDeleteObj.content = 'Bạn có đồng ý xóa hàng hóa <b>'+ item.ItemName +'</b> không?';
    this.popupDeleteObj.itemDelId = item.ItemID;
    this.popupDeleteObj.visible = true;
  }

  //Xác nhận xóa
  confirmDelele(itemID){
    this.goodsService.delete(itemID).subscribe(res=>{
      if(res && res.Success){
        this.listOfDisplayData = this.listOfDisplayData.filter(item=>item.ItemID != itemID);
        this.transferService.showToast(true);
        this.visibleDelPopup = false;
      } else {
        this.transferService.showToast(false);
      }
    })
  }


  uploadImage(e) {
    let imageFile = <File>e.target.files[0];
    if (imageFile) {
      const fileReader = new FileReader();  
      fileReader.readAsDataURL(imageFile);
      fileReader.onload = (_event) => { 
        this.goodsPicSrc = fileReader.result.toString();
      }
      const itemImage = new FormData();
      itemImage.append('file', imageFile);
      this.goodsService.upload(itemImage).subscribe(res=>{
        if(res && res.Success){
          this.itemObj.ItemImage = res.Data;
        } else if(res && !res.Success && res.Message){
          this.transferService.showToast(false, res.Message)
        } else {
          this.transferService.showToast(false);
        }
      })
    }
  }


  save(mode?){
    this.itemObj.FormMode = this.formMode;
    this.createItemName();
    this.goodsService.save(this.itemObj).subscribe(res=>{
      if(res && res.Success){
        this.transferService.showToast(true);
        if(this.formMode == FormMode.Insert){
          this.itemObj.ItemID = res.Data;
          this.listOfDisplayData = [this.itemObj,...this.listOfDisplayData];
        } else if(this.formMode == FormMode.Update) {
          this.itemObj = res.Data;
          const updateItemIndex = this.listOfDisplayData.findIndex(item=> item.ItemID == this.itemObj.ItemID);
          this.listOfDisplayData[updateItemIndex] = res.Data;
          this.listOfDisplayData = this.listOfDisplayData.filter(item=> item.ItemID != "");
        }
        if(mode == 1){
          this.cancelGoodsForm();
        } else if(mode == 2){
          this.itemObj.ItemID = "";
        } else if(mode == 3){
          this.onClickAddItem();
        }
      }
    });
  }


  //Tạo item name
  createItemName(){
    if(this.itemObj.ItemColor && this.itemObj.ItemSize && !this.itemMergeName){
      this.itemMergeName= this.itemObj.ItemName + " ("+this.itemObj.ItemColor+"/"+this.itemObj.ItemSize+")";
      this.itemObj.ItemName = this.itemMergeName;
    }
  }

  onSave(e, mode?){
    let result = e.validationGroup.validate();
    if (result.isValid) {
      this.save(mode);
    }
  }


  //Xử lý khi chọn nhóm hàng hóa
  onSelectItemGroup(e){
    if(e.value){
      const itemGroup = this.itemGroupList.find(item=>item.ItemGroupName == e.value);
      if(itemGroup){
        this.itemObj.ItemGroupCode = itemGroup.ItemGroupCode;
      }
    }
  }


  //Lấy danh sách nhóm hàng hóa
  getItemGroup(){
    this.goodsGroupService.getAll().subscribe(res=>{
      if(res && res.Success && res.Data.length) {
        this.itemGroupList = [...res.Data];
      } else {
        this.transferService.showToast(false);
      }
    });
  }

  //Lấy danh sách đơn vị tính
  getUnits(){
    this.unitService.getAll().subscribe(res=>{
      if(res && res.Success && res.Data.length) {
        this.unitList = [...res.Data];
      } else {
        this.transferService.showToast(false);
      }
    });
  }

  cancelGoodsForm() {
    this.isShowDataGrid = true;
  }

   //Hủy không xóa
   cancelDel(){
    this.visibleDelPopup = false;
  }
}
