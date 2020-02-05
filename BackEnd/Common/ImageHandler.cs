using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class ImageHandler
    {
        public string GetImageDataFromPath(string filePath)
        {
            Byte[] bytes = File.ReadAllBytes(filePath);
            string file = Convert.ToBase64String(bytes);
            file = "data:image/jpeg;base64," + file;
            return file;
        }
    }
}
