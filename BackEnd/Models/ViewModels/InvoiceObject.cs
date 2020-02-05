using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.ViewModels
{
    public class InvoiceObject : BaseModel
    {
        public Invoice Invoice { get; set; }
        public List<InvoiceDetail> InvoiceDetails { get; set; }
    }
}
