using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Enum;
using Models.ViewModels;
using DatabaseAccess;
using System.Data.SqlClient;
using System.Collections;
using Common;

namespace BusinessLayer
{
    public class OverviewBL : BaseBL
    {
        private Converter converter = new Converter();
         
        public OverviewBL(){
        }

        public object GetDataByQueryCondition(QueryCondition queryCondition)
        {
            var result = new object();
  
            if (queryCondition.ReportType == (int)OverviewDataType.IncomeData)
            {
                result = GetIncomeData(queryCondition);
            } else if (queryCondition.ReportType == (int)OverviewDataType.IncomeDataByDay)
            {
                result = GetIncomeDataByDay(queryCondition);
            } else if(queryCondition.ReportType == (int)OverviewDataType.IncomeByItemValue)
            {
                result = GetIncomeByItemValue(queryCondition);

            } else if(queryCondition.ReportType == (int)OverviewDataType.IncomeByItemAmount)
            {
                result = GetIncomeByItemAmount(queryCondition);
            } 
            return result;
        }


        public IEnumerable<IncomeData> GetIncomeData(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_Overview_GetIncomeData";
            var parameter = new Hashtable();
            if (queryCondition.ShopID == null)
            {
                parameter.Add("ShopID", DBNull.Value);
            } else
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
                    var item = new IncomeData();
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

        public IEnumerable<IncomeDataByDay> GetIncomeDataByDay(QueryCondition queryCondition)
        {

            var storedProcedure = "Proc_Overview_GetIncomeDataByDay";
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
                    var item = new IncomeDataByDay();
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

        public IEnumerable<IncomeByItemValue> GetIncomeByItemValue(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_Overview_GetIncomeByItemValue";
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
                    var item = new IncomeByItemValue();
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

        public IEnumerable<IncomeByItemAmount> GetIncomeByItemAmount(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_Overview_GetIncomeByItemAmount";
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
                    var item = new IncomeByItemAmount();
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
    }
}
