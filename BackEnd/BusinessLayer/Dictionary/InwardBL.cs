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
    public class InwardBL : BaseBL
    {
        StoreBL storeBL;
        public InwardBL(){
            tableName = "Inward";
            storeBL = new StoreBL();
        }
        public IEnumerable<Inward> GetInwards()
        {
            var result = this.GetAllData<Inward>();
            return result;
        }

        public IEnumerable<Inward> GetDataByQueryCondition(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_Inward_GetByCondition";
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
                    var item = new Inward();
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

        public string GetInwardNo()
        {
            var result = this.GetNewestNo<Inward>();
            return result;
        }

        public IEnumerable<InwardDetail> GetInwardDetails(string InwardID)
        {
            tableName = "InwardDetail";
            var fieldName = "InwardID";
            var fieldValue = "'" + InwardID + "'";
            var result = this.GetDataByField<InwardDetail>(fieldName, fieldValue);
            return result;
        }

        public Inward GetInward(string id)
        {
            var result = this.GetByID<Inward>("InwardID", id);
            return result;
        }

        public IEnumerable<Inward> GetDataByShop(string shopID)
        {
            var result = this.GetDataByShop<Inward>(shopID);
            return result;
        }

        public object SaveInward(InwardObject InwardObj)
        {
            var result = new object();
            if (InwardObj.FormMode == FormMode.Insert || InwardObj.FormMode == FormMode.Duplicate)
            {
                //insert thằng master lấy id
                var masterID = InsertEntity<Inward>(InwardObj.Inward);
                InwardObj.Inward.InwardID = masterID;
                //gán id cho thằng detail, thực hiện insert
                for (int i = 0; i < InwardObj.InwardDetails.Count; i++)
                {
                    InwardObj.InwardDetails[i].InwardID = masterID;
                    var detailID = InsertEntity<InwardDetail>(InwardObj.InwardDetails[i]);
                    InwardObj.InwardDetails[i].InwardDetailID = detailID;

                    var store = new Store();
                    store.ShopID = InwardObj.Inward.ShopID;
                    store.ChangeDate = InwardObj.Inward.InwardDate;
                    store.SKUCode = InwardObj.InwardDetails[i].SKUCode;
                    store.ItemName = InwardObj.InwardDetails[i].ItemName;
                    store.Unit = InwardObj.InwardDetails[i].Unit;
                    store.UnitPrice = InwardObj.InwardDetails[i].UnitPrice;
                    store.ItemGroupName = InwardObj.InwardDetails[i].ItemGroupName;
                    store.InAmount = InwardObj.InwardDetails[i].Amount;
                    store.OutAmount = 0;
                    store.UnitPrice = InwardObj.InwardDetails[i].UnitPrice;
                    storeBL.InsertEntity<Store>(store);
                }
                result = masterID;

            } else if(InwardObj.FormMode == FormMode.Update)
            {
                try
                {
                    //update thằng master
                    UpdateEntity<Inward>(InwardObj.Inward);
                    //gán id cho thằng detail, thực hiện insert
                    var masterID = InwardObj.Inward.InwardID;
                    DeleteInwardDetail(masterID.ToString());
                    for (int i = 0; i < InwardObj.InwardDetails.Count; i++)
                    {
                        InwardObj.InwardDetails[i].InwardID = masterID;
                        var detailID = InsertEntity<InwardDetail>(InwardObj.InwardDetails[i]);
                        InwardObj.InwardDetails[i].InwardDetailID = detailID;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return result;
        }

        public Inward UpdateInward(Inward Inward)
        {
            var result = this.UpdateEntity<Inward>(Inward);
            return result;
        }

        public int DeleteInward(string Id)
        {
            var result = Delete("InwardID", Id);
            return result;
        }


        public int DeleteInwardDetail(string masterID)
        {
            var result = -1;
            var storedName = "Proc_DeleteItem";
            masterID = "'" + masterID + "'";
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SqlCommand;
                sqlCommand.CommandText = storedName;
                sqlCommand.Parameters.AddWithValue("@TableName", "InwardDetail");
                sqlCommand.Parameters.AddWithValue("@PrimaryKey", "InwardID");
                sqlCommand.Parameters.AddWithValue("@ID", masterID);
                result = sqlCommand.ExecuteNonQuery();
            }
            return result;
        }

    }

   
}
