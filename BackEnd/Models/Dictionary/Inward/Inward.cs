using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Inward : BaseModel
    {
        public Guid InwardID { get; set; }
        public string InwardNo { get; set; }
        public DateTime InwardDate { get; set; }
        public Guid ShopID { get; set; }
        public decimal TotalMoney { get; set; }
        public string OutStaffName { get; set; }
        public bool IsFromSupplier { get; set; }
        public string OutStaffCode { get; set; }
        public string InStaffName { get; set; }
        public string InStaffCode { get; set; }
        public string Deliver { get; set; }
        public string Description { get; set; }
    }
}
