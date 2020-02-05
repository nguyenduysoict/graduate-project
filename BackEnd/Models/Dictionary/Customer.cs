using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Customer : BaseModel
    {
        public Guid CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string PhoneNumber { get; set; }
        public string CustomerAddress { get; set; }
        public DateTime? Birthday { get; set; }
        public string Email { get; set; }
    }
}
