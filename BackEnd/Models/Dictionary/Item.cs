using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Item : BaseModel
    {
        public Guid ItemID { get; set; }
        public string ItemName { get; set; }
        public string ItemGroupName { get; set; }
        public string ItemGroupCode { get; set; }
        public string SKUCode { get; set; }
        public decimal BuyPrice { get; set; }
        public string ItemColor { get; set; }
        public string ItemSize { get; set; }
        public decimal SellPrice { get; set; }
        public string UnitName { get; set; }
        public string SupplierName { get; set; }
        public string ItemImage { get; set; }
        public string Description { get; set; }
    }
}
