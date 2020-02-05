using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Outward : BaseModel
    {
        public Guid OutwardID { get; set; }
        public string OutwardNo { get; set; }
        public DateTime OutwardDate { get; set; }
        public Guid ShopID { get; set; }
        public decimal TotalMoney { get; set; }
        public string OutStaffName { get; set; }
        public string OutStaffCode { get; set; }
        public string InStaffName { get; set; }
        public string InStaffCode { get; set; }
        public string Deliver { get; set; }
        public string Description { get; set; }
    }
}
