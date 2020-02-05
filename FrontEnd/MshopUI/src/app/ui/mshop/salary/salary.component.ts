import { Component, OnInit } from "@angular/core";
import { CommonService } from "src/app/services/common/common.service";
import { WorkdayService } from "src/app/services/workday/workday.service";
import { QueryData } from "src/app/models/shared/query-data";
import { StaffService } from 'src/app/services/staff/staff.service';

export class SalaryTable {
  workdayAmount
  basicSalary: number;
  grant: number;
  personalIncomeTax: number;
  socialInsurance: number;
  realIncome: number;
}

@Component({
  selector: "app-salary",
  templateUrl: "./salary.component.html",
  styleUrls: ["./salary.component.css"]
})
export class SalaryComponent implements OnInit {
  startFilterDate: Date;
  endFilterDate: Date;
  dayInWeek = [];

  salaryTable: SalaryTable[];
  salaryInDeal: string;

  workdayAmount = 0;
  lateWorkdayAmount = 0;
  intimeWorkdayAmount = 0;

  workTimeState = [
    {
      id: 1,
      color: "dodgerblue"
    },
    {
      id: 2,
      color: "#e18e92"
    }
  ];

  settingTabTemplates = [
    {
      id: 1,
      title: "Ngày công",
      icon: "fas fa-portrait",
      template: "working-day"
    },
    {
      id: 2,
      title: "Bảng lương",
      icon: "fas fa-money-check-alt",
      template: "salary-table"
    }
  ];

  appointments = [];
  workdays = [];
  currentDate: Date;
  currentMonth: Date;

  userID = "";
  staffCode = "";

  constructor(
    private commonService: CommonService,
    private workdayService: WorkdayService,
    private staffService: StaffService,
  ) {
    this.dayInWeek = this.commonService.dayInWeek;
    this.salaryTable;
    this.currentDate = new Date();
  }

  ngOnInit() {
    this.userID = localStorage.getItem("UserID");
    this.staffCode = localStorage.getItem("StaffCode");
    this.startFilterDate = new Date(
      this.currentDate.getFullYear(),
      this.currentDate.getMonth(),
      1
    );
    this.endFilterDate = new Date(
      this.currentDate.getFullYear(),
      this.currentDate.getMonth() + 1,
      0
    );
    this.getWorkday();
    this.salaryTable = [];
  }

  getWorkday() {
    var queryData = new QueryData();
    queryData.UserID = this.userID;
    queryData.StartDate = this.startFilterDate;
    queryData.EndDate = this.endFilterDate;
    this.workdayService.getDataByQueryCondition(queryData).subscribe(res => {
      if (res && res.Success) {
        this.bindWorkdayData(res.Data);
      }
    });
  }

  bindWorkdayData(data) {
    this.workdays = [];
    this.lateWorkdayAmount = 0;
    for (let i = 0; i < data.length; i++) {
      let item = {
        stateID: 1,
        text: "Đúng giờ",
        startDate: new Date(data[i].CheckIn),
        endDate: new Date(data[i].CheckOut)
      };
      if(item.startDate.getHours() >= 8 && item.startDate.getHours() > 0){
        item.text = "Muộn giờ";
        item.stateID = 2;
        this.lateWorkdayAmount += 1;
      }
      this.workdays.push(item);
    }
    this.workdayAmount = data.length;
    this.intimeWorkdayAmount = this.workdayAmount - this.lateWorkdayAmount;
    this.calculateStaffSalary();
  }

  changeMonth(e) {
    if (e.name == "currentDate") {
      this.startFilterDate = new Date(
        e.value.getFullYear(),
        e.value.getMonth(),
        1
      );
      this.endFilterDate = new Date(
        e.value.getFullYear(),
        e.value.getMonth() + 1,
        0
      );
      this.getWorkday();
    }
  }

  calculateStaffSalary(){
    this.staffService.getSalaryByStaffCode(this.staffCode).subscribe(res=>{
      if(res && res.Success){
        this.salaryInDeal = res.Data[0].Salary;
        var item = new SalaryTable();
        item.workdayAmount = this.intimeWorkdayAmount;
        item.basicSalary = Math.round((parseInt(this.salaryInDeal)*this.intimeWorkdayAmount/24));
        item.grant = 200000;
        item.personalIncomeTax = Math.round(10*(item.basicSalary)/100);
        item.socialInsurance = 450000;
        item.realIncome = item.basicSalary - item.personalIncomeTax - item.socialInsurance;
        this.salaryTable.push(item);
      }
    });
  }

  onClickCell(e) {
    console.log(e);
  }
}
