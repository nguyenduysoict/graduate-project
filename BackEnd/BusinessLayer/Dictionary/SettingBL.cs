using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Enum;
using Common;

namespace BusinessLayer
{
    public class SettingBL : BaseBL
    {
        public SettingBL(){
            tableName = "Setting";
        }
        public IEnumerable<Setting> GetSettings()
        {
            var result = this.GetAllData<Setting>();
            return result;
        }


        public Setting GetSetting(string id)
        {
            var result = this.GetByID<Setting>("SettingID", id);
            return result;
        }

        public object SaveSetting(Setting Setting)
        {
            var result = new object();
            //Setting.MorningShiftStart = Setting.MorningShiftStart.ToLocalTime();
            //Setting.MorningShiftEnd = Setting.MorningShiftEnd.ToLocalTime();
            //Setting.AfternoonShiftStart = Setting.AfternoonShiftStart.ToLocalTime();
            //Setting.AfternoonShiftEnd = Setting.AfternoonShiftEnd.ToLocalTime();
            //Setting.NightShiftStart = Setting.NightShiftStart.ToLocalTime();
            //Setting.NightShiftEnd = Setting.NightShiftEnd.ToLocalTime();
            if(Setting.FormMode == FormMode.Insert)                             
            {
                result = InsertEntity<Setting>(Setting);
            } else if(Setting.FormMode == FormMode.Update)
            {
                result = this.UpdateEntity<Setting>(Setting);
            }
            return result;
        }

        public Setting UpdateSetting(Setting Setting)
        {
            var result = this.UpdateEntity<Setting>(Setting);
            return result;
        }

        public int DeleteSetting(string Id)
        {
            var result = Delete("SettingID", Id);
            return result;
        }

    }
}
