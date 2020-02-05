using Common.Enum;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class SupplierBL : BaseBL
    {
        public SupplierBL(){
            tableName = "Supplier";
        }
        public IEnumerable<Supplier> GetSuppliers()
        {
            var result = this.GetAllData<Supplier>();
            return result;
        }

        public Supplier GetSupplier(string id)
        {
            var result = this.GetByID<Supplier>("SupplierID", id);
            return result;
        }

        public object SaveSupplier(Supplier Supplier)
        {
            var result = new object();
            if (Supplier.FormMode == FormMode.Insert)
            {
                result = InsertEntity<Supplier>(Supplier);
            }
            else if (Supplier.FormMode == FormMode.Update)
            {
                result = this.UpdateEntity<Supplier>(Supplier);
            }
            return result;
        }

        public Supplier UpdateSupplier(Supplier Supplier)
        {
            var result = this.UpdateEntity<Supplier>(Supplier);
            return result;
        }

        public int DeleteSupplier(string Id)
        {
            var result = Delete("SupplierID", Id);
            return result;
        }

    }
}
