using Common.Enum;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class StoreBL : BaseBL
    {
        public StoreBL(){
            tableName = "Store";
        }
        public IEnumerable<Store> GetStores()
        {
            var result = this.GetAllData<Store>();
            return result;
        }

        public Store GetStore(string id)
        {
            var result = this.GetByID<Store>("StoreID", id);
            return result;
        }

        public object SaveStore(Store Store)
        {
            var result = InsertEntity<Store>(Store);
            return result;
        }

        public Store UpdateStore(Store Store)
        {
            var result = this.UpdateEntity<Store>(Store);
            return result;
        }

        public int DeleteStore(string Id)
        {
            var result = Delete("StoreID", Id);
            return result;
        }

    }
}
