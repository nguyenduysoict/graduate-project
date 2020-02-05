using BusinessLayer;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;
using System.Diagnostics;

namespace Final.MSHOP.Controllers
{
    public class CustomerController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (CustomerBL CustomerBL = new CustomerBL())
            {
                try
                {
                    res.Data = CustomerBL.GetCustomers();
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
            using (CustomerBL CustomerBL = new CustomerBL())
            {
                try
                {
                    res.Data = CustomerBL.GetCustomer(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        [HttpPost]
        [Route("image")]
        public async Task<HttpResponseMessage> PostFormData()
        {
            // Check if the request contains multipart/form-data.
            if (!Request.Content.IsMimeMultipartContent())
            {
                throw new HttpResponseException(HttpStatusCode.UnsupportedMediaType);
            }

            string root = HttpContext.Current.Server.MapPath("~/App_Data");
            var provider = new MultipartFormDataStreamProvider(root);

            try
            {
                // Read the form data.
                await Request.Content.ReadAsMultipartAsync(provider);

                // This illustrates how to get the file names.
                foreach (MultipartFileData file in provider.FileData)
                {
                    Trace.WriteLine(file.Headers.ContentDisposition.FileName);
                    Trace.WriteLine("Server file path: " + file.LocalFileName);
                }
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (System.Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, e);
            }
        }



        // POST: api/Unit
        [HttpPost]
        public ServerResponse Post([FromBody]Customer Customer)
        {
            var res = new ServerResponse();
            using (CustomerBL CustomerBL = new CustomerBL())
            {
                try
                {
                    res.Data = CustomerBL.SaveCustomer(Customer);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // PUT: api/Unit/5
        public ServerResponse Put([FromBody]Customer CustomerGroup)
        {
            var res = new ServerResponse();
            using (CustomerBL CustomerBL = new CustomerBL())
            {
                try
                {
                    res.Data = CustomerBL.UpdateCustomer(CustomerGroup);
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
            using (CustomerBL CustomerBL = new CustomerBL())
            {
                try
                {
                    res.Data = CustomerBL.DeleteCustomer(id);
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
