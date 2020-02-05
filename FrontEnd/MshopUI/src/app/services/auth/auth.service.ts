import { Injectable } from '@angular/core';
import { Account } from 'src/app/models/account';
import { Router } from '@angular/router';
import { AccountService } from '../account/account.service';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private router: Router,
    private accountService: AccountService) { }

  setAuthInfo(){

  }

  setUserInfo(account:Account){
    localStorage.setItem("StaffCode", account.StaffCode);
    localStorage.setItem("StaffName", account.StaffName);
    localStorage.setItem("ShopID",account.ShopID);
    localStorage.setItem("UserID",account.UserID);
    localStorage.setItem("RoleType",account.RoleType.toString());
  }
  

  logout(){
    const account = new Account();
    account.UserID = localStorage.getItem("UserID");
    account.StaffCode = localStorage.getItem("StaffCode");
    this.accountService.logout(account).subscribe(res=>{
      if(res && res.Success){
        localStorage.clear();
        this.router.navigate(["/login"]);
      }
    });
  }
}