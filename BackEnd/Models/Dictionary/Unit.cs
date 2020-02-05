using Common.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Unit : BaseModel
    {
        public Guid UnitID { get; set; }
        public string UnitName { get; set; }
        public bool Status { get; set; }
        public string Description { get; set; }
    }
}
