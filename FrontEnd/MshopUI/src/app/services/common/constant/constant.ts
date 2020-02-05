import { SaleReport, PeriodType } from '../enumeration/enumeration'

export const Colors = [
    {Name: "Xanh dương", Code: "#049523"},
    {Name: "Hồng phấn", Code: "#049523"},
    {Name: "Đỏ đun", Code: "#049523"},
    {Name: "Xanh da trời", Code: "#049523"},
    {Name: "Hồng phớt", Code: "#049523"},
    {Name: "Da cam", Code: "#049523"},
    {Name: "Hoa", Code: "#049523"},
    {Name: "Xanh", Code: "#049523"},
    {Name: "Đỏ", Code: "#049523"},
    {Name: "Tím", Code: "#049523"},
    {Name: "Vàng", Code: "#049523"},
    {Name: "Hồng", Code: "#049523"},
    {Name: "Nâu", Code: "#049523"},
    {Name: "Đen", Code: "#049523"},
    {Name: "Trắng", Code: "#049523"}
]

export const Sizes = [
    {Name: "S"},
    {Name: "M"},
    {Name: "L"},
    {Name: "XL"},
    {Name: "XL"},
    {Name: "XXL"},
    {Name: "35"},
    {Name: "36"},
    {Name: "37"},
    {Name: "38"},
    {Name: "39"},
    {Name: "40"},
    {Name: "41"},
    {Name: "42"},
    {Name: "43"},
    {Name: "44"}
]

export const RoleType = [
    { ID: 1, Name: "Nhân viên bán hàng"},
    { ID: 2, Name: "Nhân viên thu ngân"}
]

export const WorkTimeStatus = [
    "Bán thời gian",
    "Toàn thời gian"
]

export const WorkStatus = [
    "Chính thức",
    "Thử việc"
]

export const Gender = [
    "Nam",
    "Nữ"
]


export const Nations = [
    "Việt Nam",
    "Lào",
    "Campuchia",
    "Thái Lan",
    "Anh",
    "Pháp",
    "Đức"
]

export const Provinces = [
    "Hà Nội",
    "Hà Giang",
    "Lào Cai",
    "Nam Định",
    "Thái Bình",
    "Hải Dương"
]


export const Districts = [
    "Hai Bà Trưng",
    "Hoàng Mai",
    "Nam Từ Liêm",
    "Bắc Từ Liêm",
    "Cầu Giấy",
    "Ba Đình",
    "Thanh Xuân",
    "Tây Hồ",
    "Vị Xuyên",
    "Xín Mần",
    "Su Phì",
    "Bắc Quang"
]


export const Towns = [
    "Việt Lâm",
    "Lê Hồng Phong",
    "Đại Mỗ",
    "Mễ Trì Thượng",
    "Mễ Trì Hạ",
    "Mễ Trì",
    "Đống Mác",
    "Minh Khai",
    "Giải Phóng",
    "Phương Mai"
]

export const InReceiptCategory = [
    "Thanh lý tài sản",
    "Bán phế liệu",
    "Thu khác"
]

export const OutReceiptCategory = [
    "Tiền điện thoại",
    "Tiền Internet",
    "Tiền nước",
    "Mua văn phòng phẩm",
    "Tiếp khách",
    "Chi khác"
]

export const SaleReportType = [
    {Type: SaleReport.SaleByDay, Name: "Tổng hợp bán hàng theo ngày"},
    {Type: SaleReport.InvoiceAndItemTable, Name: "Chi tiết doanh thu theo hóa đơn và mặt hàng"},
    {Type: SaleReport.IncomeByItem, Name: "Doanh thu theo mặt hàng"},
    {Type: SaleReport.IncomeByStaff, Name: "Doanh thu theo nhân viên"}
]

// export const StoreReportType = [
//     {Type: StoreReport.InExportSummary, Name: "Tổng hợp nhập xuất tồn kho"},
//     {Type: StoreReport.InExportByShop, Name: "Tổng hợp nhập xuất tồn kho theo cửa hàng"},
//     {Type: StoreReport.InStockByShop, Name: "Số lượng tồn kho theo cửa hàng"}
// ]

export const PeriodList = [
    { id: PeriodType.Today, periodName: "Hôm nay" },
    { id: PeriodType.Yesterday, periodName: "Hôm qua" },
    { id: PeriodType.ThisWeek, periodName: "Tuần này" },
    { id: PeriodType.PreWeek, periodName: "Tuần trước" },
    { id: PeriodType.ThisMonth, periodName: "Tháng này" },
    { id: PeriodType.PreMonth, periodName: "Tháng trước"},
    { id: PeriodType.ThisYear, periodName: "Năm nay"},
    { id: PeriodType.PreYear, periodName: "Năm ngoái"},
    { id: PeriodType.January, periodName: "Tháng 1"},
    { id: PeriodType.February, periodName: "Tháng 2"},
    { id: PeriodType.March, periodName: "Tháng 3"},
    { id: PeriodType.April, periodName: "Tháng 4"},
    { id: PeriodType.May, periodName: "Tháng 5"},
    { id: PeriodType.June, periodName: "Tháng 6"},
    { id: PeriodType.July, periodName: "Tháng 7"},
    { id: PeriodType.August, periodName: "Tháng 8"},
    { id: PeriodType.September, periodName: "Tháng 9"},
    { id: PeriodType.October, periodName: "Tháng 10"},
    { id: PeriodType.November, periodName: "Tháng 11"},
    { id: PeriodType.December, periodName: "Tháng 12"}
  ]

  export const MonthSelections = [
    { id: PeriodType.ThisMonth, periodName: "Tháng này"},
    { id: PeriodType.PreMonth, periodName: "Tháng trước"},
    { id: PeriodType.January, periodName: "Tháng 1"},
    { id: PeriodType.February, periodName: "Tháng 2"},
    { id: PeriodType.March, periodName: "Tháng 3"},
    { id: PeriodType.April, periodName: "Tháng 4"},
    { id: PeriodType.May, periodName: "Tháng 5"},
    { id: PeriodType.June, periodName: "Tháng 6"},
    { id: PeriodType.July, periodName: "Tháng 7"},
    { id: PeriodType.August, periodName: "Tháng 8"},
    { id: PeriodType.September, periodName: "Tháng 9"},
    { id: PeriodType.October, periodName: "Tháng 10"},
    { id: PeriodType.November, periodName: "Tháng 11"},
    { id: PeriodType.December, periodName: "Tháng 12"}
  ]

export const StatisticsByTime = [
    {id: 1, orderBy: "Giờ trong ngày"},
    {id: 2, orderBy: "Thứ trong tuần"},
    {id: 3, orderBy: "Ngày"},
    {id: 4, orderBy: "Tuần"},
    {id: 5, orderBy: "Tháng"},
    {id: 6, orderBy: "Quý"},
    {id: 7, orderBy: "Năm"},
]

export const StatisticsByItem = [
    {id: 1, orderBy: "Hàng hóa"},
    {id: 2, orderBy: "Nhóm hàng hóa"}
  ]