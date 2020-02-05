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
    public class SettingController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (SettingBL SettingBL = new SettingBL())
            {
                try
                {
                    res.Data = SettingBL.GetSettings();
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
            using (SettingBL SettingBL = new SettingBL())
            {
                try
                {
                    res.Data = SettingBL.GetSetting(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]Setting Setting)
        {
            var res = new ServerResponse();
            using (SettingBL SettingBL = new SettingBL())
            {
                try
                {
                    res.Data = SettingBL.SaveSetting(Setting);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        // PUT: api/Unit/5
        //public ServerResponse Put([FromBody]Setting Setting)
        //{
        //    var res = new ServerResponse();
        //    using (SettingBL SettingBL = new SettingBL())
        //    {
        //        try
        //        {
        //            res.Data = SettingBL.UpdateSetting(Setting);
        //        }

        //        catch (Exception ex)
        //        {
        //            res.Success = false;
        //        }
        //    }
        //    return res;
        //}

        // DELETE: api/Unit/5
        public ServerResponse Delete(string id)
        {
            var res = new ServerResponse();
            using (SettingBL SettingBL = new SettingBL())
            {
                try
                {
                    res.Data = SettingBL.DeleteSetting(id);
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
