import { Injectable } from '@angular/core';
import { PeriodType } from './enumeration/enumeration';

import * as moment from 'moment';

@Injectable({
  providedIn: 'root'
})
export class CommonService {

  dayInWeek = [
    {id: 2, day: "Thứ 2"},
    {id: 3, day: "Thứ 3"},
    {id: 4, day: "Thứ 4"},
    {id: 5, day: "Thứ 5"},
    {id: 6, day: "Thứ 6"},
    {id: 7, day: "Thứ 7"},
    {id: 8, day: "Chủ nhật"}
  ]

  constructor() { }

  getRandomStartHour(){
    let startHour = [6, 6.25, 6.45 , 6.5,7, 7.15, 7.25, 7.5, 7.45, 7.6, 7.75];
    let randomIndex = Math.floor(Math.random()*11);
    return startHour[randomIndex]
  }

  getRamdomEndHour(){
    let endHour = [18, 18.25, 18.15, 18.5,19, 19.15, 19.25, 19.5, 19.45, 19.6, 19.75];
    let randomIndex = Math.floor(Math.random()*11);
    return endHour[randomIndex];
  }

  getRandomBoolean(){
    let booleans = [true, false];
    let randomIndex = Math.floor(Math.random()*2);
    return booleans[randomIndex];
  }


  getStartDate(type){
    let startDate : Date = new Date();
    let fullYear = startDate.getFullYear();
    switch (type) {
      case PeriodType.Today:
        break;
      case PeriodType.Yesterday:
        startDate.setDate(startDate.getDate()-1);
        let yesterday = (startDate.getMonth()+1)  + '/' + startDate.getDate() + '/' + fullYear;
        startDate = new Date(yesterday);
        break;
      case PeriodType.ThisWeek:
        var tempt = moment().startOf('week').toDate();
        tempt.setDate(tempt.getDate());
        var startWeek = (tempt.getMonth()+1)  + '/' + tempt.getDate() + '/' + fullYear;
        startDate = new Date(startWeek);
        break;
      case PeriodType.PreWeek:
        var tempt = moment().startOf('week').toDate();
        tempt.setDate(tempt.getDate() - 7);
        var startWeek = (tempt.getMonth()+1)  + '/' + tempt.getDate() + '/' + fullYear;
        startDate = new Date(startWeek);
        break;
      case PeriodType.ThisMonth:
        startDate = moment().startOf('month').toDate();
        break;
      case PeriodType.PreMonth:
        if (startDate.getMonth() == 0){
          var startMonth = '12/01/' + (fullYear-1);
        } else {
          var startMonth = (startDate.getMonth())  + '/01/' + fullYear;
        }
        startDate = new Date(startMonth);
        break;
      case PeriodType.ThisYear:
        var temp = '01/01/'+fullYear;
        startDate = new Date(temp);
        break;
      case PeriodType.PreYear:
        fullYear = fullYear - 1;
        var startYear = ('01/01/' + fullYear);
        startDate = new Date(startYear);
        break;
      case PeriodType.January:
        var temp = "01/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.February:
        var temp = "02/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.March:
        var temp = "03/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.April:
        var temp = "04/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.May:
        var temp = "05/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.June:
        var temp = "06/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.July:
        var temp = "07/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.August:
        var temp = "08/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.September:
        var temp = "09/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.October:
        var temp = "10/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.November:
        var temp = "11/01/2020";
        startDate = new Date(temp);
        break;
      case PeriodType.December:
        var temp = "12/01/2020";
        startDate = new Date(temp);
        break;
      default:
        break;
    }
    return startDate;
  }

  getEndDate(type){
    let endDate : Date = new Date();
    let fullYear = endDate.getFullYear();
    switch (type) {
      case PeriodType.Today:
        break;
      case PeriodType.Yesterday:
        endDate.setDate(endDate.getDate()-1);
        let yesterday = (endDate.getMonth()+1)  + '/' + endDate.getDate() + '/' + fullYear;
        endDate = new Date(yesterday);
        break;
      case PeriodType.ThisWeek:
        var tempt = moment().endOf('week').toDate();
        tempt.setDate(tempt.getDate());
        var endWeek = (tempt.getMonth()+1)  + '/' + tempt.getDate() + '/' + fullYear;
        endDate = new Date(endWeek);
        break;
      case PeriodType.PreWeek:
        var tempt = moment().endOf('week').toDate();
        tempt.setDate(tempt.getDate() - 7);
        var endWeek = (tempt.getMonth()+1)  + '/' + tempt.getDate() + '/' + fullYear;
        endDate = new Date(endWeek);
        break;
      case PeriodType.ThisMonth:
        endDate =  moment().endOf('month').toDate();
        break;
      case PeriodType.PreMonth:
        if(endDate.getMonth() == 0){
          var endMonth = '12/31/' + (fullYear - 1);
        } else {
          var endMonth = (endDate.getMonth())  + '/30/' + fullYear;
        }
        endDate = new Date(endMonth);
        break;
      case PeriodType.ThisYear:
        var temp = "12/31/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.PreYear:
        fullYear = fullYear - 1;
        var endYear = ('12/31/' + fullYear);
        endDate = new Date(endYear);
        break;
      case PeriodType.January:
        var temp = "01/31/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.February:
        var temp = "02/28/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.March:
        var temp = "03/31/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.April:
        var temp = "04/30/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.May:
        var temp = "05/31/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.June:
        var temp = "06/30/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.July:
        var temp = "07/31/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.August:
        var temp = "08/31/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.September:
        var temp = "09/30/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.October:
        var temp = "10/31/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.November:
        var temp = "11/30/2020";
        endDate = new Date(temp);
        break;
      case PeriodType.December:
        var temp = "12/31/2020";
        endDate = new Date(temp);
        break;
      default:
        break;
    }
    return endDate;
  }

  createConditionString(){
    
  }
}
