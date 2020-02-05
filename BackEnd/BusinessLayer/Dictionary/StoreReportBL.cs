using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.ViewModels;
using DatabaseAccess;
using System.Data.SqlClient;
using System.Collections;
using Common;

namespace BusinessLayer
{
    public class StoreReportBL : BaseBL
    {
        private Converter converter = new Converter();
         
        public StoreReportBL(){
        }

        public StoreReportData GetDataByQueryCondition(QueryCondition queryCondition)
        {
            var storeReportData = new StoreReportData();
            var preData = new List<StoreReport>();
            var currentData = new List<StoreReport>();
            preData = GetPreAmount(queryCondition).ToList();
            currentData = GetCurrentAmount(queryCondition).ToList();
            storeReportData.PreStoreAmount = preData;
            storeReportData.CurrentStoreAmount = currentData;
            return storeReportData;
        }


        public IEnumerable<StoreReport> GetPreAmount(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_StoreReport_GetPreItemAmount";
            var parameter = new Hashtable();
            if(queryCondition.ShopID == null)
            {
                parameter.Add("ShopID", DBNull.Value);
            }
            else
            {
                parameter.Add("ShopID", queryCondition.ShopID);
            }
            parameter.Add("StartDate", queryCondition.StartDate.ToLocalTime());
            using (DataAccess dataAccess = new DataAccess())
            {
                SqlDataReader dataReader = dataAccess.ExecuteReader(storedProcedure, parameter);

                while (dataReader.Read())
                {
                    var item = new StoreReport();
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

        public IEnumerable<StoreReport> GetCurrentAmount(QueryCondition queryCondition)
        {

            var storedProcedure = "Proc_StoreReport_GetCurrentItemAmount";
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
                    var item = new StoreReport();
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


        public void Temp()
        {
            //for (int i = 0; i < preData.Count(); i++)
            //{
            //    var temp = new StoreReportData();
            //    temp.SKUCode = preData.ElementAt(i).SKUCode;
            //    temp.ItemName = preData.ElementAt(i).ItemName;
            //    temp.Unit = preData.ElementAt(i).Unit;
            //    temp.UnitPrice = preData.ElementAt(i).UnitPrice;
            //    temp.ItemGroupName = preData.ElementAt(i).ItemGroupName;
            //    temp.PreAmount = preData.ElementAt(i).Amount;

            //    var data = currentData.Where(item => item.SKUCode == preData.ElementAt(i).SKUCode);
            //    if (data.Count() > 0)
            //    {
            //        for (int j = 0; j < data.Count(); j++)
            //        {
            //            if (data.ElementAt(j).IsIn)
            //            {
            //                temp.CurrentInAmount = data.ElementAt(j).Amount;
            //            }
            //            else
            //            {
            //                temp.CurrentOutAmount = data.ElementAt(j).Amount;
            //            }
            //        }
            //    }

            //    currentData = currentData.Where(val => val.SKUCode != preData.ElementAt(i).SKUCode).ToArray();
            //    storeReportData.Add(temp);
            //}

            //if (currentData.Count() > 0)
            //{
            //    for (int i = 0; i < currentData.Count(); i++)
            //    {
            //        var index = storeReportData.FindIndex(item => item.SKUCode == currentData.ElementAt(i).SKUCode);
            //        if (index >= 0)
            //        {
            //            if(storeReportData.ElementAt(index).CurrentInAmount != 0)
            //            {
            //                storeReportData.ElementAt(index).CurrentOutAmount = currentData.ElementAt(i).Amount;
            //            } else if(storeReportData.ElementAt(index).CurrentOutAmount != 0)
            //            {
            //                storeReportData.ElementAt(index).CurrentInAmount = currentData.ElementAt(i).Amount;
            //            }

            //        } else
            //        {
            //            var temp = new StoreReportData();
            //            temp.SKUCode = currentData.ElementAt(i).SKUCode;
            //            temp.ItemName = currentData.ElementAt(i).ItemName;
            //            temp.Unit = currentData.ElementAt(i).Unit;
            //            temp.UnitPrice = currentData.ElementAt(i).UnitPrice;
            //            temp.ItemGroupName = currentData.ElementAt(i).ItemGroupName;
            //            temp.PreAmount = 0;
            //            if (currentData.ElementAt(i).IsIn)
            //            {
            //                temp.CurrentInAmount = currentData.ElementAt(i).Amount;
            //            }
            //            else
            //            {
            //                temp.CurrentOutAmount = currentData.ElementAt(i).Amount;
            //            }
            //            storeReportData.Add(temp);
            //        }
            //    }
            //}
        }


    }
}
