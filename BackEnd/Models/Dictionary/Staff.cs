using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Staff: BaseModel
    {
        public Guid StaffID { get; set; }
        public string StaffCode { get; set; }
        public string StaffName { get; set; }
        public Guid ShopID { get; set; }
        public string Password { get; set; }
        public DateTime? Birthday { get; set; }
        public string Gender { get; set; }
        public int RoleType { get; set; }
        public string IdentityNumber { get; set; }
        public DateTime? DateOfIssued { get; set; }
        public string PlaceOfIssued { get; set; }
        public string Avatar { get; set; }
        public string TimeWorkingStatus { get; set; }
        public string MobilePhone { get; set; }
        public string HomePhone { get; set; }
        public string Email { get; set; }
        public string RegularAddress { get; set; }
        public string RegularNation { get; set; }
        public string RegularProvince { get; set; }
        public string RegularDistrict { get; set; }
        public string RegularTown { get; set; }
        public string RecentAddress { get; set; }
        public string RecentNation { get; set; }
        public string RecentProvince { get; set; }
        public string RecentDistrict { get; set; }
        public string RecentTown { get; set; }
        public string EmerContactName { get; set; }
        public string EmerContactRelation { get; set; }
        public string EmerContactMobilePhone { get; set; }
        public string EmerContactHomePhone { get; set; }
        public string EmerContactEmail { get; set; }
        public string EmerContactAddress { get; set; }
        public string Salary { get; set; }
        public string WokingStatus { get; set; }
        public DateTime? TryingWorkFrom { get; set; }
        public DateTime? TryingWorkTo { get; set; }
        public DateTime? OffcialWorkFrom { get; set; }
        public DateTime? OffcialWorkTo { get; set; }

    }
}
