using BusinessLayer;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Final.MSHOP.Controllers
{
    public class ShopController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (ShopBL ShopBL = new ShopBL())
            {
                try
                {
                    res.Data = ShopBL.GetShops();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // GET: api/Unit/5
        public ServerResponse Get(string id)
        {
            var res = new ServerResponse();
            using (ShopBL ShopBL = new ShopBL())
            {
                try
                {
                    res.Data = ShopBL.GetShop(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]Shop Shop)
        {
            var res = new ServerResponse();
            using (ShopBL ShopBL = new ShopBL())
            {
                try
                {
                    res.Data = ShopBL.SaveShop(Shop);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // PUT: api/Unit/5
        public ServerResponse Put([FromBody]Shop Shop)
        {
            var res = new ServerResponse();
            using (ShopBL ShopBL = new ShopBL())
            {
                try
                {
                    res.Data = ShopBL.UpdateShop(Shop);
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
            using (ShopBL ShopBL = new ShopBL())
            {
                try
                {
                    res.Data = ShopBL.DeleteShop(id);
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
