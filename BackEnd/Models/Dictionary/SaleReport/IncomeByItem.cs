using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class IncomeByItem
    {
        public string SKUCode { get; set; }
        public string ItemName { get; set; }
        public string Color { get; set; }
        public string Size { get; set; }
        public string Unit { get; set; }
        public int Amount { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal TotalMoney { get; set; }
    }
}
