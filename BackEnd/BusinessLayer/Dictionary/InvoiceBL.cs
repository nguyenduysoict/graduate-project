using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Enum;
using Models.ViewModels;
using System.Collections;
using DatabaseAccess;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class InvoiceBL : BaseBL
    {
        StoreBL storeBL;
        public InvoiceBL(){
            tableName = "Invoice";
            storeBL = new StoreBL();
        }
        public IEnumerable<Invoice> GetInvoices()
        {
            var result = this.GetAllData<Invoice>();
            return result;
        }

        public IEnumerable<Invoice> GetDataByShop(string shopID)
        {
            var result = this.GetDataByShop<Invoice>(shopID);
            return result;
        }

        public string GetInvoiceNo()
        {
            var result = this.GetNewestNo<Invoice>();
            return result;
        }

        public IEnumerable<Invoice> GetDataByQueryCondition(QueryCondition queryCondition)
        {
            var storedProcedure = "Proc_Invoice_GetByCondition";
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
                    var item = new Invoice();
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

        public IEnumerable<InvoiceDetail> GetInvoiceDetails(string invoiceID)
        {
            tableName = "InvoiceDetail";
            var fieldName = "InvoiceID";
            var fieldValue = "'" + invoiceID + "'";
            var result = this.GetDataByField<InvoiceDetail>(fieldName, fieldValue);
            return result;
        }

        public Invoice GetInvoice(string id)
        {
            var result = this.GetByID<Invoice>("InvoiceID", id);
            return result;
        }

        

        public InvoiceObject SaveInvoice(InvoiceObject InvoiceObj)
        {
            if(InvoiceObj.FormMode == FormMode.Insert)
            {
                //insert thằng master lấy id
                var masterID = InsertEntity<Invoice>(InvoiceObj.Invoice);
                InvoiceObj.Invoice.InvoiceID = masterID;
                //gán id cho thằng detail, thực hiện insert
                for (int i = 0; i < InvoiceObj.InvoiceDetails.Count; i++)
                {
                    InvoiceObj.InvoiceDetails[i].InvoiceID = masterID;
                    InsertEntity<InvoiceDetail>(InvoiceObj.InvoiceDetails[i]);

                    var store = new Store();

                    store.ShopID = InvoiceObj.Invoice.ShopID;
                    store.ChangeDate = InvoiceObj.Invoice.InvoiceDate;
                    store.SKUCode = InvoiceObj.InvoiceDetails[i].SKUCode;
                    store.ItemName = InvoiceObj.InvoiceDetails[i].ItemName;
                    store.Unit = InvoiceObj.InvoiceDetails[i].Unit;
                    store.UnitPrice = InvoiceObj.InvoiceDetails[i].UnitPrice;
                    store.ItemGroupName = InvoiceObj.InvoiceDetails[i].ItemGroupName;
                    store.OutAmount = InvoiceObj.InvoiceDetails[i].Amount;
                    store.InAmount = 0;
                    store.UnitPrice = InvoiceObj.InvoiceDetails[i].UnitPrice;
                    storeBL.SaveStore(store);
                }

            } else if(InvoiceObj.FormMode == FormMode.Update)
            {
                //update thằng master lấy id
                InvoiceObj.Invoice = UpdateEntity<Invoice>(InvoiceObj.Invoice);
                //update cho từng thằng detail
                for (int i = 0; i < InvoiceObj.InvoiceDetails.Count; i++)
                {
                    InvoiceObj.InvoiceDetails[i] = UpdateEntity<InvoiceDetail>(InvoiceObj.InvoiceDetails[i]);
                }
            }
            return InvoiceObj;
        }

        public Invoice UpdateInvoice(Invoice Invoice)
        {
            var result = this.UpdateEntity<Invoice>(Invoice);
            return result;
        }

        public int DeleteInvoice(string Id)
        {
            var result = Delete("InvoiceID", Id);
            return result;
        }

    }
}
