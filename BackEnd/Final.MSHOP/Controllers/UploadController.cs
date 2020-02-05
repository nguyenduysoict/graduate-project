using Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace Final.MSHOP.Controllers
{
    public class UploadController : ApiController
    {
        // GET: api/Upload
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Upload/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Upload
        [AllowAnonymous]
        public ServerResponse Post()
        {
            Dictionary<string, object> dict = new Dictionary<string, object>();
            var serverResponse = new ServerResponse();
            try
            {
                var httpRequest = HttpContext.Current.Request;

                foreach (string file in httpRequest.Files)
                {
                    var postedFile = httpRequest.Files[file];
                    if (postedFile != null && postedFile.ContentLength > 0)
                    {

                        int MaxContentLength = 1024 * 1024 * 3; //Size = 3 MB  

                        IList<string> AllowedFileExtensions = new List<string> { ".jpg", ".gif", ".png" };
                        var ext = postedFile.FileName.Substring(postedFile.FileName.LastIndexOf('.'));
                        var extension = ext.ToLower();
                        if (!AllowedFileExtensions.Contains(extension))
                        {

                            serverResponse.Message = "Vui lòng chọn ảnh có định dạng .jpg,.gif,.png.";
                            serverResponse.Success = false;
                            return serverResponse;
                        }
                        else if (postedFile.ContentLength > MaxContentLength)
                        {
                            serverResponse.Message = "Vui lòng chọn ảnh kích thước < 3MB";
                            serverResponse.Success = false;
                            return serverResponse;
                        }
                        else
                        {
                            var fileName = GenerateNewFileName();
                            var filePath = HttpContext.Current.Server.MapPath("~/Storage/ItemImage/" + fileName + extension);
                            postedFile.SaveAs(filePath);
                            //Byte[] bytes = File.ReadAllBytes(filePath);
                            //var imageData = Convert.ToBase64String(bytes);
                            //serverResponse.Data = "data:image/jpeg;base64," + imageData;
                            serverResponse.Data = filePath;
                            return serverResponse;
                        }
                    }
                }
                return serverResponse;

            }
            catch (Exception ex)
            {
                serverResponse.Success = false;
                return serverResponse;
            }
        }

        // PUT: api/Upload/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Upload/5
        public void Delete(int id)
        {
        }

        private string GenerateNewFileName(string prefix = "IMG")
        {
            return prefix + "_" + DateTime.UtcNow.ToString("yyyy-MMM-dd_HH-mm-ss");
        }
    }
}
