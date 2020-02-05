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
    public class ItemController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (ItemBL itemBL = new ItemBL())
            {
                try
                {
                    res.Data = itemBL.GetItems();
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
            using (ItemBL itemBL = new ItemBL())
            {
                try
                {
                    res.Data = itemBL.GetItem(id);
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
        public ServerResponse Post([FromBody]Item item)
        {
            var res = new ServerResponse();
            using (ItemBL itemBL = new ItemBL())
            {
                try
                {
                    res.Data = itemBL.SaveItem(item);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // PUT: api/Unit/5
        public ServerResponse Put([FromBody]Item itemGroup)
        {
            var res = new ServerResponse();
            using (ItemBL itemBL = new ItemBL())
            {
                try
                {
                    res.Data = itemBL.UpdateItem(itemGroup);
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
            using (ItemBL itemBL = new ItemBL())
            {
                try
                {
                    res.Data = itemBL.DeleteItem(id);
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
