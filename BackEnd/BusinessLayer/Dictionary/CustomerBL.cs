using Common.Enum;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class CustomerBL : BaseBL
    {
        public CustomerBL(){
            tableName = "Customer";
        }
        public IEnumerable<Customer> GetCustomers()
        {
            var result = this.GetAllData<Customer>();
            return result;
        }

        public Customer GetCustomer(string id)
        {
            var result = this.GetByID<Customer>("CustomerID", id);
            return result;
        }

        public object SaveCustomer(Customer Customer)
        {
            var result = new object();
            if (Customer.FormMode == FormMode.Insert)
            {
                result = InsertEntity<Customer>(Customer);
            }
            else if (Customer.FormMode == FormMode.Update)
            {
                result = this.UpdateEntity<Customer>(Customer);
            }
            return result;
        }

        public Customer UpdateCustomer(Customer Customer)
        {
            var result = this.UpdateEntity<Customer>(Customer);
            return result;
        }

        public int DeleteCustomer(string Id)
        {
            var result = Delete("CustomerID", Id);
            return result;
        }

    }
}
