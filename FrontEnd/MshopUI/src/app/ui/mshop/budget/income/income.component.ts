import {
  Component,
  OnInit,
  ViewChild,
  ViewChildren,
  ElementRef,
  QueryList
} from "@angular/core";
import {
  ReceiptType,
  FormMode,
  PeriodType
} from "src/app/services/common/enumeration/enumeration";
import { Receipt } from "src/app/models/receipt/receipt";
import { ReceiptService } from "src/app/services/receipt/receipt.service";
import {
  InReceiptCategory,
  OutReceiptCategory,
  PeriodList
} from "src/app/services/common/constant/constant";
import { ReceiptDetail } from "src/app/models/receipt/receipt-detail";
import { ReceiptObject } from "src/app/models/receipt/receipt-object";
import { TransferDataService } from "src/app/services/transfer-data.service";
import * as cloneDeep from "lodash/cloneDeep";
import $ from "jquery";
import { PopupDelObject } from "src/app/models/shared/popup-delete-object";
import { PopupWarning } from 'src/app/models/shared/popup-warning';
import { CommonService } from 'src/app/services/common/common.service';
import { QueryCondition } from 'src/app/models/shared/query-condition';

@Component({
  selector: "app-income",
  templateUrl: "./income.component.html",
  styleUrls: ["./income.component.css"]
})
export class IncomeComponent implements OnInit {
  receiptType: ReceiptType;

  @ViewChildren("masterRow") masterRow: QueryList<any>;

  popupTitle = "";
  widthConfig = ["150px", "150px", "200px", "150px", "", "200px"];
  widthGridDetailConfig = ["", "200px", "300px"];
  scrollConfig = { y: "350px" };
  widthDetailConfig = ["", "150px", "250px", "40px"];
  scrollGridDetailConfig = { y: "200px" };
  scrollDetailConfig = { y: "200px" };
  purposeRadioValue = 1;
  isShowPopup = false;
  purposes = ["Khác", "Điều chuyển từ cửa hàng khác"];
  isInReceipt = false;
  receiptObj = new Receipt();
  popupWarning = new PopupWarning();
  isLoading = true;
  receiptCategory = [];

  listOfDisplayData: Receipt[] = [];

  periods = [];
  selectedPeriodId : number; // ID kỳ báo cáo ;
  selectedPeriod = "";

  listOfDetailData: ReceiptDetail[] = [];
  gridDetailData: ReceiptDetail[] = [];
  currentShop = "";
  popupDeleteObj = new PopupDelObject();
  visibleDelPopup: boolean = false;
  formMode: FormMode;

  startFilterDate: Date = new Date();
  endFilterDate: Date = new Date();

  constructor(
    private receiptService: ReceiptService,
    private transferService: TransferDataService,
    private commonService: CommonService
  ) {}

  ngOnInit() {
    this.selectedPeriodId = 1;
    this.selectedPeriod = "Hôm nay";
    this.periods = PeriodList;
    this.currentShop = localStorage.getItem("ShopID");
    this.getReceipts();
    this.transferService.shopChange.subscribe(res=>{
      this.currentShop = res.ShopID;
      this.getReceipts();
    })
  }

  getReceipts() {
    this.isLoading = true;
    var queryCondition = new QueryCondition();
    queryCondition.ShopID = this.currentShop;
    queryCondition.StartDate = this.startFilterDate;
    queryCondition.EndDate = this.endFilterDate;
    this.gridDetailData = []
    this.receiptService.getDataByQueryCondition(queryCondition).subscribe(res => {
      console.log(res);
      this.isLoading = false;
      if (res && res.Success) {
        this.listOfDisplayData = [...res.Data];
        for (let i = 0; i < this.listOfDisplayData.length; i++) {
          this.listOfDisplayData[i].IsSelected = false;
        }
      }
    });
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

  showReceiptPopup(option) {
    this.formMode = FormMode.Insert;
    if (option == 0) {
      this.isShowPopup = true;
      this.showAddIncomeReceipt();
    } else if (option == 1) {
      this.isShowPopup = true;
      this.showAddPaymentReceipt();
    } else {
      const selectedIndex = this.listOfDisplayData.findIndex(
        item => item.IsSelected == true
      );
      if (selectedIndex != -1) {
        this.receiptObj = cloneDeep(this.listOfDisplayData[selectedIndex]);
        this.listOfDetailData = cloneDeep(this.gridDetailData);
        const receiptType = this.receiptObj.ReceiptType == ReceiptType.Income ? "thu" : "chi";
        if(this.receiptObj.ReceiptType == ReceiptType.Income){
          this.receiptCategory = InReceiptCategory;
        } else {
          this.receiptCategory = OutReceiptCategory;
        }
        if (option == FormMode.Duplicate) {
          this.popupTitle = "Nhân bản phiếu " + receiptType;          
          this.isShowPopup = true;
          this.getReceiptNo();
          this.receiptObj.ReceiptID = "";
          for (let i = 0; i < this.listOfDetailData.length; i++) {
            this.listOfDetailData[i].ReceiptID = "";
            this.listOfDetailData[i].ReceiptDetailID = "";
          }
          this.pushNewOnGrid();
        } else if (option == FormMode.Update) {
          this.popupTitle = "Sửa phiếu " + receiptType;
          this.isShowPopup = true;
          this.formMode = FormMode.Update;
          this.pushNewOnGrid();
        } else if (option == FormMode.Delete) {
          this.formMode = FormMode.Delete;
          this.onClickRemoveItem(this.receiptObj);
        }
      }
    }
  }

  //Click xóa phiếu trên popup
  onClickDeleteReceipt() {
    if (this.formMode == FormMode.Update && this.receiptObj.ReceiptID) {
      this.onClickRemoveItem(this.receiptObj);
    }
  }

  //Click vào icon xóa
  onClickRemoveItem(item) {
    this.visibleDelPopup = true;
    const receiptType =
      item.ReceiptType == ReceiptType.Income ? "phiếu thu" : "phiếu chi";
    this.popupDeleteObj.title = "Xóa " + receiptType;
    this.popupDeleteObj.content =
      "Bạn có đồng ý xóa " +
      receiptType +
      " <b>" +
      item.ReceiptNo +
      "</b> không?";
    this.popupDeleteObj.itemDelId = item.ReceiptID;
    this.popupDeleteObj.visible = true;
  }

  //Xác nhận xóa
  confirmDelele(itemID) {
    this.receiptService.delete(itemID).subscribe(res => {
      if (res && res.Success) {
        this.listOfDisplayData = this.listOfDisplayData.filter(
          item => item.ReceiptID != itemID
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

  onClickRemoveDetailItem(i) {
    this.listOfDetailData.splice(i,1);
    // const currentItem = this.invoiceItemList[i].CurrentItemID;
    // this.invoiceItemList = this.invoiceItemList.filter(item => {item.CurrentItemID != currentItem});
  }

  //Lập phiếu thu
  showAddIncomeReceipt() {
    this.getReceiptNo();
    this.clearForm();
    this.receiptObj.StaffName = localStorage.getItem("StaffName");
    this.receiptObj.StaffCode = localStorage.getItem("StaffCode");
    this.isInReceipt = true;
    this.receiptType = ReceiptType.Income;
    this.receiptObj.ReceiptType = ReceiptType.Income;
    this.popupTitle = "Thêm mới phiếu thu";
    this.receiptCategory = InReceiptCategory;
  }

  //Lập phiếu chi
  showAddPaymentReceipt() {
    this.getReceiptNo();
    this.clearForm();
    this.receiptObj.StaffName = localStorage.getItem("StaffName");
    this.receiptObj.StaffCode = localStorage.getItem("StaffCode");
    this.isInReceipt = false;
    this.receiptType = ReceiptType.Payment;
    this.receiptObj.ReceiptType = ReceiptType.Payment;
    this.popupTitle = "Thêm mới phiếu chi";
    this.receiptCategory = OutReceiptCategory;
  }

  // bắt sự kiện keyup trên dx-text-box
  onKeyUpOnTextBox(e, i) {
    if (e) {
      const keyCode = e.event.keyCode;
      if (keyCode == 13) {
        this.pushNewOnGrid();
      }
    }
  }

  //Bắt sự kiện thay đổi
  onMoneyChange(e, i) {
    const textboxValue = e.value;
    if (textboxValue) {
      this.calculateTotalMoney();
    }
  }

  getReceiptNo() {
    this.receiptService.getNo().subscribe(res => {
      if (res && res.Success) {
        this.receiptObj.ReceiptNo = res.Data;
      }
    });
  }

  onSave() {
    if(this.checkValid()){
      this.listOfDetailData = this.listOfDetailData.filter(item=>item.Money && item.ReceiptCategory);
      this.receiptObj.ShopID = this.currentShop;
      for (let i = 0; i < this.listOfDetailData.length; i++) {
        this.listOfDetailData[i].ShopID = this.currentShop;
      }
      const receiptObject = new ReceiptObject();
      receiptObject.Receipt = this.receiptObj;
      receiptObject.ReceiptDetails = this.listOfDetailData;
      receiptObject.FormMode = this.formMode;
      this.receiptService.save(receiptObject).subscribe(res => {
        if (res && res.Success) {
          this.isShowPopup = false;
          this.transferService.showToast(true);
          // if(this.formMode == FormMode.Insert || this.formMode == FormMode.Duplicate){
          //   this.receiptObj.ReceiptID = res.Data;
          //   this.listOfDisplayData = [this.receiptObj, ...this.listOfDisplayData];
          // } else {
          // }
          this.startFilterDate = new Date();
          this.endFilterDate = new Date();
          this.getReceipts();
        } else {
          this.transferService.showToast(false);
        }
      });
    }
  }

  // chèn thêm 1 hàng lên bảng detail
  pushNewOnGrid() {
    var count = 0;
    for (let i = 0; i < this.listOfDetailData.length; i++) {
      const element = this.listOfDetailData[i];
      if (!element.Money) {
        count += 1;
      }
    }
    if (count == 0) {
      const newRow = new ReceiptDetail();
      // newRow.CurrentItemID = uuid.v4();
      this.listOfDetailData = [...this.listOfDetailData, newRow];
    }
  }

  //Chọn 1 hàng hóa trên select box
  onSelectItem(e, i) {
    const item = e.value;
    if (item) {
      this.pushNewOnGrid();
    }
  }

  clearForm() {
    this.receiptObj = new Receipt();
    this.listOfDetailData = [];
    this.pushNewOnGrid();
  }

  //Hàm tính tổng tiền trên hóa đơn
  calculateTotalMoney() {
    this.receiptObj.TotalMoney = 0;
    for (let i = 0; i < this.listOfDetailData.length; i++) {
      const element = this.listOfDetailData[i];
      if (element.Money) {
        this.receiptObj.TotalMoney += element.Money;
      }
    }
  }

  onSelectMaster(receiptID, index) {
    this.listOfDisplayData.map(item => (item.IsSelected = false));
    this.listOfDisplayData[index].IsSelected = true;
    this.receiptService.getByFieldName(receiptID).subscribe(res => {
      if (res && res.Success) {
        this.gridDetailData = [...res.Data];
      }
    });
  }

  checkValid(){
    const result = this.listOfDetailData.findIndex(item=> item.Money != null && item.ReceiptCategory != "");
    if(result == -1){
      this.showPopupWarning();
      return false;
    } else {
      return true;
    }
  }


  showPopupWarning(){
    this.popupWarning.visible = true;
    this.popupWarning.content = "Phải có ít nhất một chi tiết!";
  }
  closeWarningPopup(){
    this.popupWarning.visible = false;
  }
}
