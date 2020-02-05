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
    public class StoreReportController : ApiController
    {
        // POST: api/Unit
        [Route("api/StoreReport/getByCondition")]
        public ServerResponse Post([FromBody]QueryCondition queryCondition)
        {
            var res = new ServerResponse();
            using (StoreReportBL StoreReportBL = new StoreReportBL())
            {
                try
                {
                    res.Data = StoreReportBL.GetDataByQueryCondition(queryCondition);
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
