using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Enum;
using DatabaseAccess;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class AccountBL : BaseBL
    {
        public AccountBL(){
            tableName = "Account";
        }
        public IEnumerable<Account> GetAccounts()
        {
            var result = this.GetAllData<Account>();
            return result;
        }

        public string GetAccountNo()
        {
            var result = this.GetNewestNo<Account>();
            return result;
        }

        public Account GetAccount(string id)
        {
            var result = this.GetByID<Account>("AccountID", id);
            return result;
        }

        public object SaveAccount(Account Account)
        {
            var result = new object();
            if(Account.FormMode == FormMode.Insert)
            {
                result = InsertEntity<Account>(Account);
            } else if(Account.FormMode == FormMode.Update)
            {
                result = this.UpdateEntity<Account>(Account);
            }
            return result;
        }

        public Account Login(Account account)
        {

            var acc = CheckAccountInfo(account);
            if (!string.IsNullOrEmpty(acc.StaffCode) && !string.IsNullOrEmpty(acc.UserName) && acc.ShopID != null)
            {
                CheckInForStaff(acc);
            }
            return acc;
                
        }


        public Account CheckAccountInfo(Account account)
        {
            var storeName = "Proc_Account_Login";
            var acc = new Account();
            using (DataAccess dataAccess = new DataAccess())
            {
                var sqlCommand = dataAccess.SqlCommand;
                sqlCommand.CommandText = storeName;
                sqlCommand.Parameters.AddWithValue("@UserName", account.UserName);
                sqlCommand.Parameters.AddWithValue("@Password", account.Password);
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
                        var propertyInfo = acc.GetType().GetProperty(propertyName);
                        if(propertyValue == DBNull.Value)
                        {
                            propertyInfo.SetValue(acc, null);
                        } else
                        {
                            propertyInfo.SetValue(acc, propertyValue);
                        }
                        //if (propertyInfo != null && propertyValue != DBNull.Value)
                        //{
                        //}
                    }
                }
            }
            return acc;
        }


        public object CheckInForStaff(Account account)
        {

            if(account.UserName != "admin")
            {
                var storeName = "Proc_Account_CheckIn";
                using (DataAccess dataAccess = new DataAccess())
                {
                    var sqlCommand = dataAccess.SqlCommand;
                    sqlCommand.CommandText = storeName;
                    sqlCommand.Parameters.AddWithValue("@UserID", account.UserID);
                    sqlCommand.Parameters.AddWithValue("@StaffCode", account.StaffCode);
                    sqlCommand.Parameters.AddWithValue("@LoginTime", DateTime.Now);
                    var result = sqlCommand.ExecuteScalar();
                    return result;
                }
            } else
            {
                return 1;
            }
        }

        public object CheckOutForStaff(Account account)
        {
            if(account.UserName != "admin")
            {
                var storeName = "Proc_Account_CheckOut";
                using (DataAccess dataAccess = new DataAccess())
                {
                    var sqlCommand = dataAccess.SqlCommand;
                    sqlCommand.CommandText = storeName;
                    sqlCommand.Parameters.AddWithValue("@UserID", account.UserID);
                    sqlCommand.Parameters.AddWithValue("@StaffCode", account.StaffCode);
                    sqlCommand.Parameters.AddWithValue("@LogoutTime", DateTime.Now);
                    var result = sqlCommand.ExecuteScalar();
                    return result;
                }
            } else
            {
                return 1;
            }
        }


        public Account UpdateAccount(Account Account)
        {
            var result = this.UpdateEntity<Account>(Account);
            return result;
        }

        public int DeleteAccount(string Id)
        {
            var result = Delete("AccountID", Id);
            return result;
        }

    }
}
