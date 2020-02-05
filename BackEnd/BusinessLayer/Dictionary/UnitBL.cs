using Common.Enum;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class UnitBL : BaseBL
    {
        public UnitBL(){
            tableName = "Unit";
        }
        public IEnumerable<Unit> GetUnits()
        {
            var result = this.GetAllData<Unit>();
            return result;
        }

        public Unit GetUnit(string id)
        {
            var result = this.GetByID<Unit>("UnitID",id);
            return result;
        }

        public object SaveUnit(Unit unit)
        {

            var result = new object();
            if (unit.FormMode == FormMode.Insert)
            {
                result = InsertEntity<Unit>(unit);
            }
            else if (unit.FormMode == FormMode.Update)
            {
                result = this.UpdateEntity<Unit>(unit);
            }
            return result;
        }

        public int DeleteUnit(string Id)
        {
            var result = Delete("UnitID", Id);
            return result;
        }

    }
}
