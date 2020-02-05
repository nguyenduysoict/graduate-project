using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class ItemGroupBL : BaseBL
    {
        public ItemGroupBL(){
            tableName = "ItemGroup";
        }
        public IEnumerable<ItemGroup> GetItemGroups()
        {
            var result = this.GetAllData<ItemGroup>();
            return result;
        }

        public ItemGroup GetItemGroup(string id)
        {
            var result = this.GetByID<ItemGroup>("ItemGroupID", id);
            return result;
        }

        public Guid SaveItemGroup(ItemGroup itemGroup)
        {
            var result = InsertEntity<ItemGroup>(itemGroup);
            return result;
        }

        public ItemGroup UpdateItemGroup(ItemGroup itemGroup)
        {
            var result = this.UpdateEntity<ItemGroup>(itemGroup);
            return result;
        }

        public int DeleteItemGroup(string Id)
        {
            var result = Delete("ItemGroupID", Id);
            return result;
        }

    }
}
