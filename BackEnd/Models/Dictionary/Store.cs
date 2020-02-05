using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Store: BaseModel
    {
        public Guid StoreID { get; set; }
        public Guid ShopID { get; set; }
        public DateTime ChangeDate { get; set; }
        public string SKUCode { get; set; }
        public string ItemName { get; set; }
        public string Unit { get; set; }
        public decimal UnitPrice { get; set; }
        public int InAmount { get; set; }
        public string ItemGroupName { get; set; }
        public int OutAmount { get; set; }
    }
}
