using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class Converter
    {

        public string ConvertDateAndMonth(int value)
        {
            var result = "";
            if(value < 10)
            {
                result = "0" + value;
            } else
            {
                result = value.ToString();
            }
            return result;
        }
    }
}
