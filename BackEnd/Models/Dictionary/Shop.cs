using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Shop:BaseModel
    {
        public Guid ShopID { get; set; }
        public string ShopCode { get; set; }
        public string ShopName { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
    }
}
