using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class SaleByDay
    {
        public DateTime InvoiceDate { get; set; }
        public bool IsCash { get; set; }
        public decimal TotalMoney { get; set; }
    }
}
