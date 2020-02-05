using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Account:BaseModel
    {
        public Guid UserID { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string StaffCode { get; set; }
        public string StaffName { get; set; }
        public int RoleType { get; set; } 
        public Guid? ShopID { get; set; }
    }
}
