using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Receipt : BaseModel
    {
        public Guid ReceiptID { get; set; }
        public Guid ShopID { get; set; }
        public string ReceiptNo { get; set; }
        public DateTime? ReceiptDate { get; set; }
        public int ReceiptType { get; set; }
        public string StaffName { get; set; }
        public string StaffCode { get; set; }
        public string AccountObjectPhone { get; set; }
        public string AccountObjectName { get; set; }
        public string Address { get; set; }
        public string ReceiptReason { get; set; }
        public decimal TotalMoney { get; set; }
    }
}
