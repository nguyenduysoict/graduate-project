using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Setting : BaseModel
    {
        public Guid SettingID { get; set; }
        public DateTime MorningShiftStart { get; set; }
        public DateTime MorningShiftEnd { get; set; }
        public DateTime AfternoonShiftStart { get; set; }
        public DateTime AfternoonShiftEnd { get; set; }
        public DateTime NightShiftStart { get; set; }
        public DateTime NightShiftEnd { get; set; }
        public int WorkingDayStart { get; set; }
        public int WorkingDayEnd { get; set; }
        public int WorkingDayAmount { get; set; }
        public int SalaryDay { get; set; }
        public int SumUpDay { get; set; }
    }
}
