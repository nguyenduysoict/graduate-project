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
    public class WorkdayController : ApiController
    {

        // GET: api/Unit
        //[Route("api/Workday/getDetail/{UserID}")]
        //public ServerResponse Get(string UserID)
        //{
        //    var res = new ServerResponse();
        //    using (WorkdayBL WorkdayBL = new WorkdayBL())
        //    {
        //        try
        //        {
        //            res.Data = WorkdayBL.GetWorkdaysByUser(UserID);
        //        }
        //        catch (Exception ex)
        //        {
        //            res.Success = false;
        //        }
        //    }
        //    return res;
        //}

        public ServerResponse Post([FromBody]QueryData queryData)
        {
            var res = new ServerResponse();
            using (WorkdayBL WorkdayBL = new WorkdayBL())
            {
                try
                {
                    res.Data = WorkdayBL.GetWorkdaysByUser(queryData);
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
