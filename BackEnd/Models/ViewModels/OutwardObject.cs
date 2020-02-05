using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.ViewModels
{
    public class OutwardObject : BaseModel
    {
        public Outward Outward { get; set; }
        public List<OutwardDetail> OutwardDetails { get; set; }
    }
}
