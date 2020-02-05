using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class StoreReport
    {
        public string SKUCode { get; set; }
        public string ItemName { get; set; }
        public string Unit { get; set; }
        public string ItemGroupName { get; set; }
        public int InAmount { get; set; }
        public int OutAmount { get; set; }
        public decimal UnitPrice { get; set; }

    }
}
