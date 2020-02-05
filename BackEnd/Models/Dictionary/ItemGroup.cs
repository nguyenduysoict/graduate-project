using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ItemGroup : BaseModel
    {
        public Guid ItemGroupID { get; set; }
        public string ItemGroupCode { get; set; }
        public string ItemGroupName { get; set; }
        public string Description { get; set; }
        public bool Status { get; set; }
    }
}
