import { Component, OnInit } from '@angular/core';
import { CommonService } from 'src/app/services/common/common.service';
import { Setting } from 'src/app/models/setting';
import { FormMode } from 'src/app/services/common/enumeration/enumeration';
import { SettingService } from 'src/app/services/setting/setting.service';
import { TransferDataService } from 'src/app/services/transfer-data.service';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.css']
})
export class SettingsComponent implements OnInit {

  dayInWeek = [];
  settingTabTemplates = [
    { id: 1, title: "Thiết lập chung", icon:"fas fa-cog",template: "common-setting" },
  ]
  settingObj : Setting = new Setting();
  formMode: FormMode = FormMode.Insert;
  constructor(private commonService: CommonService,
    private settingService: SettingService,
    private transferService: TransferDataService,) {
    this.dayInWeek = this.commonService.dayInWeek;
  }

  ngOnInit() {
    this.getSettings();
  }

  getSettings(){
    this.settingService.getAll().subscribe(res=>{
      if(res && res.Success){
        if(res.Data.length){
          this.formMode = FormMode.Update;
          this.settingObj = res.Data[0];
        } else {
          this.formMode = FormMode.Insert;
        }
      }
    })
  }

  onSave(){
    console.log(this.settingObj);
    this.settingObj.FormMode = this.formMode;
    this.settingService.save(this.settingObj).subscribe(res=>{
      if(res && res.Success){
        if(this.formMode == FormMode.Insert){
          this.settingObj.SettingID = res.Data;
        }
        this.transferService.showToast(true);
      }
    });
  }

}
