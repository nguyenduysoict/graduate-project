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
    public class InwardController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (InwardBL InwardBL = new InwardBL())
            {
                try
                {
                    res.Data = InwardBL.GetInwards();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Inward/no")]
        public ServerResponse GetInwardNo()
        {
            var res = new ServerResponse();
            using (InwardBL InwardBL = new InwardBL())
            {
                try
                {
                    res.Data = InwardBL.GetInwardNo();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Inward/getDetail/{InwardID}")]
        public ServerResponse GetInwardDetail(string InwardID)
        {
            var res = new ServerResponse();
            using (InwardBL InwardBL = new InwardBL())
            {
                try
                {
                    res.Data = InwardBL.GetInwardDetails(InwardID);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        // POST: api/Unit
        [Route("api/Inward/getByCondition")]
        public ServerResponse Post([FromBody]QueryCondition queryCondition)
        {
            var res = new ServerResponse();
            using (InwardBL inwardBL = new InwardBL())
            {
                try
                {
                    res.Data = inwardBL.GetDataByQueryCondition(queryCondition);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Inward/getByShop/{shopID}")]
        public ServerResponse GetDataByShop(string shopID)
        {
            var res = new ServerResponse();
            using (InwardBL InwardBL = new InwardBL())
            {
                try
                {
                    res.Data = InwardBL.GetDataByShop(shopID);
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
            using (InwardBL InwardBL = new InwardBL())
            {
                try
                {
                    res.Data = InwardBL.GetInward(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]InwardObject InwardObj)
        {
            var res = new ServerResponse();
            using (InwardBL InwardBL = new InwardBL())
            {
                try
                {
                    res.Data = InwardBL.SaveInward(InwardObj);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        //PUT: api/Unit/5
        public ServerResponse Put([FromBody]Inward Inward)
        {
            var res = new ServerResponse();
            using (InwardBL InwardBL = new InwardBL())
            {
                try
                {
                    res.Data = InwardBL.UpdateInward(Inward);
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
            using (InwardBL InwardBL = new InwardBL())
            {
                try
                {
                    res.Data = InwardBL.DeleteInward(id);
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
