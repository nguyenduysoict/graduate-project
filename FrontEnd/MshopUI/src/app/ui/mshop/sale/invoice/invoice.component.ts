import { Component, OnInit } from '@angular/core';
import { Invoice } from 'src/app/models/invoice/invoice';
import { CustomerService } from 'src/app/services/customer/customer.service';
import { Customer } from 'src/app/models/customer';
import { InvoiceDetail } from 'src/app/models/invoice/invoice-detail';
import { GoodsService } from 'src/app/services/goods/goods.service';
import { Item } from 'src/app/models/item';
import { InvoiceService } from 'src/app/services/invoice/invoice.service';
import { InvoiceObject } from 'src/app/models/invoice/invoice-object';
import { TransferDataService } from 'src/app/services/transfer-data.service';
import { FormMode, KeyCode, PeriodType } from 'src/app/services/common/enumeration/enumeration';
import { PopupWarning } from 'src/app/models/shared/popup-warning';
import { CommonService } from 'src/app/services/common/common.service';

@Component({
  selector: 'app-invoice',
  templateUrl: './invoice.component.html',
  styleUrls: ['./invoice.component.css']
})


export class InvoiceComponent implements OnInit {

  customerList : Customer[]= [];
  goodsList : Item[] = [];
  invoiceObj = new Invoice();
  invoiceItemList : InvoiceDetail[] = [];
  isLoading = true;
  widthConfig = [
    "50px",
    "150px",
    "",
    "100px",
    "70px",
    "150px",
    "150px",
    "150px",
    "200px",
    "50px"
  ];
  currentStaff = "";
  currentStaffCode = "";
  currentShop = "";
  popupWarning = new PopupWarning();
  scrollConfig = {y: "600px" };

  payOptions = [
    {value: true, name: "Tiền mặt" },
    {value: false, name: "Thẻ" }
  ]


  constructor(private customerService: CustomerService,
            private goodsService: GoodsService,
            private invoiceService: InvoiceService,
            private transferService: TransferDataService,
           ) {
    
   }

  ngOnInit() {
    this.currentStaff= localStorage.getItem("StaffName");
    this.currentStaffCode = localStorage.getItem("StaffCode");
    this.currentShop= localStorage.getItem("ShopID");
    this.getCustomerList();
    this.pushNewOnGrid();
    this.getItemList();
    this.getInvoiceNo();
    this.invoiceObj.StaffName = this.currentStaff;
  }
 

  onChangePhoneNumber(e){
    const customerPhone = e.value;
    var customer = this.customerList.find(item => item.PhoneNumber == customerPhone);
    if(customer){
      this.invoiceObj.CustomerName = customer.CustomerName;
      this.invoiceObj.CustomerAddress = customer.CustomerAddress;
    }
  }

  // bắt sự kiện keyup trên dx-text-box
  onKeyUpOnTextBox(e, i){
    if(e){
      const keyCode = e.event.keyCode;
      if(keyCode == KeyCode.Enter || keyCode == KeyCode.Tab){
        this.pushNewOnGrid();
      }
    }
  }

  onSave(){
    if(this.checkValid()){
      this.invoiceObj.ShopID = this.currentShop;
      this.invoiceObj.StaffCode = this.currentStaffCode;
      this.invoiceItemList = this.invoiceItemList.filter(item=> item.IsShow && item.SKUCode && item.Amount);
      for (let index = 0; index < this.invoiceItemList.length; index++) {
        this.invoiceItemList[index].ShopID = this.currentShop;      
      }
      const invoiceObject = new InvoiceObject();
      invoiceObject.Invoice = this.invoiceObj;
      invoiceObject.InvoiceDetails = this.invoiceItemList;
      invoiceObject.FormMode = FormMode.Insert;
      this.invoiceService.save(invoiceObject).subscribe(res=>{
        if(res && res.Success){
          this.clearForm();
          this.transferService.showToast(true);
        } else {
          this.transferService.showToast(false);
        }
      });
    }
  }

  //Bắt sự kiện thay đổi 
  onAmountChange(e, i){
    const textboxValue = e.value;
    if(textboxValue){
      var temp = textboxValue*(this.invoiceItemList[i].UnitPrice);
      this.invoiceItemList[i].TotalMoney = temp;
      this.calculateTotalMoney();
    }
  }

  //Chọn 1 hàng hóa trên select box
  onSelectItem(e, i){
    const item = e.value;
    if(item){
      this.invoiceItemList[i].SKUCode = item.SKUCode;
      this.invoiceItemList[i].ItemName = item.ItemName;
      this.invoiceItemList[i].Color = item.ItemColor;
      this.invoiceItemList[i].Size = item.ItemSize;
      this.invoiceItemList[i].Unit = item.UnitName;
      this.invoiceItemList[i].UnitPrice = item.SellPrice;
      this.invoiceItemList[i].ItemGroupName = item.ItemGroupName;
      this.invoiceItemList[i].ItemGroupCode = item.ItemGroupCode;
      this.pushNewOnGrid();
    }
  }

  //Xóa bớt mặt hàng trong danh sách bảng
  onClickRemoveItem(i){
    const showingItemList = this.invoiceItemList.filter(item=> item.IsShow);
    if(showingItemList.length>1){
      this.invoiceItemList[i].IsShow = false;
    }
  }


  //Lấy danh sách khách hàng
  getCustomerList(){
    this.customerService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.isLoading = false;
        this.customerList = [...res.Data];
      }
    })
  }

  onCustomItemCreating (e) {
    const newCustomer = new Customer();
    newCustomer.PhoneNumber = e.text;
    this.invoiceObj.CustomerPhone = e.text;
    this.customerList.push(newCustomer);
  }

  pushNewOnGrid(){
    var count = 0;
    for (let i = 0; i < this.invoiceItemList.length; i++) {
      const element = this.invoiceItemList[i];
      if ((!element.SKUCode || !element.Amount) && element.IsShow) {
        count += 1;
      }
    }

    if(count == 0){
      const newRow = new InvoiceDetail();
      newRow.IsShow = true;
      this.invoiceItemList = [...this.invoiceItemList, newRow];
    }
  }

  getItemList(){
    this.goodsService.getAll().subscribe(res=>{
      if(res && res.Success){
        this.goodsList = [...res.Data];
      }
    })
  }

  getInvoiceNo(){
    this.invoiceService.getNo().subscribe(res=>{
      if(res && res.Success){
        this.invoiceObj.InvoiceNo = res.Data;
      }
    })
  }


  //Hàm tính tổng tiền trên hóa đơn
  calculateTotalMoney(){
    this.invoiceObj.TotalMoney = 0;
    for (let i = 0; i < this.invoiceItemList.length; i++) {
      const element = this.invoiceItemList[i];
      if(element.TotalMoney){
        this.invoiceObj.TotalMoney += element.TotalMoney;
      }
    }
  }

  checkValid(){
    const result = this.invoiceItemList.findIndex(item=> item.IsShow && item.SKUCode != ""  && item.Amount != null);
    if(result == -1){
      this.showEmptyPopupWarning();
      return false;
    } else {
      const check1 = this.invoiceItemList.findIndex(item=> item.IsShow && item.SKUCode != "" && item.Amount == null);
      const check2 = this.invoiceItemList.findIndex(item=> item.IsShow && item.SKUCode == "" && item.Amount != null);
      if(check1 == -1 && check2 == -1){
        return true;
      } else {
        this.showMissingFieldWarning();
        return false;
      }
    }
  }
  
  clearForm(){
    this.invoiceObj = new Invoice();
    this.invoiceItemList = [];
    this.pushNewOnGrid();
    this.getInvoiceNo();
  }

  showEmptyPopupWarning(){
    this.popupWarning.visible = true;
    this.popupWarning.content = "Phải có ít nhất một hàng hóa!";
  }

  showMissingFieldWarning(){
    this.popupWarning.visible = true;
    this.popupWarning.content = "Tên hàng hóa không được để trống và số lượng tối thiểu phải bằng 1!";
  }

  closeWarningPopup(){
    this.popupWarning.visible = false;
  }
}
