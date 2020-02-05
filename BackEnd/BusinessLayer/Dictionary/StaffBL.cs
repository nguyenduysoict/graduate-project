using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Enum;
using Common;

namespace BusinessLayer
{
    public class StaffBL : BaseBL
    {
        public StaffBL(){
            tableName = "Staff";
        }
        public IEnumerable<Staff> GetStaffs()
        {
            var result = this.GetAllData<Staff>();
            return result;
        }

        public string GetStaffNo()
        {
            var result = this.GetNewestNo<Staff>();
            return result;
        }

        public IEnumerable<Staff> GetSalaryByStaffCode(string staffCode)
        {
            var fieldName = "StaffCode";
            var fieldValue = "'"+staffCode+"'";
            var result = this.GetDataByField<Staff>(fieldName, fieldValue);
            return result;
        }

        public Staff GetStaff(string id)
        {
            var result = this.GetByID<Staff>("StaffID", id);
            if (result != null && !string.IsNullOrEmpty(result.Avatar) )
            {
                var imageHandler = new ImageHandler();
                var imageData = imageHandler.GetImageDataFromPath(result.Avatar);
                result.Avatar = imageData;
            }
            return result;
        }

        public object SaveStaff(Staff Staff)
        {
            var result = new object();
            if(Staff.FormMode == FormMode.Insert)
            {
                result = InsertEntity<Staff>(Staff);
            } else if(Staff.FormMode == FormMode.Update)
            {
                result = this.UpdateEntity<Staff>(Staff);
            }
            return result;
        }

        public Staff UpdateStaff(Staff Staff)
        {
            var result = this.UpdateEntity<Staff>(Staff);
            return result;
        }

        public int DeleteStaff(string Id)
        {
            var result = Delete("StaffID", Id);
            return result;
        }

    }
}
