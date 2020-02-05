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
    public class OverviewController : ApiController
    {
        // POST: api/Unit

        [Route("api/Overview/getByCondition")]
        public ServerResponse Post([FromBody]QueryCondition queryCondition)
        {
            var res = new ServerResponse();
            using (OverviewBL OverviewBL = new OverviewBL())
            {
                try
                {
                    res.Data = OverviewBL.GetDataByQueryCondition(queryCondition);
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
