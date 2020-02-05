using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class IncomeByItemAmount
    {
        public string SKUCode { get; set; }
        public string ItemName { get; set; }
        public string ItemGroupName { get; set; }
        public int Amount { get; set; }
    }
}
