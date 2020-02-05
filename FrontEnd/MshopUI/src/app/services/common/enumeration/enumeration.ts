// export enum ReportType {
//     GoodsByDay = 1,
//     ByInvoice = 2,
//     SalesByTime = 3,
//     SalesByGoods = 4,
//     SalesByStaff = 5,
//     DeliveryNote = 6
// }

export enum PeriodType {
  Today = 1,
  Yesterday = 2,
  ThisWeek = 3,
  PreWeek = 4,
  ThisMonth = 5,
  PreMonth = 6,
  ThisYear = 7,
  PreYear = 8,
  January = 9,
  February = 10,
  March = 11,
  April = 12,
  May = 13,
  June = 14,
  July = 15,
  August = 16,
  September = 17,
  October = 18,
  November = 19,
  December = 20
}

export enum StaffType {
  Cashier = 0,
  Salesclerk = 1
}

export enum FormMode {
  Insert = 1,
  Update = 2,
  Duplicate = 3,
  Delete = 4,
  View = 5
}

export enum Status {
  UnActive = 0,
  Active = 1
}

export enum ToastType {
  Error = "error",
  Success = "success"
}

export enum ReceiptType {
  Payment = 0,
  Income = 1
}

export enum RoleType {
  Manager = 0,
  SaleStaff = 1,
  Cashier = 2
}

export enum KeyCode {
  Enter = 13,
  Tab = 9
}

export enum SaleReport {
  SaleByDay = 1,
  InvoiceAndItemTable = 2,
  IncomeByGroupItem = 3,
  IncomeByItem = 4,
  IncomeByStaff = 5
}

// export enum StoreReport {
//   InExportSummary = 1,
//   InExportByShop = 2,
//   InStockByShop = 3
// }

export enum OverviewDataType {
  IncomeData = 1,
  IncomeDataByDay = 2,
  IncomeByItemValue = 3,
  IncomeByItemAmount = 4
}
