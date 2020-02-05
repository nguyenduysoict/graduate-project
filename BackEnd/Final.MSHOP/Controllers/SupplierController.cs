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
    public class SupplierController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (SupplierBL SupplierBL = new SupplierBL())
            {
                try
                {
                    res.Data = SupplierBL.GetSuppliers();
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
            using (SupplierBL SupplierBL = new SupplierBL())
            {
                try
                {
                    res.Data = SupplierBL.GetSupplier(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]Supplier Supplier)
        {
            var res = new ServerResponse();
            using (SupplierBL SupplierBL = new SupplierBL())
            {
                try
                {
                    res.Data = SupplierBL.SaveSupplier(Supplier);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // PUT: api/Unit/5
        public ServerResponse Put([FromBody]Supplier Supplier)
        {
            var res = new ServerResponse();
            using (SupplierBL SupplierBL = new SupplierBL())
            {
                try
                {
                    res.Data = SupplierBL.UpdateSupplier(Supplier);
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
            using (SupplierBL SupplierBL = new SupplierBL())
            {
                try
                {
                    res.Data = SupplierBL.DeleteSupplier(id);
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
