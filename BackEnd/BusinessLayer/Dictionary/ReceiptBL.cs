using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Enum;
using Models.ViewModels;
using DatabaseAccess;
using System.Collections;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class ReceiptBL : BaseBL
    {
        public ReceiptBL(){
            tableName = "Receipt";
        }
        public IEnumerable<Receipt> GetReceipts()
        {
            var result = this.GetAllData<Receipt>();
            return result;
        }

        public string GetReceiptNo()
        {
            var result = this.GetNewestNo<Receipt>();
            return result;
        }

        public IEnumerable<ReceiptDetail> GetReceiptDetails(string ReceiptID)
        {
            tableName = "ReceiptDetail";
            var fieldName = "ReceiptID";
            var fieldValue = "'" + ReceiptID + "'";
            var result = this.GetDataByField<ReceiptDetail>(fieldName, fieldValue);
            return result;
        }

        public Receipt GetReceipt(string id)
        {
            var result = this.GetByID<Receipt>("ReceiptID", id);
            return result;
        }

        public IEnumerable<Receipt> GetDataByShop(string shopID)
        {
            var result = this.GetDataByShop<Receipt>(shopID);
            return result;
        }

        public object SaveReceipt(ReceiptObject ReceiptObj)
        {
            var result = new object();
            if(ReceiptObj.FormMode == FormMode.Insert || ReceiptObj.FormMode == FormMode.Duplicate)
            {
                try
                {
                    //insert thằng master lấy id
                    var masterID = InsertEntity<Receipt>(ReceiptObj.Receipt);
                    ReceiptObj.Receipt.ReceiptID = masterID;
                    //gán id cho thằng detail, thực hiện insert
                    for (int i = 0; i < ReceiptObj.ReceiptDetails.Count; i++)
                    {
                        ReceiptObj.ReceiptDetails[i].ReceiptID = masterID;
                        var detailID = InsertEntity<ReceiptDetail>(ReceiptObj.ReceiptDetails[i]);
                        ReceiptObj.ReceiptDetails[i].ReceiptDetailID = detailID;
                    }
                    result = masterID;

                }
                catch (Exception ex)
                {

                    throw ex;
                }

            } else if(ReceiptObj.FormMode == FormMode.Update)
            {
                try
                {
                    //update thằng master
                    UpdateEntity<Receipt>(ReceiptObj.Receipt);
                    //gán id cho thằng detail, thực hiện insert
                    var masterID = ReceiptObj.Receipt.ReceiptID;
                    DeleteReceiptDetail(masterID.ToString());
                    for (int i = 0; i < ReceiptObj.ReceiptDetails.Count; i++)
                    {
                        ReceiptObj.ReceiptDetails[i].ReceiptID = masterID;
                        var detailID = InsertEntity<ReceiptDetail>(ReceiptObj.ReceiptDetails[i]);
                        ReceiptObj.ReceiptDetails[i].ReceiptDetailID = detailID;
                    }
                }
                catch (Exception ex)
                {
                    throw ex; 
                }            
            }
            return result;
        }

        public IEnumerable<Receipt> GetDataByQueryCondition(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_Receipt_GetByCondition";
            var parameter = new Hashtable();

            if (queryCondition.ShopID == null)
            {
                parameter.Add("ShopID", DBNull.Value);
            }
            else
            {
                parameter.Add("ShopID", queryCondition.ShopID);
            }
            parameter.Add("StartDate", queryCondition.StartDate.ToLocalTime());
            parameter.Add("EndDate", queryCondition.EndDate.ToLocalTime());

            using (DataAccess dataAccess = new DataAccess())
            {
                SqlDataReader dataReader = dataAccess.ExecuteReader(storedProcedure, parameter);

                while (dataReader.Read())
                {
                    var item = new Receipt();
                    for (int i = 0; i < dataReader.FieldCount; i++)
                    {
                        var fieldTableName = dataReader.GetName(i);
                        var fieldTableValue = dataReader.GetValue(i);
                        var property = item.GetType().GetProperty(fieldTableName);
                        if (property != null && fieldTableValue != DBNull.Value)
                        {
                            property.SetValue(item, fieldTableValue);
                        }

                    }
                    yield return item;
                }
            }
        }

        public Receipt UpdateReceipt(Receipt Receipt)
        {
            var result = this.UpdateEntity<Receipt>(Receipt);
            return result;
        }

        public int DeleteReceipt(string Id)
        {
            var result = Delete("ReceiptID", Id);
            return result;
        }

        public int DeleteReceiptDetail(string masterID)
        {
            var result = -1;
            var storedName = "Proc_DeleteItem";
            masterID = "'" + masterID + "'";
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SqlCommand;
                sqlCommand.CommandText = storedName;
                sqlCommand.Parameters.AddWithValue("@TableName", "ReceiptDetail");
                sqlCommand.Parameters.AddWithValue("@PrimaryKey", "ReceiptID");
                sqlCommand.Parameters.AddWithValue("@ID", masterID);
                result = sqlCommand.ExecuteNonQuery();
            }
            return result;
        }

    }
}
