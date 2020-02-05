using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Enum;
using Models.ViewModels;

namespace BusinessLayer
{
    public class ReceiptDetailBL : BaseBL
    {
        public ReceiptDetailBL(){
            tableName = "ReceiptDetail";
        }
        public IEnumerable<ReceiptDetail> GetReceiptDetails()
        {
            var result = this.GetAllData<ReceiptDetail>();
            return result;
        }

        public string GetReceiptDetailNo()
        {
            var result = this.GetNewestNo<ReceiptDetail>();
            return result;
        }

        public IEnumerable<ReceiptDetail> GetReceiptDetailDetails(string ReceiptDetailID)
        {
            tableName = "ReceiptDetailDetail";
            var fieldName = "ReceiptDetailID";
            var fieldValue = "'" + ReceiptDetailID + "'";
            var result = this.GetDataByField<ReceiptDetail>(fieldName, fieldValue);
            return result;
        }

        public ReceiptDetail GetReceiptDetail(string id)
        {
            var result = this.GetByID<ReceiptDetail>("ReceiptDetailID", id);
            return result;
        }

        public IEnumerable<ReceiptDetail> GetDataByShop(string shopID)
        {
            var result = this.GetDataByShop<ReceiptDetail>(shopID);
            return result;
        }

        //public ReceiptDetailObject SaveReceiptDetail(ReceiptDetailObject ReceiptDetailObj)
        //{
        //    if(ReceiptDetailObj.FormMode == FormMode.Insert || ReceiptDetailObj.FormMode == FormMode.Duplicate)
        //    {
        //        //insert thằng master lấy id
        //        var masterID = InsertEntity<ReceiptDetail>(ReceiptDetailObj.ReceiptDetail);
        //        ReceiptDetailObj.ReceiptDetail.ReceiptDetailID = masterID;
        //        //gán id cho thằng detail, thực hiện insert
        //        for (int i = 0; i < ReceiptDetailObj.ReceiptDetailDetails.Count; i++)
        //        {
        //            ReceiptDetailObj.ReceiptDetailDetails[i].ReceiptDetailID = masterID;
        //            var detailID = InsertEntity<ReceiptDetailDetail>(ReceiptDetailObj.ReceiptDetailDetails[i]);
        //            ReceiptDetailObj.ReceiptDetailDetails[i].ReceiptDetailDetailID = detailID;
        //        }

        //    } else if(ReceiptDetailObj.FormMode == FormMode.Update)
        //    {
        //        //update thằng master lấy id
        //        ReceiptDetailObj.ReceiptDetail = UpdateEntity<ReceiptDetail>(ReceiptDetailObj.ReceiptDetail);
        //        //update cho từng thằng detail
        //        for (int i = 0; i < ReceiptDetailObj.ReceiptDetailDetails.Count; i++)
        //        {
        //            ReceiptDetailObj.ReceiptDetailDetails[i] = UpdateEntity<ReceiptDetailDetail>(ReceiptDetailObj.ReceiptDetailDetails[i]);
        //        }
        //    }
        //    return ReceiptDetailObj;
        //}

        public ReceiptDetail UpdateReceiptDetail(ReceiptDetail ReceiptDetail)
        {
            var result = this.UpdateEntity<ReceiptDetail>(ReceiptDetail);
            return result;
        }

        public int DeleteReceiptDetail(string Id)
        {
            var result = Delete("ReceiptDetailID", Id);
            return result;
        }

    }
}
