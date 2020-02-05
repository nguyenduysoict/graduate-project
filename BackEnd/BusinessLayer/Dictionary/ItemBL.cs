using Common;
using Common.Enum;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class ItemBL : BaseBL
    {
        public ItemBL(){
            tableName = "Item";
        }
        public IEnumerable<Item> GetItems()
        {
            var result = this.GetAllData<Item>();
            return result;
        }

        public Item GetItem(string id)
        {
            var result = this.GetByID<Item>("ItemID", id);
            if (result != null && !string.IsNullOrEmpty(result.ItemImage))
            {
                var imageHandler = new ImageHandler();
                var imageData = imageHandler.GetImageDataFromPath(result.ItemImage);
                result.ItemImage = imageData;
            }
            return result;
        }

        public object SaveItem(Item Item)
        {
            var result = new object();
            if (Item.FormMode == FormMode.Insert)
            {
                result = InsertEntity<Item>(Item);
            }
            else if (Item.FormMode == FormMode.Update)
            {
                result = this.UpdateEntity<Item>(Item);
            }
            return result;
        }

        public Item UpdateItem(Item Item)
        {
            var result = this.UpdateEntity<Item>(Item);
            return result;
        }

        public int DeleteItem(string Id)
        {
            var result = Delete("ItemID", Id);
            return result;
        }

    }
}
