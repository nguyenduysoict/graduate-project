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
    public class ItemGroupController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (ItemGroupBL itemGroupBL = new ItemGroupBL())
            {
                try
                {
                    res.Data = itemGroupBL.GetItemGroups();
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
            using (ItemGroupBL itemGroupBL = new ItemGroupBL())
            {
                try
                {
                    res.Data = itemGroupBL.GetItemGroup(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]ItemGroup itemGroup)
        {
            var res = new ServerResponse();
            using (ItemGroupBL itemGroupBL = new ItemGroupBL())
            {
                try
                {
                    res.Data = itemGroupBL.SaveItemGroup(itemGroup);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // PUT: api/Unit/5
        public ServerResponse Put([FromBody]ItemGroup itemGroup)
        {
            var res = new ServerResponse();
            using (ItemGroupBL itemGroupBL = new ItemGroupBL())
            {
                try
                {
                    res.Data = itemGroupBL.UpdateItemGroup(itemGroup);
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
            using (ItemGroupBL itemGroupBL = new ItemGroupBL())
            {
                try
                {
                    res.Data = itemGroupBL.DeleteItemGroup(id);
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
