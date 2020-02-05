using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.ViewModels
{
    public class InwardObject : BaseModel
    {
        public Inward Inward { get; set; }
        public List<InwardDetail> InwardDetails { get; set; }
    }
}
