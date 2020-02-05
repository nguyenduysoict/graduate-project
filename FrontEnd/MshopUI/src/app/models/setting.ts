import { BaseModel } from './base-model/base-model';

export class Setting extends BaseModel{
    SettingID : string;
         MorningShiftStart : Date;
         MorningShiftEnd  : Date;
         AfternoonShiftStart :Date;
         AfternoonShiftEnd :Date;
         NightShiftStart : Date;
         NightShiftEnd : Date;
         WorkingDayStart : number;
         WorkingDayEnd : number;
         WorkingDayAmount : number;
         SalaryDay : number;
         SumUpDay : number;
}