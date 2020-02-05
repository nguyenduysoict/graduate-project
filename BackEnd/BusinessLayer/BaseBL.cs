using DatabaseAccess;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class BaseBL:IDisposable
    {

        public virtual string tableName { get; set; }
        /// <summary>
        /// Lấy tất cả dữ liệu theo bảng trong cơ sở dữ liệu
        /// </summary>
        /// <typeparam name="T"> model truyền vào </typeparam>
        /// <param name="tableName">Tên bảng</param>
        /// <returns></returns>
        public IEnumerable<T> GetAllData<T>()
        {
            var storedProcedure = "[dbo].[Proc_GetAllData]";
            var parameter = new Hashtable();
            parameter.Add("TableName", tableName);
            using (DataAccess dataAccess = new DataAccess())
            {
                SqlDataReader dataReader = dataAccess.ExecuteReader(storedProcedure, parameter);

                while (dataReader.Read())
                {
                    var item = Activator.CreateInstance<T>();
                    for (int i = 0; i < dataReader.FieldCount; i++)
                    {
                        var fieldName = dataReader.GetName(i);
                        var fieldValue = dataReader.GetValue(i);
                        var property = item.GetType().GetProperty(fieldName);
                        if (property != null && fieldValue != DBNull.Value)
                        {
                            property.SetValue(item, fieldValue);
                        }
                    }
                    yield return item;
                }
            }
        }

        public string GetNewestNo<T>()
        {
            var newestNo = "";
            var entityName = typeof(T).Name;
            var procName = "Proc_" + entityName + "_GetNewestNo";
            using (DataAccess dataAccess = new DataAccess())
            {
                try
                {
                    newestNo = (string)dataAccess.ExecuteScalar(procName);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                return newestNo;
            }
        }

        /// <summary>
        /// Lấy bản ghi theo tên trường vào giá trị tương ứng truyền vào 
        /// </summary>
        /// <typeparam name="T">model </typeparam>
        /// <param name="tableName"> tên bảng</param>
        /// <param name="fieldName"> tên trường </param>
        /// <param name="fieldValue">giá trị của trường</param>
        /// <returns></returns>

        public IEnumerable<T> GetDataByField<T>(string fieldName, string fieldValue)
        {
            var storedProcedure = "Proc_GetDataByField";
            var parameter = new Hashtable();
            parameter.Add("TableName", tableName);
            parameter.Add("FieldName", fieldName);
            parameter.Add("FieldValue", fieldValue);
            using (DataAccess dataAccess = new DataAccess())
            {
                SqlDataReader dataReader = dataAccess.ExecuteReader(storedProcedure, parameter);

                while (dataReader.Read())
                {
                    var item = Activator.CreateInstance<T>();
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
        
        /// <summary>
        /// Lấy bản ghi theo tên trường vào giá trị tương ứng truyền vào 
        /// </summary>
        /// <typeparam name="T">model </typeparam>
        /// <param name="tableName"> tên bảng</param>
        /// <param name="fieldName"> tên trường </param>
        /// <param name="fieldValue">giá trị của trường</param>
        /// <returns></returns>

        public IEnumerable<T> GetDataByShop<T>(string ShopID)
        {

            var storedProcedure = "Proc_GetDataByField";
            var parameter = new Hashtable();
            ShopID = "'" + ShopID + "'";
            parameter.Add("TableName", tableName);
            parameter.Add("FieldName", "ShopID");
            parameter.Add("FieldValue", ShopID);
            using (DataAccess dataAccess = new DataAccess())
            {
                SqlDataReader dataReader = dataAccess.ExecuteReader(storedProcedure, parameter);

                while (dataReader.Read())
                {
                    var item = Activator.CreateInstance<T>();
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


        /// <summary>
        /// Lấy giá trị 1 bản ghi
        /// </summary>
        /// <typeparam name="T"> model </typeparam>
        /// <param name="tableName"> Tên bảng </param>
        /// <param name="columnName">Tên cột</param>
        /// <param name="value">Giá trị của cột</param>
        /// <returns></returns>
        public T GetByID<T>(string columnName, string ID)
        {
            var storeName = "Proc_GetByID";
            ID = "'" + ID + "'";
            var entity = Activator.CreateInstance<T>();
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SqlCommand;
                sqlCommand.CommandText = storeName;
                sqlCommand.Parameters.AddWithValue("@TableName", tableName);
                sqlCommand.Parameters.AddWithValue("@PrimaryKey", columnName);
                sqlCommand.Parameters.AddWithValue("@ID", ID);
                SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                while (sqlDataReader.Read())
                {
                    for (int i = 0; i < sqlDataReader.FieldCount; i++)
                    {
                        // Lấy ra tên propertyName dựa vào tên cột của field hiện tại:
                        var propertyName = sqlDataReader.GetName(i);
                        // Lấy ra giá trị của field hiện tại:
                        var propertyValue = sqlDataReader.GetValue(i);
                        // Gán Value cho Property tương ứng:
                        var propertyInfo = entity.GetType().GetProperty(propertyName);
                        if (propertyInfo != null && propertyValue != DBNull.Value)
                        {
                            propertyInfo.SetValue(entity, propertyValue);
                        }
                    }
                }
            }
            return entity;
        }

        /// <summary>
        /// Thêm mới Entity vào cơ sở dữ liệu
        /// </summary>
        /// <typeparam name="T"> Kiểu đối tượng </typeparam>
        /// <param name="storedProcedure"> Tên store trong database </param>
        /// <param name="entity"> Đối tượng </param>
        /// <returns></returns>

        public Guid InsertEntity<T>(T entity)
        {
            var newID = new Guid();
            var entityName = typeof(T).Name;
            var procName = "Proc_" + entityName + "_Insert";
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SetParamsToSqlCommand(procName, entity);
                SqlTransaction sqlTransaction = sqlCommand.Connection.BeginTransaction();
                sqlCommand.Transaction = sqlTransaction;
                try
                {
                    newID = (Guid)sqlCommand.ExecuteScalar();
                    sqlTransaction.Commit();
                }
                catch (Exception ex)
                {
                    sqlTransaction.Rollback();
                    throw ex;
                }
                return newID;
            }
        }

        public T UpdateEntity<T>(T entity)
        {
            var entityName = typeof(T).Name;
            var procName = "Proc_" + entityName + "_Update";
            var updatedEntity = Activator.CreateInstance<T>();
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SetParamsToSqlCommand(procName, entity);
     
                try
                {
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        for (int i = 0; i < sqlDataReader.FieldCount; i++)
                        {
                            // Lấy ra tên propertyName dựa vào tên cột của field hiện tại:
                            var propertyName = sqlDataReader.GetName(i);
                            // Lấy ra giá trị của field hiện tại:
                            var propertyValue = sqlDataReader.GetValue(i);
                            // Gán Value cho Property tương ứng:
                            var propertyInfo = updatedEntity.GetType().GetProperty(propertyName);
                            if (propertyInfo != null && propertyValue != DBNull.Value)
                            {
                                propertyInfo.SetValue(updatedEntity, propertyValue);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                return updatedEntity;
            }
        }

        /// <summary>
        /// Lấy dữ liệu dựa vào tên procedure
        /// </summary>
        /// <typeparam name="T">Kiểu đối tượng</typeparam>
        /// <param name="procedureName">Tên store</param>
        /// <returns></returns>
        public IEnumerable<T> GetDataByProcedure<T>(string procedureName)
        {
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SqlCommand;
                SqlDataReader dataReader = dataAccess.ExecuteReader(procedureName);
                while (dataReader.Read())
                {
                    var item = Activator.CreateInstance<T>();
                    for (int i = 0; i < dataReader.FieldCount; i++)
                    {
                        var fieldName = dataReader.GetName(i);
                        var fieldValue = dataReader.GetValue(i);
                        var property = item.GetType().GetProperty(fieldName);
                        if (property != null && fieldValue != DBNull.Value)
                        {
                            property.SetValue(item, fieldValue);
                        }
                    }
                    yield return item;
                }
            }
        }

        /// <summary>
        /// Xóa bản ghi theo bảng và dữ liệu truyền vào
        /// </summary>
        /// <param name="tableName">Tên bảng</param>
        /// <param name="columnName">Tên trường</param>
        /// <param name="valueList">Giá trị trường</param>
        /// <returns></returns>
        public int DeleteRecords(string columnName, string valueList)
        {
            var result = 0;
            var storedName = "Proc_DeleteMultiRecord";
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SqlCommand;
                sqlCommand.CommandText = storedName;
                sqlCommand.Parameters.AddWithValue("@TableName", tableName);
                sqlCommand.Parameters.AddWithValue("@ColumnName", columnName);
                sqlCommand.Parameters.AddWithValue("@ListID", valueList);
                result = sqlCommand.ExecuteNonQuery();
            }
            return result;
        }

        /// <summary>
        /// Xóa bản ghi theo ID và giá trị khóa truyền vào 
        /// </summary>
        /// <param name="primaryKey"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public int Delete(string primaryKey, string value)
        {
            var result = -1;
            var storedName = "Proc_DeleteItem";
            value = "'" + value + "'";
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SqlCommand;
                sqlCommand.CommandText = storedName;
                sqlCommand.Parameters.AddWithValue("@TableName", tableName);
                sqlCommand.Parameters.AddWithValue("@PrimaryKey", primaryKey);
                sqlCommand.Parameters.AddWithValue("@ID", value);
                result = sqlCommand.ExecuteNonQuery();
            }
            return result;
        }



        public void Dispose()
        {
        }
    }
}
