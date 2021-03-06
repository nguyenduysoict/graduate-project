﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class OutwardDetail:BaseModel
    {
        public Guid OutwardDetailID { get; set; }
        public Guid OutwardID { get; set; }
        public Guid ShopID { get; set; }
        public string SKUCode { get; set; }
        public string ItemName { get; set; }
        public string FromShop { get; set; }
        public string ItemGroupCode { get; set; }
        public int Amount { get; set; }
        public string Unit { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal TotalMoney { get; set; }
        public string ItemGroupName { get; set; }
    }
}
