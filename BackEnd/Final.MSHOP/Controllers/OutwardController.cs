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
    public class OutwardController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (OutwardBL OutwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = OutwardBL.GetOutwards();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        [Route("api/Outward/getByCondition")]
        public ServerResponse Post([FromBody]QueryCondition queryCondition)
        {
            var res = new ServerResponse();
            using (OutwardBL outwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = outwardBL.GetDataByQueryCondition(queryCondition);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        [Route("api/Outward/no")]
        public ServerResponse GetOutwardNo()
        {
            var res = new ServerResponse();
            using (OutwardBL OutwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = OutwardBL.GetOutwardNo();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Outward/getDetail/{OutwardID}")]
        public ServerResponse GetOutwardDetail(string OutwardID)
        {
            var res = new ServerResponse();
            using (OutwardBL OutwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = OutwardBL.GetOutwardDetails(OutwardID);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        [Route("api/Outward/getByShop/{shopID}")]
        public ServerResponse GetDataByShop(string shopID)
        {
            var res = new ServerResponse();
            using (OutwardBL OutwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = OutwardBL.GetDataByShop(shopID);
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
            using (OutwardBL OutwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = OutwardBL.GetOutward(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]OutwardObject OutwardObj)
        {
            var res = new ServerResponse();
            using (OutwardBL OutwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = OutwardBL.SaveOutward(OutwardObj);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        //PUT: api/Unit/5
        public ServerResponse Put([FromBody]Outward Outward)
        {
            var res = new ServerResponse();
            using (OutwardBL OutwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = OutwardBL.UpdateOutward(Outward);
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
            using (OutwardBL OutwardBL = new OutwardBL())
            {
                try
                {
                    res.Data = OutwardBL.DeleteOutward(id);
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
