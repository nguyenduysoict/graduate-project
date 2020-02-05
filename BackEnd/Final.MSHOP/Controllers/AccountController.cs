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
    public class AccountController : ApiController
    {
        // GET: api/Unit
        public ServerResponse Get()
        {
            var res = new ServerResponse();
            using (AccountBL AccountBL = new AccountBL())
            {
                try
                {
                    res.Data = AccountBL.GetAccounts();
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
            using (AccountBL AccountBL = new AccountBL())
            {
                try
                {
                    res.Data = AccountBL.GetAccount(id);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // POST: api/Unit
        [Route("api/account/login")]
        public ServerResponse Login([FromBody]Account Account)
        {
            var res = new ServerResponse();
            using (AccountBL AccountBL = new AccountBL())
            {
                try
                {
                    res.Data = AccountBL.Login(Account);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }


        [Route("api/account/logout")]
        public ServerResponse Logout([FromBody]Account Account)
        {
            var res = new ServerResponse();
            using (AccountBL AccountBL = new AccountBL())
            {
                try
                {
                    res.Data = AccountBL.CheckOutForStaff(Account);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }     



        public ServerResponse Post([FromBody]Account Account)
        {
            var res = new ServerResponse();
            using (AccountBL AccountBL = new AccountBL())
            {
                try
                {
                    res.Data = AccountBL.SaveAccount(Account);
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        [Route("api/Account/no")]
        public ServerResponse GetAccountNo()
        {
            var res = new ServerResponse();
            using (AccountBL AccountBL = new AccountBL())
            {
                try
                {
                    res.Data = AccountBL.GetAccountNo();
                }
                catch (Exception ex)
                {
                    res.Success = false;
                }
            }
            return res;
        }

        // PUT: api/Unit/5
        //public ServerResponse Put([FromBody]Account Account)
        //{
        //    var res = new ServerResponse();
        //    using (AccountBL AccountBL = new AccountBL())
        //    {
        //        try
        //        {
        //            res.Data = AccountBL.UpdateAccount(Account);
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
            using (AccountBL AccountBL = new AccountBL())
            {
                try
                {
                    res.Data = AccountBL.DeleteAccount(id);
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
