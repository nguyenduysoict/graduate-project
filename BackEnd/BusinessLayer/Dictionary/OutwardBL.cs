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
    public class OutwardBL : BaseBL
    {
        StoreBL storeBL;
        public OutwardBL(){
            tableName = "Outward";
            storeBL = new StoreBL();
        }
        public IEnumerable<Outward> GetOutwards()
        {
            var result = this.GetAllData<Outward>();
            return result;
        }

        public string GetOutwardNo()
        {
            var result = this.GetNewestNo<Outward>();
            return result;
        }

        public IEnumerable<Outward> GetDataByQueryCondition(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_Outward_GetByCondition";
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
                    var item = new Outward();
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

        public IEnumerable<OutwardDetail> GetOutwardDetails(string OutwardID)
        {
            tableName = "OutwardDetail";
            var fieldName = "OutwardID";
            var fieldValue = "'" + OutwardID + "'";
            var result = this.GetDataByField<OutwardDetail>(fieldName, fieldValue);
            return result;
        }

        public Outward GetOutward(string id)
        {
            var result = this.GetByID<Outward>("OutwardID", id);
            return result;
        }

        public IEnumerable<Outward> GetDataByShop(string shopID)
        {
            var result = this.GetDataByShop<Outward>(shopID);
            return result;
        }

        public object SaveOutward(OutwardObject OutwardObj)
        {
            var result = new object();
            if (OutwardObj.FormMode == FormMode.Insert || OutwardObj.FormMode == FormMode.Duplicate)
            {
                //insert thằng master lấy id
                var masterID = InsertEntity<Outward>(OutwardObj.Outward);
                OutwardObj.Outward.OutwardID = masterID;
                //gán id cho thằng detail, thực hiện insert
                for (int i = 0; i < OutwardObj.OutwardDetails.Count; i++)
                {
                    OutwardObj.OutwardDetails[i].OutwardID = masterID;
                    var detailID = InsertEntity<OutwardDetail>(OutwardObj.OutwardDetails[i]);
                    OutwardObj.OutwardDetails[i].OutwardDetailID = detailID;

                    var store = new Store();
                    store.ShopID = OutwardObj.Outward.ShopID;
                    store.ChangeDate = OutwardObj.Outward.OutwardDate;
                    store.SKUCode = OutwardObj.OutwardDetails[i].SKUCode;
                    store.ItemName = OutwardObj.OutwardDetails[i].ItemName;
                    store.Unit = OutwardObj.OutwardDetails[i].Unit;
                    store.UnitPrice = OutwardObj.OutwardDetails[i].UnitPrice;
                    store.ItemGroupName = OutwardObj.OutwardDetails[i].ItemGroupName;
                    store.OutAmount = OutwardObj.OutwardDetails[i].Amount;
                    store.InAmount = 0;
                    store.UnitPrice = OutwardObj.OutwardDetails[i].UnitPrice;
                    storeBL.InsertEntity<Store>(store);
                }
                result = masterID;

            } else if(OutwardObj.FormMode == FormMode.Update)
            {
                try
                {
                    //update thằng master
                    UpdateEntity<Outward>(OutwardObj.Outward);
                    //gán id cho thằng detail, thực hiện insert
                    var masterID = OutwardObj.Outward.OutwardID;
                    DeleteOutwardDetail(masterID.ToString());
                    for (int i = 0; i < OutwardObj.OutwardDetails.Count; i++)
                    {
                        OutwardObj.OutwardDetails[i].OutwardID = masterID;
                        var detailID = InsertEntity<OutwardDetail>(OutwardObj.OutwardDetails[i]);
                        OutwardObj.OutwardDetails[i].OutwardDetailID = detailID;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return result;
        }

        public Outward UpdateOutward(Outward Outward)
        {
            var result = this.UpdateEntity<Outward>(Outward);
            return result;
        }

        public int DeleteOutward(string Id)
        {
            var result = Delete("OutwardID", Id);
            return result;
        }


        public int DeleteOutwardDetail(string masterID)
        {
            var result = -1;
            var storedName = "Proc_DeleteItem";
            masterID = "'" + masterID + "'";
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SqlCommand;
                sqlCommand.CommandText = storedName;
                sqlCommand.Parameters.AddWithValue("@TableName", "OutwardDetail");
                sqlCommand.Parameters.AddWithValue("@PrimaryKey", "OutwardID");
                sqlCommand.Parameters.AddWithValue("@ID", masterID);
                result = sqlCommand.ExecuteNonQuery();
            }
            return result;
        }

    }

   
}
