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
    public class ReceiptController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (ReceiptBL ReceiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = ReceiptBL.GetReceipts();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Receipt/getByCondition")]
        public ServerResponse Post([FromBody]QueryCondition queryCondition)
        {
            var res = new ServerResponse();
            using (ReceiptBL receiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = receiptBL.GetDataByQueryCondition(queryCondition);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        [Route("api/Receipt/getByShop/{shopID}")]
        public ServerResponse GetDataByShop(string shopID)
        {
            var res = new ServerResponse();
            using (ReceiptBL ReceiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = ReceiptBL.GetDataByShop(shopID);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Receipt/no")]
        public ServerResponse GetReceiptNo()
        {
            var res = new ServerResponse();
            using (ReceiptBL ReceiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = ReceiptBL.GetReceiptNo();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Receipt/getDetail/{ReceiptID}")]
        public ServerResponse GetReceiptDetail(string ReceiptID)
        {
            var res = new ServerResponse();
            using (ReceiptBL ReceiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = ReceiptBL.GetReceiptDetails(ReceiptID);
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
            using (ReceiptBL ReceiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = ReceiptBL.GetReceipt(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]ReceiptObject ReceiptObj)
        {
            var res = new ServerResponse();
            using (ReceiptBL ReceiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = ReceiptBL.SaveReceipt(ReceiptObj);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        //PUT: api/Unit/5
        public ServerResponse Put([FromBody]Receipt Receipt)
        {
            var res = new ServerResponse();
            using (ReceiptBL ReceiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = ReceiptBL.UpdateReceipt(Receipt);
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
            using (ReceiptBL ReceiptBL = new ReceiptBL())
            {
                try
                {
                    res.Data = ReceiptBL.DeleteReceipt(id);
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
