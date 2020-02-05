using Common.Enum;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class ShopBL : BaseBL
    {
        public ShopBL(){
            tableName = "Shop";
        }
        public IEnumerable<Shop> GetShops()
        {
            var result = this.GetAllData<Shop>();
            return result;
        }

        public Shop GetShop(string id)
        {
            var result = this.GetByID<Shop>("ShopID", id);
            return result;
        }

        public object SaveShop(Shop Shop)
        {
            var result = new object();
            if (Shop.FormMode == FormMode.Insert)
            {
                result = InsertEntity<Shop>(Shop);
            }
            else if (Shop.FormMode == FormMode.Update)
            {
                result = this.UpdateEntity<Shop>(Shop);
            }
            return result;
        }

        public Shop UpdateShop(Shop Shop)
        {
            var result = this.UpdateEntity<Shop>(Shop);
            return result;
        }

        public int DeleteShop(string Id)
        {
            var result = Delete("ShopID", Id);
            return result;
        }

    }
}
