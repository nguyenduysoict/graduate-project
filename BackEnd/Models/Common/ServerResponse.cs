using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ServerResponse
    {
        public bool Success { get; set; }
        public object Data { get; set; }
        public string Message { get; set; }
        public int Code { get; set; }

        public ServerResponse()
        {
            this.Success = true;
            this.Code = 200;
        }
    }
}
