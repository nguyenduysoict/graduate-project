using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseAccess
{
    public class DataAccess : IDisposable
    {
        #region properties
        //Đối tượng SqlConnection kết nối dữ liệu
        private SqlConnection sqlConnection;
        //Đối tượng SqlCommand
        private SqlCommand sqlCommand;
        //Đối tượng SqlTransaction
        private SqlTransaction sqlTransaction;

        //Chuỗi kết nối đến cơ sở dữ liệu

        //protected string connectionString = @"Data Source=database\sql2014;Initial Catalog=MISA.MShopKeeper.NMDuy;Integrated Security=True";

        protected string connectionString = @"Data Source=(local)\SQLEXPRESS;Initial Catalog=MShopKeeper;Integrated Security=True";

        public SqlCommand SqlCommand
        {
            get { return sqlCommand; }
        }

        #endregion

        /// <summary>
        /// Khởi tạo đối tượng thực hiện kết nối cơ sở dữ liệu
        /// </summary>
        public DataAccess()
        {
            //Thực hiện việc kết nối đến cơ sở dữ liệu
            sqlConnection = new SqlConnection(connectionString);
            //Khởi tạo SqlCommand
            sqlCommand = sqlConnection.CreateCommand();
            //Mở kết nối 
            sqlConnection.Open();
            //Khai báo kiểu sqlCommand
            sqlCommand.CommandType = CommandType.StoredProcedure;
        }

        /// <summary>
        /// Khởi tạo Transaction
        /// </summary>
        public void Transaction()
        {
            sqlTransaction = sqlConnection.BeginTransaction();
            sqlCommand.Transaction = sqlTransaction;
        }

        /// <summary>
        /// Hoàn thành Transaction
        /// </summary>
        public void Commit()
        {
            sqlTransaction.Commit();
        }

        /// <summary>
        /// Hàm rollback kết quả
        /// </summary>
        public void Rollback()
        {
            sqlTransaction.Rollback();
        }

        /// <summary>
        /// Hàm xóa các tham số trong câu lệnh sqlCommand
        /// </summary>
        public void ClearSqlCommandParams()
        {
            sqlCommand.Parameters.Clear();
        }

        /// <summary>
        /// Thực thi câu lệnh sql với kết quả trả về là số bản ghi bị ảnh hưởng 
        /// </summary>
        /// <param name="sqlCommand"> </param>
        /// <param name="storedProcedureName"></param>
        /// <returns></returns>
        public int ExecuteNonQuery(string storedProcedureName)
        {
            sqlCommand.CommandText = storedProcedureName;
            return sqlCommand.ExecuteNonQuery();
        }

        /// <summary>
        /// Thực thi câu lệnh sql với kết quả trả về là số bản ghi bị ảnh hưởng 
        /// </summary>
        /// <param name="sqlCommand"></param>
        /// <param name="storedProcedureName"></param>
        /// <param name="parameter"></param>
        /// <returns></returns>
        public int ExecuteNonQuery(string storedProcedureName, object parameter)
        {
            sqlCommand.CommandText = storedProcedureName;
            AddParamsToSqlCommand(parameter);
            return sqlCommand.ExecuteNonQuery();
        }

        /// <summary>
        /// Thực thi câu lệnh sql command lấy về dữ liệu là thông tin bản ghi
        /// </summary>
        /// <param name="sqlCommand"> đối tượng sqlcommand  </param>
        /// <param name="storedProcedureName"> tên store procedure </param>
        /// <returns></returns>
        public SqlDataReader ExecuteReader(string storedProcedureName)
        {
            sqlCommand.CommandText = storedProcedureName;
            return sqlCommand.ExecuteReader();
        }


        /// <summary>
        /// Lấy và đọc dữ liệu dựa vào store trả lại người dùng
        /// </summary>
        /// <param name="storedProcedureName"></param>
        /// <param name="parameter"></param>
        /// <returns></returns>
        public SqlDataReader ExecuteReader(string storedProcedureName, object parameter)
        {
            sqlCommand.CommandText = storedProcedureName;
            AddParamsToSqlCommand(parameter);
            return sqlCommand.ExecuteReader();
        }

        /// <summary>
        /// thực thi câu lệnh sql trả về null hoặc dữ liệu đầu tiên
        /// </summary>
        /// <param name="storedProcedureName"> Tên store </param>
        /// <returns></returns>
        public object ExecuteScalar(string storedProcedureName)
        {
            sqlCommand.CommandText = storedProcedureName;
            return sqlCommand.ExecuteScalar();
        }

        /// <summary>
        /// thực thi câu lệnh sql trả về null hoặc dữ liệu đầu tiên
        /// </summary>
        /// <param name="storedProcedureName">Tên store</param>
        /// <param name="parameter">Than số truyền vào</param>
        /// <returns></returns>
        public object ExecuteScalar(string storedProcedureName, object parameter)
        {
            sqlCommand.CommandText = storedProcedureName;
            AddParamsToSqlCommand(parameter);
            return sqlCommand.ExecuteScalar();
        }

        /// <summary>
        /// Gán dữ liệu tham số lên câu sqlcommand
        /// </summary>
        /// <param name="parameter">tham số truyền vào</param>
        private void AddParamsToSqlCommand(object parameter)
        {
            var type = parameter.GetType().Name;

            switch (type)
            {
                case "Hashtable":
                    var hashtable = (Hashtable)parameter;
                    foreach (DictionaryEntry param in hashtable)
                    {
                        sqlCommand.Parameters.AddWithValue("@" + param.Key, param.Value);
                    }
                    break;
                default:
                    var properties = parameter.GetType().GetProperties();
                    foreach (var prop in properties)
                    {
                        if (prop.GetValue(parameter) != null)
                        {
                            sqlCommand.Parameters.AddWithValue("@" + prop.Name, prop.GetValue(parameter));
                        }
                    }
                    break;
            }

        }

        /// <summary>
        /// Set param là các thuộc tính của enitty cho SqlCommand 
        /// </summary>
        /// <returns></returns>
        public SqlCommand SetParamsToSqlCommand<T>(string storeProcedure, T entity)
        {
            sqlCommand.CommandText = storeProcedure;
            SqlCommandBuilder.DeriveParameters(sqlCommand);
            var sqlParameters = sqlCommand.Parameters;

            for (int i = 1; i < sqlParameters.Count; i++)
            {
                var parameterName = sqlParameters[i].ParameterName.Replace("@", string.Empty);
                var property = entity.GetType().GetProperty(parameterName);
                if (property != null)
                {
                    sqlParameters[i].Value = property.GetValue(entity) ?? DBNull.Value;
                }
            }

            return sqlCommand;
        }

        /// <summary>
        /// Đóng kết nối cơ sở dữ liệu khi sử dụng using
        /// </summary>
        public void Dispose()
        {
            sqlConnection.Close();
        }
    }
}
