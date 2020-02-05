using BusinessLayer;
using Models;
using Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Final.MSHOP.Controllers
{
    public class InvoiceController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (InvoiceBL InvoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = InvoiceBL.GetInvoices();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        [Route("api/Invoice/getByCondition")]
        public ServerResponse Post([FromBody]QueryCondition queryCondition)
        {
            var res = new ServerResponse();
            using (InvoiceBL invoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = invoiceBL.GetDataByQueryCondition(queryCondition);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }



        [Route("api/Invoice/getByShop/{shopID}")]
        public ServerResponse GetDataByShop(string shopID)
        {
            var res = new ServerResponse();
            using (InvoiceBL InvoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = InvoiceBL.GetDataByShop(shopID);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        [Route("api/Invoice/no")]
        public ServerResponse GetInvoiceNo()
        {
            var res = new ServerResponse();
            using (InvoiceBL InvoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = InvoiceBL.GetInvoiceNo();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Invoice/getDetail/{invoiceID}")]
        public ServerResponse GetInvoiceDetail(string invoiceID)
        {
            var res = new ServerResponse();
            using (InvoiceBL InvoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = InvoiceBL.GetInvoiceDetails(invoiceID);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        // GET: api/Unit/5
        [Route("{id}")]
        public ServerResponse Get(string id)
        {
            var res = new ServerResponse();
            using (InvoiceBL InvoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = InvoiceBL.GetInvoice(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]InvoiceObject InvoiceObj)
        {
            var res = new ServerResponse();
            using (InvoiceBL InvoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = InvoiceBL.SaveInvoice(InvoiceObj);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        //PUT: api/Unit/5
        public ServerResponse Put([FromBody]Invoice Invoice)
        {
            var res = new ServerResponse();
            using (InvoiceBL InvoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = InvoiceBL.UpdateInvoice(Invoice);
                }

                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // DELETE: api/Unit/5
        public ServerResponse Delete(string id)
        {
            var res = new ServerResponse();
            using (InvoiceBL InvoiceBL = new InvoiceBL())
            {
                try
                {
                    res.Data = InvoiceBL.DeleteInvoice(id);
                }

                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }
    }
}
