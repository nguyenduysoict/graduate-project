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
    public class WorkdayBL : BaseBL
    {
        StoreBL storeBL;
        public WorkdayBL(){
            tableName = "WorkDay";
            storeBL = new StoreBL();
        }
        public IEnumerable<WorkDay> GetWorkdays()
        {
            var result = this.GetAllData<WorkDay>();
            return result;
        }

        public IEnumerable<WorkDay> GetWorkdaysByUser(QueryData queryData)
        {
            var storedProcedure = "Proc_WorkDay_GetByUser";
            var parameter = new Hashtable();
            parameter.Add("UserID", queryData.UserID);
            parameter.Add("StartDate", queryData.StartDate.ToLocalTime());
            parameter.Add("EndDate", queryData.EndDate.ToLocalTime());
            using (DataAccess dataAccess = new DataAccess())
            {
                SqlDataReader dataReader = dataAccess.ExecuteReader(storedProcedure, parameter);

                while (dataReader.Read())
                {
                    var item = new WorkDay();
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

        public string GetWorkdayNo()
        {
            var result = this.GetNewestNo<WorkDay>();
            return result;
        }
    }

   
}
