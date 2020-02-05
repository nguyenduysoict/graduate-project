using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ReceiptDetail:BaseModel
    {
        public Guid ReceiptDetailID { get; set; }
        public Guid ReceiptID { get; set; }
        public Guid ShopID { get; set; }
        public string ReceiptCategory { get; set; }
        public string Description { get; set; }
        public decimal Money { get; set; }
    }
}
