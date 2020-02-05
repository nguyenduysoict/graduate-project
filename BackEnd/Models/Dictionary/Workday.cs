using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class WorkDay
    {
        public Guid WorkDayID { get; set; }
        public DateTime CheckIn { get; set; }
        public DateTime CheckOut { get; set; }
        public Guid UserID { get; set; }
        public string StaffCode { get; set; }
    }
}
