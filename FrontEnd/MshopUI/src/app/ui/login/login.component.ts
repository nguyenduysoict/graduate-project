import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Account } from 'src/app/models/account';
import { AccountService } from 'src/app/services/account/account.service';
import { AuthService } from 'src/app/services/auth/auth.service';
import { RoleType } from 'src/app/services/common/enumeration/enumeration';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  validateForm: FormGroup;
  isLoading = true;
  toastVisible = false;
  toastType = "";
  toastMessage = "";
  submitForm(): void {
    for (const i in this.validateForm.controls) {
      this.validateForm.controls[i].markAsDirty();
      this.validateForm.controls[i].updateValueAndValidity();
    }
  }

  account = new Account();

  constructor(private fb: FormBuilder, 
    private router: Router,
    private accountService: AccountService,
    private authService: AuthService
              ) {}

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      username: [null, [Validators.required]],
      password: [null, [Validators.required]],
      remember: [true]
    });
    this.isLoading = false;
  }

  login(){
    this.account.UserName = this.validateForm.value.username;
    this.account.Password = this.validateForm.value.password;
    this.accountService.login(this.account).subscribe(res=>{
      if(res && res.Success){
        const accountInfo = res.Data;
        if(accountInfo.UserName && accountInfo.Password){
          if(accountInfo.RoleType != RoleType.Manager && !accountInfo.StaffName && !accountInfo.StaffCode && !accountInfo.ShopID){
            this.toastVisible = true;
            this.toastType = "error";
            this.toastMessage = "Tài khoản chưa được cấp đủ thông tin trên hệ thống!";
          } else {
            this.isLoading = true;
            this.authService.setUserInfo(res.Data);
            this.router.navigate(['/mshop']);
            setTimeout(() => {
              this.toastVisible = false;
            }, 2000);
          }
          
        } else {
          this.toastVisible = true;
          this.toastType = "error";
          this.toastMessage = "Sai tên tài khoản hoặc mật khẩu!";
          setTimeout(() => {
            this.toastVisible = false;
          }, 2000);
        }

      } else {
        this.toastVisible = true;
        this.toastType = "error";
        this.toastMessage = "Có lỗi xảy ra!";
        setTimeout(() => {
          this.toastVisible = false;
        }, 2000);
      }
    })
  }
}
