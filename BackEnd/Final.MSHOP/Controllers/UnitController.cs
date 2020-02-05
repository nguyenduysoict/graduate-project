using BusinessLayer;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Cors;

namespace Final.MSHOP.Controllers
{
    public class UnitController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using(UnitBL unitBL = new UnitBL())
            {
                try
                {
                    res.Data = unitBL.GetUnits();
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
            using (UnitBL unitBL = new UnitBL())
            {
                try
                {
                    res.Data = unitBL.GetUnit(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]Unit unit)
        {
            var res = new ServerResponse();
            using (UnitBL unitBL = new UnitBL())
            {
                try
                {
                    res.Data = unitBL.SaveUnit(unit);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // PUT: api/Unit/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Unit/5
        public ServerResponse Delete(string id)
        {
            var res = new ServerResponse();
            using(UnitBL unitBL = new UnitBL())
            {
                try
                {
                    res.Data = unitBL.DeleteUnit(id);
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
