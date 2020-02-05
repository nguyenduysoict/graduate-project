import { Injectable } from '@angular/core';
import { BaseService } from '../base-service/base.service';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ShopService extends BaseService {
  
  controller="Shop";
  // shopList = [
  //   {id: 0, shopName: "Tất cả cửa hàng"},
  //   {id: 1, shopName: "Cơ sở Tây Hồ"},
  //   {id: 2, shopName: "Cơ sở Cầu Giấy"},
  //   {id: 3, shopName: "Cơ sở Giải Phóng"}
  // ]
  constructor(private http: HttpClient) {super(http) }

  // getShopList(){
  //   return this.shopList;
  // }
}
