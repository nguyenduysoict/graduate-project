using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class Filter
    {
        public string FieldName { get; set; }
        public string FilterType { get; set; }
        public string DataType { get; set; }
        public string Value { get; set; }
        public string OrderBy { get; set; }

        /// <summary>
        /// Hàm thực hiện build chuỗi câu điều kiện Where
        /// </summary>
        /// <param name="filters">List các trường Filter</param>
        /// <returns>chuỗi where cho câu truy vấn dữ liệu</returns>
        /// Created by NMDuy 30/8/2019
        public static string createConditionString(List<Filter> filters)
        {
            //string where = string.Empty;
            StringBuilder where = new StringBuilder();
            StringBuilder orderby = new StringBuilder();
            foreach (var item in filters)
            {
                switch (item.DataType)
                {
                    case "text":
                        where.Append(createConditionStringForTextType(item));
                        break;
                    case "date":
                        if (item.Value == "")
                        {
                            where.Append("");
                        }
                        else
                        {
                            where.AppendFormat(" AND {0} {1} '{2}'", item.FieldName, item.FilterType, item.Value);
                        }
                        break;

                    case "number":
                        if (item.Value == "")
                        {
                            where.Append("");
                        }
                        else
                        {
                            if (item.FieldName == "RefTypeID" && item.Value == "0")
                            {
                                where.Append("");
                            }
                            else
                            {
                                where.AppendFormat(" AND {0} {1} {2}", item.FieldName, item.FilterType, item.Value);
                            }
                        }
                        break;
                }

                if (item.OrderBy != "")
                {
                    if (orderby.Length == 0)
                    {
                        orderby.AppendFormat(" ORDER BY {0} {1}", item.FieldName, item.OrderBy);
                    }
                    else
                    {
                        orderby.AppendFormat(" , {0} {1}", item.FieldName, item.OrderBy);

                    }
                }
            }
            where.Append(orderby.ToString());
            return where.ToString();
        }
        /// <summary>
        /// Hàm thực hiện build chuỗi câu điều kiện Where - sử dụng cho kiểu dữ liệu của input là string
        /// </summary>
        /// <param name="filters">List các trường Filter</param>
        /// <returns>chuỗi where cho câu truy vấn dữ liệu</returns>
        /// Created by NMDuy 30/8/2019
        private static string createConditionStringForTextType(Filter filter)
        {
            string where = string.Empty;
            if (filter.Value != "")
            {
                if (filter.Value.Contains("'"))
                {
                    filter.Value.Replace("'", "''");
                }
                switch (filter.FilterType)
                {
                    case "*":
                        where = String.Format(" AND {0} LIKE N'%{1}%'", filter.FieldName, filter.Value);
                        break;
                    case "=":
                        where = String.Format(" AND {0} = N'{1}'", filter.FieldName, filter.Value);
                        break;
                    case "+":
                        where = String.Format(" AND {0} LIKE N'{1}%' ", filter.FieldName, filter.Value);
                        break;
                    case "-":
                        where = String.Format(" AND {0} LIKE N'%{1}'", filter.FieldName, filter.Value);
                        break;
                    case "!":
                        where = String.Format(" AND {0} NOT LIKE N'%{1}%'", filter.FieldName, filter.Value);
                        break;
                }
            }
            return where;
        }
    }
}

