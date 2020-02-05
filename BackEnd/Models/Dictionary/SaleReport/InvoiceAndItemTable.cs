using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class InvoiceAndItemTable
    {
        public DateTime InvoiceDate { get; set; }
        public string InvoiceNo { get; set; }
        public string SKUCode { get; set; }
        public string ItemName { get; set; }
        public string Unit { get; set; }
        public int Amount { get; set; }
        public decimal UnitPrice { get; set; }
        public string StaffName { get; set; }
        public decimal TotalMoney { get; set; }
        public string CustomerName { get; set; }
        public string CustomerPhone { get; set; }
    }
}
