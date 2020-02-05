using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class IncomeByGroupItem
    {
        public string ItemGroupCode { get; set; }
        public string ItemGroupName { get; set; }
        public decimal TotalMoney { get; set; }
    }
}
