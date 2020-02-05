using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class IncomeByItemValue
    {
        public string SKUCode { get; set; }
        public string ItemName { get; set; }
        public string ItemGroupName { get; set; }
        public decimal TotalMoney { get; set; }
    }
}
