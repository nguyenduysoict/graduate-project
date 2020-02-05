import { Component, OnInit } from "@angular/core";
import { Router } from "@angular/router";
import { ShopService } from "src/app/services/shop/shop.service";
import { TransferDataService } from "src/app/services/transfer-data.service";
import { Toast } from "src/app/models/shared/toast";
import { ToastType, RoleType } from "src/app/services/common/enumeration/enumeration";
import { AuthService } from 'src/app/services/auth/auth.service';
import { Shop } from 'src/app/models/shop';

@Component({
  selector: "app-mshop",
  templateUrl: "./mshop.component.html",
  styleUrls: ["./mshop.component.css"]
})
export class MshopComponent implements OnInit {
  title = "Tổng quan";
  currentShop = "";
  shopsList = [];
  toastType = "";
  toastMessage = "";
  toastVisible = false;
  currentUser = "";
  userRole :number;
  isStaff = false;

  constructor(
    private shopService: ShopService,
    private transferDataService: TransferDataService,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit() {
    this.currentUser = localStorage.getItem("StaffName");
    this.userRole = parseInt(localStorage.getItem("RoleType"));
    this.getShopList();
    this.showToast();
  }

  showToast() {
    this.transferDataService.toastShow.subscribe(res => {
      if (res.Type) {
        this.toastType = res.Type;
        this.toastMessage = res.Message;
      } else {
        if(res){
          this.toastType = "success";
          this.toastMessage = "Thành công.";
        } else {
          this.toastType = "error";
          this.toastMessage = "Có lỗi xảy ra!";
        }
      }
      this.toastVisible = true;
      setTimeout(() => {
        this.toastVisible = false;
      }, 2000);
    });
  }

  getShopList() {
    this.shopService.getAll().subscribe(res => {
      if (res && res.Success) {
        this.shopsList = res.Data;
        if (this.userRole != RoleType.Manager) {
          this.isStaff = true;
          this.router.navigate(['/mshop/ban-hang/lap-hoa-don']);
          const staffShop = localStorage.getItem("ShopID");
          var index = this.shopsList.findIndex(item=>item.ShopID == staffShop);
          this.currentShop = this.shopsList[index].ShopName;
        } else {
          var allOption = new Shop();
          allOption.ShopName = "Tất cả cửa hàng";
          this.shopsList.unshift(allOption);
          this.currentShop = this.shopsList[0].ShopName;
          this.isStaff = false;
        }
        localStorage.setItem("currentShop", this.currentShop);
      }
    });
  }

  logout() {
    this.authService.logout();
  }

  onSelectShop(item) {
    this.currentShop = item.ShopName;
    localStorage.setItem("currentShop", item.ShopName);
    localStorage.setItem("ShopID", item.ShopID);
    this.transferDataService.changeShop(item);
  }

  onSelectMenuItem(itemIndex) {
    switch (itemIndex) {
      case 0:
        this.title = "Tổng quan";
        break;
      case 1:
        this.title = "Báo cáo bán hàng";
        break;
      case 2:
        this.title = "Báo cáo kho";
        break;
      case 3:
        this.title = "Nhập kho";
        break;
      case 4:
        this.title = "Xuất kho";
        break;
      case 5:
        this.title = "Thu, chi tiền";
        break;
      case 6:
        this.title = "Cửa hàng";
        break;
      case 7:
        this.title = "Hàng hóa";
        break;
      case 8:
        this.title = "Nhóm hàng hóa";
        break;
      case 9:
        this.title = "Đơn vị tính";
        break;
      case 10:
        this.title = "Nhân viên";
        break;
      case 11:
        this.title = "Khách hàng";
        break;
      case 12:
        this.title = "Nhà cung cấp";
        break;
      case 13:
        this.title = "Thiết lập";
        break;
      case 14:
        this.title = "Bán hàng";
        break;
      case 15:
        this.title = "Tra cứu lương";
        break;
      case 16:
        this.title = "Hóa đơn";
        break;
      case 17:
        this.title = "Báo cáo thu, chi";
        break;
      default:
        break;
    }
  }
  onClickChangePass() {}
}
