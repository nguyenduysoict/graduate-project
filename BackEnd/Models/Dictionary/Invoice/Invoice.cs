using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Invoice : BaseModel
    {
        public Guid InvoiceID { get; set; }
        public Guid ShopID { get; set; }
        public string InvoiceNo { get; set; }
        public string StaffCode { get; set; }
        public string StaffName { get; set; }
        public string CustomerPhone { get; set; }
        public bool IsCash { get; set; }
        public string Description { get; set; }
        public string CustomerAddress { get; set; }
        public string CustomerName { get; set; }
        public DateTime InvoiceDate { get; set; }
        public decimal TotalMoney { get; set; }
    }
}
