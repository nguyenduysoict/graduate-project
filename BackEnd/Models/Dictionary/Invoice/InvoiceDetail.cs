using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class InvoiceDetail:BaseModel
    {
        public Guid InvoiceDetailID { get; set; }
        public Guid ShopID { get; set; }
        public Guid InvoiceID { get; set; }
        public string ItemGroupCode { get; set; }
        public string ItemGroupName { get; set; }
        public string SKUCode { get; set; }
        public string ItemName{ get; set; }
        public string Color { get; set; }
        public string Size { get; set; }
        public string Unit { get; set; }
        public decimal UnitPrice { get; set; }
        public int Amount { get; set; }
        public decimal TotalMoney { get; set; }
    }
}
