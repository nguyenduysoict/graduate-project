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
    public class StaffController : ApiController
    {
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (StaffBL StaffBL = new StaffBL())
            {
                try
                {
                    res.Data = StaffBL.GetStaffs();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        public ServerResponse Get(string id)
        {
            var res = new ServerResponse();
            using (StaffBL StaffBL = new StaffBL())
            {
                try
                {
                    res.Data = StaffBL.GetStaff(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Staff/salary/{staffCode}")]
        [HttpGet]
        public ServerResponse GetSalary(string staffCode)
        {
            var res = new ServerResponse();
            using (StaffBL StaffBL = new StaffBL())
            {
                try
                {
                    res.Data = StaffBL.GetSalaryByStaffCode(staffCode);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        public ServerResponse Post([FromBody]Staff Staff)
        {
            var res = new ServerResponse();
            using (StaffBL StaffBL = new StaffBL())
            {
                try
                {
                    res.Data = StaffBL.SaveStaff(Staff);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Staff/no")]
        public ServerResponse GetStaffNo()
        {
            var res = new ServerResponse();
            using (StaffBL StaffBL = new StaffBL())
            {
                try
                {
                    res.Data = StaffBL.GetStaffNo();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // PUT: api/Unit/5
        //public ServerResponse Put([FromBody]Staff Staff)
        //{
        //    var res = new ServerResponse();
        //    using (StaffBL StaffBL = new StaffBL())
        //    {
        //        try
        //        {
        //            res.Data = StaffBL.UpdateStaff(Staff);
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
            using (StaffBL StaffBL = new StaffBL())
            {
                try
                {
                    res.Data = StaffBL.DeleteStaff(id);
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
