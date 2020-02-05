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
    public class SaleReportBL : BaseBL
    {
        private Converter converter = new Converter();
         
        public SaleReportBL(){
        }

        public object GetDataByQueryCondition(QueryCondition queryCondition)
        {
            var result = new object();

            if (queryCondition.ReportType == (int)SaleReport.SaleByDay)
            {
                result = GetSaleByDay(queryCondition);
            } else if (queryCondition.ReportType == (int)SaleReport.InvoiceAndItemTable)
            {
                result = GetInvoiceAndItemTable(queryCondition);
            } else if(queryCondition.ReportType == (int)SaleReport.IncomeByItem)
            {
                result = GetIncomeByItem(queryCondition);

            } else if(queryCondition.ReportType == (int)SaleReport.IncomeByGroupItem)
            {
                result = GetIncomeByGroupItem(queryCondition);
            } else if (queryCondition.ReportType == (int)SaleReport.IncomeByStaff)
            {
                result = GetIncomeByStaff(queryCondition);
            }
            return result;
        }


        public IEnumerable<SaleByDay> GetSaleByDay(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_SaleReport_GetSaleByDay";
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
            parameter.Add("EndDate", queryCondition.EndDate.ToLocalTime());

            using (DataAccess dataAccess = new DataAccess())
            {
                SqlDataReader dataReader = dataAccess.ExecuteReader(storedProcedure, parameter);

                while (dataReader.Read())
                {
                    var item = new SaleByDay();
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

        public IEnumerable<IncomeByItem> GetIncomeByItem(QueryCondition queryCondition)
        {

            var storedProcedure = "Proc_SaleReport_GetIncomeByItem";
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
                    var item = new IncomeByItem();
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

        public IEnumerable<IncomeByGroupItem> GetIncomeByGroupItem(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_SaleReport_GetIncomeByItemGroup";
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
                    var item = new IncomeByGroupItem();
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

        public IEnumerable<IncomeByStaff> GetIncomeByStaff(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_SaleReport_GetIncomeByStaff";
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
                    var item = new IncomeByStaff();
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

        public IEnumerable<InvoiceAndItemTable> GetInvoiceAndItemTable(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_SaleReport_GetInvoiceAndItemTable";
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
            parameter.Add("StaffCode", queryCondition.StaffCode);

            using (DataAccess dataAccess = new DataAccess())
            {
                SqlDataReader dataReader = dataAccess.ExecuteReader(storedProcedure, parameter);

                while (dataReader.Read())
                {
                    var item = new InvoiceAndItemTable();
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
