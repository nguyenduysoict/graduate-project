USE [master]
GO
/****** Object:  Database [MShopKeeper]    Script Date: 2/5/2020 7:38:47 PM ******/
CREATE DATABASE [MShopKeeper]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MShopKeeper', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\MShopKeeper.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MShopKeeper_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\MShopKeeper_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MShopKeeper] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MShopKeeper].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MShopKeeper] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MShopKeeper] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MShopKeeper] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MShopKeeper] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MShopKeeper] SET ARITHABORT OFF 
GO
ALTER DATABASE [MShopKeeper] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MShopKeeper] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MShopKeeper] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MShopKeeper] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MShopKeeper] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MShopKeeper] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MShopKeeper] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MShopKeeper] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MShopKeeper] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MShopKeeper] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MShopKeeper] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MShopKeeper] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MShopKeeper] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MShopKeeper] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MShopKeeper] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MShopKeeper] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MShopKeeper] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MShopKeeper] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MShopKeeper] SET  MULTI_USER 
GO
ALTER DATABASE [MShopKeeper] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MShopKeeper] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MShopKeeper] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MShopKeeper] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MShopKeeper] SET DELAYED_DURABILITY = DISABLED 
GO
USE [MShopKeeper]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_user1_UserID]  DEFAULT (newid()),
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[StaffName] [nvarchar](100) NULL,
	[StaffCode] [nvarchar](50) NULL,
	[RoleType] [int] NULL,
	[ShopID] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Account_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Account_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Customer_CustomerID]  DEFAULT (newid()),
	[CustomerName] [nvarchar](100) NOT NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Birthday] [datetime] NULL,
	[CustomerAddress] [nvarchar](255) NULL,
	[Email] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Customer_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_Customer_CreatedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Customer_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_Customer_ModifiedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Invoice_InvoiceID]  DEFAULT (newid()),
	[ShopID] [uniqueidentifier] NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[StaffCode] [nvarchar](50) NULL,
	[StaffName] [nvarchar](50) NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[IsCash] [bit] NULL,
	[Description] [nvarchar](255) NULL,
	[CustomerAddress] [nvarchar](255) NULL,
	[CustomerName] [nvarchar](100) NULL,
	[InvoiceDate] [datetime] NULL,
	[TotalMoney] [money] NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Invoice_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_Invoice_CreatedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Invoice_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_Invoice_ModifiedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceDetail]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetail](
	[InvoiceDetailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_InvoiceDetail_InvoiceDetailID]  DEFAULT (newid()),
	[ShopID] [uniqueidentifier] NULL,
	[InvoiceID] [uniqueidentifier] NULL,
	[ItemGroupCode] [nvarchar](50) NULL,
	[ItemGroupName] [nvarchar](100) NULL,
	[SKUCode] [nvarchar](50) NULL,
	[ItemName] [nvarchar](255) NULL,
	[Color] [nvarchar](50) NULL,
	[Size] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[UnitPrice] [money] NULL,
	[TotalMoney] [money] NULL,
	[Amount] [int] NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_InvoiceDetail_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_InvoiceDetail_CreatedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_InvoiceDetail_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_InvoiceDetail_ModifiedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
 CONSTRAINT [PK_InvoiceDetail] PRIMARY KEY CLUSTERED 
(
	[InvoiceDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inward]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inward](
	[InwardID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Inward_OutwardID]  DEFAULT (newid()),
	[InwardNo] [nvarchar](20) NULL,
	[InwardDate] [datetime] NULL,
	[ShopID] [uniqueidentifier] NULL,
	[TotalMoney] [money] NULL,
	[IsFromSupplier] [bit] NULL,
	[OutStaffName] [nvarchar](100) NULL,
	[OutStaffCode] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[Deliver] [nvarchar](100) NULL,
	[InStaffName] [nvarchar](100) NULL,
	[InStaffCode] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Inward_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_Inward_CreatedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Inward_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_Inward_ModifiedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
 CONSTRAINT [PK_Inward] PRIMARY KEY CLUSTERED 
(
	[InwardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InwardDetail]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InwardDetail](
	[InwardDetailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_InwardDetail_OutwardDetailID]  DEFAULT (newid()),
	[InwardID] [uniqueidentifier] NOT NULL,
	[ShopID] [uniqueidentifier] NULL,
	[SKUCode] [nvarchar](50) NULL,
	[ItemName] [nvarchar](100) NULL,
	[FromShop] [nvarchar](100) NULL,
	[Amount] [int] NULL,
	[Unit] [nvarchar](50) NULL,
	[UnitPrice] [money] NULL,
	[TotalMoney] [money] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_InwardDetail] PRIMARY KEY CLUSTERED 
(
	[InwardDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Item]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Item_ItemID]  DEFAULT (newid()),
	[ItemName] [nvarchar](255) NOT NULL,
	[ItemGroupCode] [nvarchar](50) NULL,
	[ItemGroupName] [nvarchar](255) NULL,
	[SupplierName] [nvarchar](255) NULL,
	[SKUCode] [nvarchar](50) NULL,
	[BuyPrice] [money] NULL,
	[SellPrice] [money] NULL,
	[UnitName] [nvarchar](255) NULL,
	[ItemColor] [nvarchar](50) NULL,
	[ItemSize] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[ItemImage] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemGroup]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemGroup](
	[ItemGroupID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ItemGroup_ItemGroupID]  DEFAULT (newid()),
	[ItemGroupCode] [nvarchar](100) NULL,
	[ItemGroupName] [nvarchar](255) NOT NULL,
	[Status] [bit] NULL,
	[Description] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_ItemGroup] PRIMARY KEY CLUSTERED 
(
	[ItemGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Outward]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Outward](
	[OutwardID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Outward_OutwardID]  DEFAULT (newid()),
	[OutwardNo] [nvarchar](20) NULL,
	[OutwardDate] [datetime] NULL,
	[ShopID] [uniqueidentifier] NULL,
	[TotalMoney] [money] NULL,
	[OutStaffName] [nvarchar](100) NULL,
	[OutStaffCode] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[Deliver] [nvarchar](100) NULL,
	[InStaffName] [nvarchar](100) NULL,
	[InStaffCode] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Outward_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Outward_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_Outward] PRIMARY KEY CLUSTERED 
(
	[OutwardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OutwardDetail]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutwardDetail](
	[OutwardDetailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_OutwardDetail_OutwardDetailID]  DEFAULT (newid()),
	[OutwardID] [uniqueidentifier] NOT NULL,
	[ShopID] [uniqueidentifier] NULL,
	[SKUCode] [nvarchar](50) NULL,
	[ItemName] [nvarchar](100) NULL,
	[FromShop] [nvarchar](100) NULL,
	[Amount] [int] NULL,
	[Unit] [nvarchar](50) NULL,
	[UnitPrice] [money] NULL,
	[TotalMoney] [money] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_OutwardDetail] PRIMARY KEY CLUSTERED 
(
	[OutwardDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipt](
	[ReceiptID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Receipt_ReceiptID]  DEFAULT (newid()),
	[ShopID] [uniqueidentifier] NULL,
	[ReceiptNo] [nvarchar](20) NULL,
	[ReceiptDate] [datetime] NULL,
	[ReceiptType] [int] NULL,
	[StaffName] [nvarchar](100) NULL,
	[StaffCode] [nvarchar](50) NULL,
	[AccountObjectPhone] [nvarchar](50) NULL,
	[AccountObjectName] [nvarchar](100) NULL,
	[Address] [nvarchar](255) NULL,
	[TotalMoney] [money] NULL,
	[ReceiptReason] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Receipt_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_Receipt_CreatedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Receipt_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_Receipt_ModifiedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
 CONSTRAINT [PK_Receipt] PRIMARY KEY CLUSTERED 
(
	[ReceiptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReceiptDetail]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiptDetail](
	[ReceiptDetailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ReceiptDetail_ReceiptDetailID]  DEFAULT (newid()),
	[ShopID] [uniqueidentifier] NULL,
	[ReceiptID] [uniqueidentifier] NULL,
	[ReceiptCategory] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[Money] [money] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_ReceiptDetail] PRIMARY KEY CLUSTERED 
(
	[ReceiptDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Setting]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[SettingID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Setting_SettingID]  DEFAULT (newid()),
	[MorningShiftStart] [datetime] NULL,
	[MorningShiftEnd] [datetime] NULL,
	[AfternoonShiftStart] [datetime] NULL,
	[AfternoonShiftEnd] [datetime] NULL,
	[NightShiftStart] [datetime] NULL,
	[NightShiftEnd] [datetime] NULL,
	[WorkingDayStart] [int] NULL,
	[WorkingDayEnd] [int] NULL,
	[WorkingDayAmount] [int] NULL,
	[SalaryDay] [int] NULL,
	[SumUpDay] [int] NOT NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Setting_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_Setting_CreatedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Setting_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_Setting_ModifiedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
 CONSTRAINT [PK_Setting] PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shop]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shop](
	[ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Shop_ShopID]  DEFAULT (newid()),
	[ShopCode] [nvarchar](20) NULL,
	[ShopName] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[PhoneNumber] [nchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_Shop] PRIMARY KEY CLUSTERED 
(
	[ShopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Staff]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Staff_StaffID]  DEFAULT (newid()),
	[StaffCode] [nvarchar](20) NULL,
	[StaffName] [nvarchar](100) NULL,
	[Password] [nvarchar](50) NULL,
	[Birthday] [date] NULL,
	[Gender] [nvarchar](50) NULL,
	[ShopID] [uniqueidentifier] NULL,
	[RoleType] [int] NULL,
	[IdentityNumber] [nvarchar](25) NULL,
	[DateOfIssued] [date] NULL,
	[PlaceOfIssued] [nvarchar](255) NULL,
	[Avatar] [nvarchar](255) NULL,
	[TimeWorkingStatus] [nvarchar](50) NULL,
	[MobilePhone] [nvarchar](50) NULL,
	[HomePhone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[RegularAddress] [nvarchar](255) NULL,
	[RegularNation] [nvarchar](255) NULL,
	[RegularProvince] [nvarchar](255) NULL,
	[RegularDistrict] [nvarchar](255) NULL,
	[RegularTown] [nvarchar](255) NULL,
	[RecentAddress] [nvarchar](255) NULL,
	[RecentNation] [nvarchar](255) NULL,
	[RecentProvince] [nvarchar](255) NULL,
	[RecentDistrict] [nvarchar](255) NULL,
	[RecentTown] [nvarchar](255) NULL,
	[EmerContactName] [nvarchar](255) NULL,
	[EmerContactRelation] [nvarchar](255) NULL,
	[EmerContactMobilePhone] [nvarchar](255) NULL,
	[EmerContactHomePhone] [nvarchar](255) NULL,
	[EmerContactEmail] [nvarchar](255) NULL,
	[EmerContactAddress] [nvarchar](255) NULL,
	[Salary] [nvarchar](50) NULL,
	[WokingStatus] [nvarchar](50) NULL,
	[TryingWorkFrom] [date] NULL,
	[TryingWorkTo] [date] NULL,
	[OffcialWorkFrom] [date] NULL,
	[OffcialWorkTo] [date] NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Staff_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_Staff_CreatedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Staff_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_Staff_ModifiedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Store]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[StoreID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Store_StoreID]  DEFAULT (newid()),
	[ShopID] [uniqueidentifier] NULL,
	[SKUCode] [nvarchar](20) NULL,
	[ItemName] [nvarchar](255) NULL,
	[UnitPrice] [money] NULL,
	[Unit] [nvarchar](255) NULL,
	[ItemGroupName] [nvarchar](255) NULL,
	[ChangeDate] [datetime] NULL,
	[InAmount] [int] NULL,
	[OutAmount] [int] NULL,
	[TotalMoney] [money] NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Store_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_Store_CreatedBy]  DEFAULT (N'admin'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Store_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_Store_ModifiedBy]  DEFAULT (N'admin'),
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Supplier_SupplierID]  DEFAULT (newid()),
	[SupplierCode] [nvarchar](50) NULL,
	[SupplierName] [nvarchar](100) NULL,
	[SupplierAddress] [nvarchar](255) NULL,
	[BankAccount] [nvarchar](50) NULL,
	[BankName] [nvarchar](50) NULL,
	[BankBranch] [nvarchar](100) NULL,
	[SupplierPhone] [nvarchar](50) NULL,
	[ContactName] [nvarchar](100) NULL,
	[ContactPhone] [nvarchar](50) NULL,
	[ContactEmail] [nvarchar](50) NULL,
	[ContactAddress] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Unit]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[UnitID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Unit_UnitID]  DEFAULT (newid()),
	[UnitName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Status] [bit] NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Unit_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](100) NULL CONSTRAINT [DF_Unit_CreatedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
	[ModifiedDate] [datetime] NULL CONSTRAINT [DF_Unit_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](100) NULL CONSTRAINT [DF_Unit_ModifiedBy]  DEFAULT (N'Nguyễn Mạnh Duy'),
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkDay]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkDay](
	[WorkDayID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WorkDay_WorkDayID]  DEFAULT (newid()),
	[CheckIn] [datetime] NULL,
	[CheckOut] [datetime] NULL,
	[StaffCode] [nvarchar](50) NULL,
	[UserID] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_WorkDay] PRIMARY KEY CLUSTERED 
(
	[WorkDayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[InvoiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetail_Invoice] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoice] ([InvoiceID])
GO
ALTER TABLE [dbo].[InvoiceDetail] CHECK CONSTRAINT [FK_InvoiceDetail_Invoice]
GO
ALTER TABLE [dbo].[OutwardDetail]  WITH CHECK ADD  CONSTRAINT [FK_OutwardDetail_Outward] FOREIGN KEY([OutwardID])
REFERENCES [dbo].[Outward] ([OutwardID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OutwardDetail] CHECK CONSTRAINT [FK_OutwardDetail_Outward]
GO
ALTER TABLE [dbo].[ReceiptDetail]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptDetail_Receipt] FOREIGN KEY([ReceiptID])
REFERENCES [dbo].[Receipt] ([ReceiptID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ReceiptDetail] CHECK CONSTRAINT [FK_ReceiptDetail_Receipt]
GO
ALTER TABLE [dbo].[WorkDay]  WITH CHECK ADD  CONSTRAINT [FK_WorkDay_Account] FOREIGN KEY([UserID])
REFERENCES [dbo].[Account] ([UserID])
GO
ALTER TABLE [dbo].[WorkDay] CHECK CONSTRAINT [FK_WorkDay_Account]
GO
/****** Object:  StoredProcedure [dbo].[Proc_Account_CheckIn]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Account_CheckIn]
	@LoginTime DATETIME,
	@UserID NVARCHAR(50),
	@StaffCode NVARCHAR(50)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM dbo.WorkDay WHERE CAST(CheckIn AS DATE) = CAST(@LoginTime AS DATE) AND UserID = @UserID AND StaffCode = @StaffCode )
	BEGIN
		INSERT dbo.WorkDay
		        ( 
		          UserID ,
				StaffCode,
				CheckIn
		        )
		VALUES  ( 
				@UserID,
				@StaffCode,
				@LoginTime
		        )
	END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Account_CheckOut]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Account_CheckOut]
	@LogoutTime DATETIME,
	@UserID NVARCHAR(50),
	@StaffCode NVARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.WorkDay WHERE CAST(CheckIn AS DATE) = CAST(@LogoutTime AS DATE) AND UserID = @UserID AND StaffCode = @StaffCode )
	BEGIN
		UPDATE dbo.WorkDay
		SET
        CheckOut = @LogoutTime
		WHERE UserID = @UserID AND StaffCode = @StaffCode AND CAST(CheckIn AS DATE) = CAST(@LogoutTime AS DATE)
    END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Account_Login]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Account_Login]
	@UserName NVARCHAR(50),
	@Password NVARCHAR(50)
AS
BEGIN
	SELECT TOP 1 * FROM dbo.Account WHERE Username  = @UserName AND Password = @Password
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Customer_Insert]
	@CustomerName NVARCHAR(255),
	          @PhoneNumber NVARCHAR(100),
	          @CustomerAddress NVARCHAR(255),
	          @Email NVARCHAR(100),
			  @Birthday DATETIME
AS
BEGIN
	INSERT dbo.Customer
	        ( 
	          CustomerName ,
	          PhoneNumber ,
	          CustomerAddress ,
	          Email,
			  Birthday
	        )
			OUTPUT Inserted.CustomerID
	VALUES  ( 
	          @CustomerName , -- CustomerName - nvarchar(100)
	          @PhoneNumber , -- PhoneNumber - nvarchar(50)
	          @CustomerAddress , -- CustomerStreet - nvarchar(255)
	          @Email, -- Email - nvarchar(100)
			  @Birthday
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Customer_Update]
@CustomerID UNIQUEIDENTIFIER,
	@CustomerName NVARCHAR(255),
	          @PhoneNumber NVARCHAR(100),
	          @CustomerAddress NVARCHAR(255),
	          @Email NVARCHAR(100),
			  @Birthday DATETIME
AS
BEGIN
	UPDATE dbo.Customer SET
    	CustomerName = @CustomerName ,
	          PhoneNumber = @PhoneNumber ,
	          CustomerAddress =@CustomerAddress ,
	           Email = @Email,
			   Birthday = @Birthday
			   WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_DeleteItem]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_DeleteItem]
			@TableName NVARCHAR(255),
	         @PrimaryKey NVARCHAR(255),
	          @ID NVARCHAR(255)
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX);
	SET @sql = 'DELETE FROM ' + @TableName + ' WHERE '+ @PrimaryKey + ' = ' + @ID;
	EXECUTE sp_executesql @sql;
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_GetAllData]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetAllData]
	@TableName NVARCHAR(100)
AS
BEGIN
	
	DECLARE @Sql NVARCHAR(MAX)
    SET @Sql = 'SELECT * FROM ' + @TableName +' ORDER BY CreatedDate DESC';
	EXECUTE sp_executesql @sql
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_GetByID]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_GetByID]
	@TableName NVARCHAR(100),
	@PrimaryKey NVARCHAR(100),
	@ID NVARCHAR(100)
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX);
	SET @sql = 'select top 1 * FROM ' + @TableName + ' WHERE '+ @PrimaryKey + ' = ' + @ID;
	EXECUTE sp_executesql @sql;
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_GetDataByField]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_GetDataByField]
	@TableName NVARCHAR(100),
	@FieldName NVARCHAR(100),	
	@FieldValue NVARCHAR(255)
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX)
	SET @sql = 'SELECT * FROM ' + @TableName + ' WHERE ' + @FieldName + ' = ' + @FieldValue + ' ORDER BY CreatedDate DESC';
	EXECUTE sp_executesql @sql
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_GetDataByQueryCondition]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_GetDataByQueryCondition]
	@TableName NVARCHAR(100),
	@ShopID NVARCHAR(100),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	DECLARE @Sql NVARCHAR(MAX)
    SET @Sql = 'SELECT * FROM ' + @TableName +' where ShopID = '+@ShopID+' 
	and CAST(CreatedDate AS DATE) BETWEEN CAST('+@StartDate+' AS DATE) AND CAST('+@EndDate+' AS DATE)) ORDER BY CreatedDate DESC';
	EXECUTE sp_executesql @sql
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Invoice_GetByCondition]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Invoice_GetByCondition]
	@ShopID UNIQUEIDENTIFIER,
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL
	BEGIN
		SELECT * FROM dbo.Invoice WHERE ShopID = @ShopID AND CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) ORDER BY CreatedDate DESC
	END
    ELSE
    BEGIN
		SELECT * FROM dbo.Invoice WHERE CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) ORDER BY CreatedDate DESC
    END
    

END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Invoice_GetNewestNo]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Invoice_GetNewestNo]
AS
BEGIN
	DECLARE @InvoiceNo NVARCHAR(8)
	IF (SELECT COUNT(dbo.Invoice.InvoiceNo) FROM dbo.Invoice WHERE dbo.Invoice.InvoiceNo LIKE 'HD%') = 0
		BEGIN
			SET @InvoiceNo = 'HD000001'
		END
	ELSE
		BEGIN
			SELECT @InvoiceNo = MAX(RIGHT(dbo.Invoice.InvoiceNo, 6)) FROM dbo.Invoice WHERE dbo.Invoice.InvoiceNo LIKE 'HD%'
			SELECT @InvoiceNo = CASE
					WHEN @InvoiceNo >= 99999 THEN 'HD' + CONVERT(CHAR, CONVERT(INT, @InvoiceNo) + 1)
					WHEN @InvoiceNo >= 9999 and @InvoiceNo < 99999 THEN 'HD0' + CONVERT(CHAR, CONVERT(INT, @InvoiceNo) + 1)
					WHEN @InvoiceNo >= 999 and @InvoiceNo < 9999 THEN 'HD00' + CONVERT(CHAR, CONVERT(INT, @InvoiceNo) + 1)
					WHEN @InvoiceNo >= 99 and @InvoiceNo < 999 THEN 'HD000' + CONVERT(CHAR, CONVERT(INT, @InvoiceNo) + 1)
					WHEN @InvoiceNo >= 9 and @InvoiceNo < 99 THEN 'HD0000' + CONVERT(CHAR, CONVERT(INT, @InvoiceNo) + 1)
					WHEN @InvoiceNo < 9 THEN 'HD00000' + CONVERT(CHAR, CONVERT(INT, @InvoiceNo) + 1)
			END
		END
	SELECT @InvoiceNo AS InvoiceNo
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Invoice_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Invoice_Insert]
			@InvoiceNo NVARCHAR(50),
			@StaffName NVARCHAR(255),
			@StaffCode NVARCHAR(50),
			@ShopID UNIQUEIDENTIFIER,
	          @CustomerPhone NVARCHAR(50),
			  @IsCash BIT,
	          @Description NVARCHAR(255),
	          @CustomerName NVARCHAR(255),
			  @CustomerAddress NVARCHAR(255),
			  @InvoiceDate DATETIME,
	          @TotalMoney MONEY
AS
BEGIN
	INSERT	dbo.Invoice
	        ( 
	          InvoiceNo ,
	          StaffName ,
			  StaffCode,
			  ShopID,
	          CustomerPhone ,
			  IsCash,
	          Description ,
	          CustomerName ,
			  CustomerAddress,
			  InvoiceDate,
	          TotalMoney
	        )
			OUTPUT Inserted.InvoiceID
	VALUES  ( 
			@InvoiceNo ,
			@StaffName ,
			@StaffCode,
			@ShopID,
	          @CustomerPhone ,
			  @IsCash,
	          @Description ,
	          @CustomerName ,
			  @CustomerAddress,
			  @InvoiceDate,
	          @TotalMoney

	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Invoice_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Invoice_Update]
			@InvoiceID UNIQUEIDENTIFIER,
			@InvoiceNo NVARCHAR(50),
			@StaffName NVARCHAR(255),
			@StaffCode NVARCHAR(50),
	          @CustomerPhone NVARCHAR(50),
			  @IsCash BIT,
	          @Description NVARCHAR(255),
	          @CustomerName NVARCHAR(255),
			  @CustomerAddress NVARCHAR(255),
			  @InvoiceDate DATETIME,
	          @TotalMoney MONEY
AS
BEGIN
	UPDATE dbo.Invoice
	SET		InvoiceNo = @InvoiceNo ,
			 StaffName = @StaffName ,
	          CustomerPhone = @CustomerPhone ,
			  StaffCode = @StaffCode,
	          Description = @Description ,
	          CustomerName = @CustomerName ,
			  IsCash = @IsCash,
			  CustomerAddress=@CustomerAddress,
			  InvoiceDate = @InvoiceDate,
	          TotalMoney = @TotalMoney
			  WHERE InvoiceID = @InvoiceID
			  SELECT TOP 1 * FROM dbo.Invoice WHERE InvoiceID = @InvoiceID
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_InvoiceDetail_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_InvoiceDetail_Insert]
		@InvoiceID UNIQUEIDENTIFIER,
		@ShopID UNIQUEIDENTIFIER,
		@SKUCode NVARCHAR(50),
		@ItemGroupCode NVARCHAR(50),
		@ItemGroupName NVARCHAR(100),
		@ItemName NVARCHAR(255),
		@Size NVARCHAR(255),
		@Color NVARCHAR(255),
		@Unit NVARCHAR(100),
		@UnitPrice MONEY,
	    @TotalMoney MONEY,
	    @Amount int
AS
BEGIN
	INSERT dbo.InvoiceDetail
	        ( 
	          InvoiceID ,
			  ShopID,
	          SKUCode ,
			  ItemGroupCode,
			  ItemGroupName,
	          ItemName ,
			  Size,
			  Color,
	          Unit ,
	          UnitPrice ,
	          TotalMoney ,
	          Amount
	        )
			OUTPUT Inserted.InvoiceDetailID
	VALUES  (
	          @InvoiceID , -- InvoiceID - uniqueidentifier
			  @ShopID,
	          @SKUCode , -- ItemCode - nvarchar(20)
			  @ItemGroupCode,
			  @ItemGroupName,
	          @ItemName ,
			  @Size,
			  @Color, -- ItemName - nvarchar(255)
	          @Unit , -- Unit - nvarchar(50)
	          @UnitPrice , -- UnitPrice - money
	          @TotalMoney , -- TotalMoney - money
	          @Amount -- Amount - int
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Inward_GetByCondition]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Inward_GetByCondition]
	@ShopID UNIQUEIDENTIFIER,
	@StartDate DATETIME,
	@EndDate DATETIME

AS
BEGIN
	IF @ShopID IS NOT NULL
	BEGIN
		SELECT * FROM dbo.Inward WHERE ShopID = @ShopID AND CAST(InwardDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) ORDER BY CreatedDate DESC
    END
    ELSE 
	BEGIN
		SELECT * FROM dbo.Inward WHERE CAST(InwardDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) ORDER BY CreatedDate DESC
    END
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Inward_GetNewestNo]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- DescriNKion:	<DescriNKion,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Inward_GetNewestNo]
AS
BEGIN
	DECLARE @InwardNo NVARCHAR(8)
	IF (SELECT COUNT(dbo.Inward.InwardNo) FROM dbo.Inward WHERE dbo.Inward.InwardNo LIKE 'NK%') = 0
		BEGIN
			SET @InwardNo = 'NK000001'
		END
	ELSE
		BEGIN
			SELECT @InwardNo = MAX(RIGHT(dbo.Inward.InwardNo, 6)) FROM dbo.Inward WHERE dbo.Inward.InwardNo LIKE 'NK%'
			SELECT @InwardNo = CASE
					WHEN @InwardNo >= 99999 THEN 'NK' + CONVERT(CHAR, CONVERT(INT, @InwardNo) + 1)
					WHEN @InwardNo >= 9999 and @InwardNo < 99999 THEN 'NK0' + CONVERT(CHAR, CONVERT(INT, @InwardNo) + 1)
					WHEN @InwardNo >= 999 and @InwardNo < 9999 THEN 'NK00' + CONVERT(CHAR, CONVERT(INT, @InwardNo) + 1)
					WHEN @InwardNo >= 99 and @InwardNo < 999 THEN 'NK000' + CONVERT(CHAR, CONVERT(INT, @InwardNo) + 1)
					WHEN @InwardNo >= 9 and @InwardNo < 99 THEN 'NK0000' + CONVERT(CHAR, CONVERT(INT, @InwardNo) + 1)
					WHEN @InwardNo < 9 THEN 'NK00000' + CONVERT(CHAR, CONVERT(INT, @InwardNo) + 1)
			END
		END
	SELECT @InwardNo AS InwardNo
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Inward_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Inward_Insert]
				@InwardNo NVARCHAR(50),
	          @InwardDate DATETIME,
	          @ShopID UNIQUEIDENTIFIER,
	          @TotalMoney MONEY,
			  @IsFromSupplier BIT,
	          @OutStaffName NVARCHAR(100),
	          @OutStaffCode NVARCHAR(50),
	          @Description NVARCHAR(255),
	          @Deliver NVARCHAR(100),
	          @InStaffName NVARCHAR(100),
	          @InStaffCode NVARCHAR(50)
AS
BEGIN
	INSERT dbo.Inward
	        ( 
	          InwardNo ,
	          InwardDate ,
	          ShopID ,
	          TotalMoney ,
			  IsFromSupplier,
	          OutStaffName ,
	          OutStaffCode ,
	          Description ,
	          Deliver ,
	          InStaffName ,
	          InStaffCode
	        )
			OUTPUT Inserted.InwardID
	VALUES  (
				@InwardNo ,
	          @InwardDate ,
	          @ShopID ,
	          @TotalMoney ,
			  @IsFromSupplier,
	          @OutStaffName ,
	          @OutStaffCode,
	          @Description ,
	          @Deliver,
	          @InStaffName ,
	          @InStaffCode
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Inward_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Inward_Update]
			@InwardID UNIQUEIDENTIFIER,
			@InwardNo NVARCHAR(50),
	          @InwardDate DATETIME,
	          @ShopID UNIQUEIDENTIFIER,
			  @IsFromSupplier BIT,
	          @TotalMoney MONEY,
	          @OutStaffName NVARCHAR(100),
	          @OutStaffCode NVARCHAR(50),
	          @Description NVARCHAR(255),
	          @Deliver NVARCHAR(100),
	          @InStaffName NVARCHAR(100),
	          @InStaffCode NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.Inward SET
				InwardNo = @InwardNo,
	          InwardDate = @InwardDate,
	          ShopID = @ShopID,
			  IsFromSupplier = @IsFromSupplier,
	          TotalMoney = @TotalMoney,
	          OutStaffName = @OutStaffName,
	          OutStaffCode = @OutStaffCode,
	          Description = @Description,
	          Deliver = @Deliver,
	          InStaffName = @InStaffName,
	          InStaffCode = @InStaffCode
			  WHERE InwardID = @InwardID
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_InwardDetail_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_InwardDetail_Insert]
				@InwardID UNIQUEIDENTIFIER,
				@SKUCode NVARCHAR(50),
	          @ItemName NVARCHAR(100),
	          @FromShop NVARCHAR(255),
			  @ShopID UNIQUEIDENTIFIER,
	          @Amount INT,
	          @Unit NVARCHAR(255),
	          @UnitPrice MONEY,
	          @TotalMoney MONEY
AS
BEGIN
	INSERT dbo.InwardDetail
	        ( 
	          InwardID ,
	          SKUCode ,
			  ShopID,
	          ItemName ,
	          FromShop ,
	          Amount ,
	          Unit ,
	          UnitPrice ,
	          TotalMoney
	        )
			OUTPUT Inserted.InwardDetailID
	VALUES  (
				@InwardID,
				@SKUCode,
				@ShopID,
				@ItemName,
				@FromShop,
				@Amount,
				@Unit,
				@UnitPrice,
				@TotalMoney
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Item_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Item_Insert]
				@ItemName NVARCHAR(255),
	          @ItemGroupName NVARCHAR(255),
			  @ItemGroupCode NVARCHAR(50),
	          @SupplierName NVARCHAR(255),
	          @SKUCode NVARCHAR(255),
	          @BuyPrice MONEY,
	          @SellPrice MONEY,
	          @UnitName NVARCHAR(255),
	          @ItemColor NVARCHAR(255),
	          @ItemSize NVARCHAR(255),
	          @Description NVARCHAR(255),
	          @ItemImage NVARCHAR(255)
AS
BEGIN
	INSERT	dbo.Item
	        ( 
	          ItemName ,
	          ItemGroupName ,
			  ItemGroupCode,
	          SupplierName ,
	          SKUCode ,
	          BuyPrice ,
	          SellPrice ,
	          UnitName ,
	          ItemColor ,
	          ItemSize ,
	          Description ,
	          ItemImage
	        )
						OUTPUT Inserted.ItemID
	VALUES  (
				@ItemName ,
	          @ItemGroupName ,
			  @ItemGroupCode,
	          @SupplierName ,
	          @SKUCode ,
	          @BuyPrice ,
	          @SellPrice ,
	          @UnitName ,
	          @ItemColor ,
	          @ItemSize ,
	          @Description ,
	          @ItemImage
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Item_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Item_Update]
				@ItemID UNIQUEIDENTIFIER,
				@ItemName NVARCHAR(255),
	          @ItemGroupName NVARCHAR(255),
			  @ItemGroupCode NVARCHAR(50),
	          @SupplierName NVARCHAR(255),
	          @SKUCode NVARCHAR(255),
	          @BuyPrice MONEY,
	          @SellPrice MONEY,
	          @UnitName NVARCHAR(255),
	          @ItemColor NVARCHAR(255),
	          @ItemSize NVARCHAR(255),
	          @Description NVARCHAR(255),
	          @ItemImage NVARCHAR(255)
AS
BEGIN
	UPDATE	dbo.Item SET
       ItemName = @ItemName ,
	         ItemGroupName= @ItemGroupName ,
			 ItemGroupCode = @ItemGroupCode,
	          SupplierName =@SupplierName ,
	          SKUCode = @SKUCode ,
	        BuyPrice =  @BuyPrice ,
	         SellPrice =  @SellPrice ,
	          UnitName = @UnitName ,
	          ItemColor = @ItemColor ,
	         ItemSize =  @ItemSize ,
	          Description = @Description,
	          ItemImage =@ItemImage 
			  WHERE ItemID = @ItemID
			  SELECT TOP 1 * FROM dbo.Item WHERE ItemID = @ItemID;
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_ItemGroup_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_ItemGroup_Insert]
			@ItemGroupCode NVARCHAR(20),
	          @ItemGroupName NVARCHAR(255),
	          @Description NVARCHAR(255),
			  @Status BIT
AS
BEGIN
	INSERT INTO dbo.ItemGroup
	        ( 
	          ItemGroupCode ,
	          ItemGroupName ,
	          Description,
			  Status
	        )
			OUTPUT Inserted.ItemGroupID
	VALUES  ( @ItemGroupCode , -- ItemGroupID - uniqueidentifier
	          @ItemGroupName , -- ItemGroupCode - nvarchar(20)
	          @Description , -- ItemGroupName - nvarchar(255)
	          @Status  -- Description - nvarchar(255)
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_ItemGroup_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_ItemGroup_Update]
	@ItemGroupID UNIQUEIDENTIFIER,
	@ItemGroupCode NVARCHAR(100),
	          @ItemGroupName NVARCHAR(255),
	          @Description NVARCHAR(255),
			  @Status BIT
AS
BEGIN
	UPDATE	dbo.ItemGroup
	SET
		ItemGroupCode = @ItemGroupCode,
		ItemGroupName = @ItemGroupName,
		Description = @Description,
		Status = @Status WHERE ItemGroupID = @ItemGroupID;
		SELECT TOP 1 * FROM dbo.ItemGroup WHERE ItemGroupID = @ItemGroupID;
END


GO
/****** Object:  StoredProcedure [dbo].[Proc_Outward_GetByCondition]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Outward_GetByCondition]
	@ShopID UNIQUEIDENTIFIER,
	@StartDate DATETIME,
	@EndDate DATETIME

AS
BEGIN
	IF @ShopID IS NOT NULL
	BEGIN
		SELECT * FROM dbo.Outward WHERE ShopID = @ShopID AND CAST(OutwardDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
	END
	ELSE 
	BEGIN
		SELECT * FROM dbo.Outward WHERE CAST(OutwardDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
    END
    
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Outward_GetNewestNo]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Outward_GetNewestNo]
AS
BEGIN
	DECLARE @OutwardNo NVARCHAR(8)
	IF (SELECT COUNT(dbo.Outward.OutwardNo) FROM dbo.Outward WHERE dbo.Outward.OutwardNo LIKE 'XK%') = 0
		BEGIN
			SET @OutwardNo = 'XK000001'
		END
	ELSE
		BEGIN
			SELECT @OutwardNo = MAX(RIGHT(dbo.Outward.OutwardNo, 6)) FROM dbo.Outward WHERE dbo.Outward.OutwardNo LIKE 'XK%'
			SELECT @OutwardNo = CASE
					WHEN @OutwardNo >= 99999 THEN 'XK' + CONVERT(CHAR, CONVERT(INT, @OutwardNo) + 1)
					WHEN @OutwardNo >= 9999 and @OutwardNo < 99999 THEN 'XK0' + CONVERT(CHAR, CONVERT(INT, @OutwardNo) + 1)
					WHEN @OutwardNo >= 999 and @OutwardNo < 9999 THEN 'XK00' + CONVERT(CHAR, CONVERT(INT, @OutwardNo) + 1)
					WHEN @OutwardNo >= 99 and @OutwardNo < 999 THEN 'XK000' + CONVERT(CHAR, CONVERT(INT, @OutwardNo) + 1)
					WHEN @OutwardNo >= 9 and @OutwardNo < 99 THEN 'XK0000' + CONVERT(CHAR, CONVERT(INT, @OutwardNo) + 1)
					WHEN @OutwardNo < 9 THEN 'XK00000' + CONVERT(CHAR, CONVERT(INT, @OutwardNo) + 1)
			END
		END
	SELECT @OutwardNo AS OutwardNo
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Outward_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Outward_Insert]
			@OutwardNo NVARCHAR(50),
	          @OutwardDate DATETIME,
	          @ShopID UNIQUEIDENTIFIER,
	          @TotalMoney MONEY,
	          @OutStaffName NVARCHAR(100),
	          @OutStaffCode NVARCHAR(20),
	          @Description NVARCHAR(255),
	          @Deliver NVARCHAR(255),
	          @InStaffName NVARCHAR(100),
	          @InStaffCode NVARCHAR(20)
AS
BEGIN
	INSERT dbo.Outward
	        ( 
	          OutwardNo ,
	          OutwardDate ,
	          ShopID ,
	          TotalMoney ,
	          OutStaffName ,
	          OutStaffCode ,
	          Description ,
	          Deliver ,
	          InStaffName ,
	          InStaffCode

	        )
			OUTPUT Inserted.OutwardID
	VALUES  ( 
			@OutwardNo,
			@OutwardDate,
			@ShopID,
			@TotalMoney,
			@OutStaffName,
			@OutStaffCode,
			@Description,
			@Deliver,
			@InStaffName,
			@InStaffCode
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Outward_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Outward_Update]
				@OutwardID UNIQUEIDENTIFIER,
				@OutwardNo NVARCHAR(50),
	          @OutwardDate DATETIME,
	          @ShopID UNIQUEIDENTIFIER,
	          @TotalMoney MONEY,
	          @OutStaffName NVARCHAR(100),
	          @OutStaffCode NVARCHAR(20),
	          @Description NVARCHAR(255),
	          @Deliver NVARCHAR(255),
	          @InStaffName NVARCHAR(100),
	          @InStaffCode NVARCHAR(20)
AS
BEGIN
	UPDATE dbo.Outward SET
     OutwardNo = @OutwardNo,
	          OutwardDate = @OutwardDate,
	          ShopID = @ShopID,
	          TotalMoney = @TotalMoney,
	          OutStaffName = @OutStaffName,
	          OutStaffCode = @OutStaffCode,
	          Description = @Description,
	          Deliver = @Deliver,
	          InStaffName = @InStaffName,
	          InStaffCode = @InStaffCode
			  WHERE OutwardID = @OutwardID
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_OutwardDetail_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_OutwardDetail_Insert]
@OutwardID UNIQUEIDENTIFIER,
	          @ShopID UNIQUEIDENTIFIER,
	          @SKUCode NVARCHAR(20),
	          @ItemName NVARCHAR(255),
	          @FromShop NVARCHAR(255),
	          @Amount INT,
	          @Unit NVARCHAR(100),
	          @UnitPrice MONEY,
	          @TotalMoney MONEY
AS
BEGIN
	INSERT dbo.OutwardDetail
	        (
	          OutwardID ,
	          ShopID ,
	          SKUCode ,
	          ItemName ,
	          FromShop ,
	          Amount ,
	          Unit ,
	          UnitPrice ,
	          TotalMoney
	        )
			OUTPUT Inserted.OutwardDetailID
	VALUES  ( 
	@OutwardID,
	@ShopID,
	@SKUCode,
	@ItemName,
	@FromShop,
	@Amount,
	@Unit,
	@UnitPrice,
	@TotalMoney
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Overview_GetIncomeByItemAmount]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Overview_GetIncomeByItemAmount]
	@ShopID NVARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL 
	BEGIN
		SELECT TOP 5 SKUCode, MAX(ItemName) AS ItemName, MAX(ItemGroupName) AS ItemGroupName, SUM(Amount) AS Amount
		FROM dbo.InvoiceDetail WHERE ShopID = @ShopID and CAST (CreatedDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) GROUP BY SKUCode
	END
	ELSE
    BEGIN
		SELECT TOP 5 SKUCode, MAX(ItemName) AS ItemName, MAX(ItemGroupName) AS ItemGroupName, SUM(Amount) AS Amount
		FROM dbo.InvoiceDetail WHERE CAST (CreatedDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) GROUP BY SKUCode
	END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Overview_GetIncomeByItemValue]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[Proc_Overview_GetIncomeByItemValue]
	@ShopID NVARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL
	BEGIN
		SELECT TOP 5 SKUCode, MAX(ItemName) AS ItemName, MAX(ItemGroupName) AS ItemGroupName, SUM(TotalMoney) AS TotalMoney
		FROM dbo.InvoiceDetail WHERE ShopID = @ShopID and CAST (CreatedDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) GROUP BY SKUCode
    END
	ELSE
	BEGIN
		SELECT TOP 5 SKUCode, MAX(ItemName) AS ItemName, MAX(ItemGroupName) AS ItemGroupName, SUM(TotalMoney) AS TotalMoney
		FROM dbo.InvoiceDetail WHERE CAST (CreatedDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) GROUP BY SKUCode
	END
  
	
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Overview_GetIncomeData]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Overview_GetIncomeData]
 @ShopID NVARCHAR(50),
 @StartDate DATETIME,
 @EndDate DATETIME
AS
BEGIN

	Create Table #IncomeData (
    Income DECIMAL,
	Outcome DECIMAL
	);
	IF @ShopID IS NOT NULL 
	BEGIN
    	INSERT INTO #IncomeData
			( Income,
			 Outcome )
		VALUES  ( 
				(SELECT SUM(TotalMoney) FROM dbo.Invoice WHERE ShopID = @ShopID AND CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)), -- Income - decimal
			  (SELECT SUM(TotalMoney) FROM dbo.Inward WHERE IsFromSupplier = 1 AND ShopID = @ShopID AND CAST(InwardDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE))  -- Outcome - decimal
			  )
	END    
	ELSE 
	BEGIN
		INSERT INTO #IncomeData
			( Income,
			 Outcome )
		VALUES  ( 
				(SELECT SUM(TotalMoney) FROM dbo.Invoice WHERE CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)), -- Income - decimal
			  (SELECT SUM(TotalMoney) FROM dbo.Inward WHERE IsFromSupplier = 1 AND CAST(InwardDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE))  -- Outcome - decimal
			  )
	END
    

	SELECT * FROM #IncomeData

	DROP TABLE #IncomeData
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Overview_GetIncomeDataByDay]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[Proc_Overview_GetIncomeDataByDay]
@ShopID NVARCHAR(50),
@StartDate DATETIME,
@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL
    BEGIN
		SELECT CAST(InvoiceDate AS DATE) AS InvoiceDate, SUM(TotalMoney) AS TotalMoney FROM dbo.Invoice WHERE ShopID = @ShopID AND CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) GROUP BY CAST(InvoiceDate AS DATE) 

    END
    
	ELSE 
	BEGIN
		SELECT CAST(InvoiceDate AS DATE) AS InvoiceDate, SUM(TotalMoney) AS TotalMoney FROM dbo.Invoice WHERE CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE) GROUP BY CAST(InvoiceDate AS DATE) 
    END
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Receipt_GetByCondition]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Receipt_GetByCondition]
	@ShopID UNIQUEIDENTIFIER,
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL
	BEGIN
		SELECT * FROM dbo.Receipt WHERE ShopID = @ShopID AND CAST(ReceiptDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
    END
    ELSE
    BEGIN
		SELECT * FROM dbo.Receipt WHERE CAST(ReceiptDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
    END
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Receipt_GetNewestNo]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Receipt_GetNewestNo]

AS
BEGIN
DECLARE @ReceiptNo NVARCHAR(8)
	IF (SELECT COUNT(dbo.Receipt.ReceiptNo) FROM dbo.Receipt WHERE dbo.Receipt.ReceiptNo LIKE 'PT%') = 0
		BEGIN
			SET @ReceiptNo = 'PT000001'
		END
	ELSE
		BEGIN
			SELECT @ReceiptNo = MAX(RIGHT(dbo.Receipt.ReceiptNo, 6)) FROM dbo.Receipt WHERE dbo.Receipt.ReceiptNo LIKE 'PT%'
			SELECT @ReceiptNo = CASE
					WHEN @ReceiptNo >= 99999 THEN 'PT' + CONVERT(CHAR, CONVERT(INT, @ReceiptNo) + 1)
					WHEN @ReceiptNo >= 9999 and @ReceiptNo < 99999 THEN 'PT0' + CONVERT(CHAR, CONVERT(INT, @ReceiptNo) + 1)
					WHEN @ReceiptNo >= 999 and @ReceiptNo < 9999 THEN 'PT00' + CONVERT(CHAR, CONVERT(INT, @ReceiptNo) + 1)
					WHEN @ReceiptNo >= 99 and @ReceiptNo < 999 THEN 'PT000' + CONVERT(CHAR, CONVERT(INT, @ReceiptNo) + 1)
					WHEN @ReceiptNo >= 9 and @ReceiptNo < 99 THEN 'PT0000' + CONVERT(CHAR, CONVERT(INT, @ReceiptNo) + 1)
					WHEN @ReceiptNo < 9 THEN 'PT00000' + CONVERT(CHAR, CONVERT(INT, @ReceiptNo) + 1)
			END
		END
	SELECT @ReceiptNo AS ReceiptNo
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Receipt_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Receipt_Insert]
			@ReceiptNo NVARCHAR(50),
			@ShopID UNIQUEIDENTIFIER,
	          @ReceiptDate DATETIME,
	          @ReceiptType INT,
	          @StaffName NVARCHAR(100) ,
	          @StaffCode NVARCHAR(50),
			  @AccountObjectPhone NVARCHAR(50),
	          @AccountObjectName NVARCHAR(50),
	          @Address NVARCHAR(255),
	          @TotalMoney MONEY,
	          @ReceiptReason NVARCHAR(255)
AS
BEGIN
	INSERT dbo.Receipt
	        ( 
	          ReceiptNo ,
			  ShopID,
	          ReceiptDate ,
	          ReceiptType ,
	          StaffName ,
			  StaffCode,
	          AccountObjectPhone ,
	          AccountObjectName ,	          
	          Address ,
	          TotalMoney ,
	          ReceiptReason
	        )
			OUTPUT Inserted.ReceiptID
	VALUES  ( 
			@ReceiptNo,
			@ShopID,
			@ReceiptDate,
			@ReceiptType,
			@StaffName,
			@StaffCode,
			@AccountObjectPhone,
			@AccountObjectName,
			@Address,
			@TotalMoney,
			@ReceiptReason
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Receipt_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Receipt_Update]
			@ReceiptID UNIQUEIDENTIFIER,
			@ShopID UNIQUEIDENTIFIER,
	          @ReceiptDate DATETIME,
	          @ReceiptType INT,
			  @AccountObjectPhone NVARCHAR(50),
	          @AccountObjectName NVARCHAR(50),
	          @Address NVARCHAR(255),
	          @TotalMoney MONEY,
	          @ReceiptReason NVARCHAR(255)
AS
BEGIN
	UPDATE dbo.Receipt SET
	ReceiptDate = @ReceiptDate,
	AccountObjectPhone = @AccountObjectPhone,
	AccountObjectName = @AccountObjectName,
	Address = @Address,
	TotalMoney = @TotalMoney,
	ReceiptReason = @ReceiptReason
	WHERE ReceiptID = @ReceiptID AND ShopID = @ShopID
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_ReceiptDetail_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_ReceiptDetail_Insert]
			@ReceiptID UNIQUEIDENTIFIER,
			@ShopID UNIQUEIDENTIFIER,
	          @ReceiptCategory NVARCHAR(255),
	          @Description NVARCHAR(255),
	          @Money MONEY
AS
BEGIN
	INSERT	dbo.ReceiptDetail
	        (
	          ReceiptID ,
			  ShopID,
	          ReceiptCategory ,
	          Description ,
	          Money
	        )
	OUTPUT Inserted.ReceiptDetailID
	VALUES  (
				@ReceiptID,
				@ShopID,
				@ReceiptCategory,
				@Description,
				@Money	
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SaleReport_GetIncomeByItem]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_SaleReport_GetIncomeByItem]
	@ShopID NVARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL

	BEGIN
		SELECT SKUCode, ItemName, Color, Size, Unit, SUM(Amount) AS Amount, UnitPrice, SUM(TotalMoney) AS TotalMoney
		 FROM dbo.InvoiceDetail WHERE ShopID = @ShopID and CAST(CreatedDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
		  GROUP BY SKUCode, ItemName, Color, Size, Unit, UnitPrice
	END
    
	ELSE
    BEGIN
			SELECT SKUCode, ItemName, Color, Size, Unit, SUM(Amount) AS Amount, UnitPrice, SUM(TotalMoney) AS TotalMoney
		 FROM dbo.InvoiceDetail WHERE CAST(CreatedDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
		  GROUP BY SKUCode, ItemName, Color, Size, Unit, UnitPrice
	END
    

END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SaleReport_GetIncomeByItemGroup]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_SaleReport_GetIncomeByItemGroup]
	@ShopID NVARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
 IF @ShopID IS NOT NULL
 BEGIN 
 	SELECT ItemGroupCode, ItemGroupName, SUM(TotalMoney) AS TotalMoney FROM dbo.InvoiceDetail
	 where ShopID = @ShopID AND CAST(CreatedDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
	  GROUP BY ItemGroupCode, ItemGroupName

 END
 ELSE 

 BEGIN
  	SELECT ItemGroupCode, ItemGroupName, SUM(TotalMoney) AS TotalMoney FROM dbo.InvoiceDetail
	 where CAST(CreatedDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
	  GROUP BY ItemGroupCode, ItemGroupName
 END
 

END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SaleReport_GetIncomeByStaff]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_SaleReport_GetIncomeByStaff]
	@ShopID NVARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL 
	BEGIN 
		SELECT StaffCode, StaffName, SUM(TotalMoney) AS TotalMoney FROM dbo.Invoice
		 WHERE ShopID = @ShopID AND CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
		 GROUP BY StaffCode, StaffName 
	END
    ELSE 
	BEGIN
		SELECT StaffCode, StaffName, SUM(TotalMoney) AS TotalMoney FROM dbo.Invoice
		 WHERE CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
		 GROUP BY StaffCode, StaffName
    END
    

END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SaleReport_GetInvoiceAndItemTable]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_SaleReport_GetInvoiceAndItemTable]
	@ShopID NVARCHAR(50),
	@StaffCode NVARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	
	IF @ShopID IS NOT NULL
	BEGIN
		SELECT InvoiceDate, InvoiceNo, SKUCode, ItemName, Unit, Amount, UnitPrice, InvoiceDetail.TotalMoney, StaffName, CustomerName, CustomerPhone
		 FROM dbo.InvoiceDetail, dbo.Invoice WHERE dbo.InvoiceDetail.InvoiceID = dbo.Invoice.InvoiceID
		  AND Invoice.ShopID = @ShopID AND StaffCode = @StaffCode AND CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)

		   ORDER BY InvoiceNo DESC
	END
    ELSE 
	BEGIN
		SELECT InvoiceDate, InvoiceNo, SKUCode, ItemName, Unit, Amount, UnitPrice, InvoiceDetail.TotalMoney, StaffName, CustomerName, CustomerPhone
		 FROM dbo.InvoiceDetail, dbo.Invoice WHERE dbo.InvoiceDetail.InvoiceID = dbo.Invoice.InvoiceID
		  AND StaffCode = @StaffCode AND CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
		   ORDER BY InvoiceNo DESC
    END
    
	

END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SaleReport_GetSaleByDay]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_SaleReport_GetSaleByDay]
	@ShopID NVARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL
	BEGIN
	 SELECT CAST(InvoiceDate AS DATE) as InvoiceDate, IsCash, SUM(TotalMoney)
	 AS TotalMoney FROM dbo.Invoice WHERE ShopID = @ShopID AND CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
	  GROUP BY CAST(InvoiceDate AS DATE), IsCash
	  END 
	  ELSE
	  BEGIN
	 SELECT CAST(InvoiceDate AS DATE) as InvoiceDate, IsCash, SUM(TotalMoney)
	 AS TotalMoney FROM dbo.Invoice  WHERE CAST(InvoiceDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS DATE)
	  GROUP BY CAST(InvoiceDate AS DATE), IsCash
	  END	  
END
	
GO
/****** Object:  StoredProcedure [dbo].[Proc_Setting_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Setting_Insert]
			@MorningShiftStart datetime,
	          @MorningShiftEnd datetime,
	          @AfternoonShiftStart datetime ,
	          @AfternoonShiftEnd DATETIME,
	          @NightShiftStart datetime,
	          @NightShiftEnd datetime,
	          @WorkingDayStart INT,
	          @WorkingDayEnd INT,
	          @WorkingDayAmount INT,
	          @SalaryDay INT,
	          @SumUpDay int
AS
BEGIN
	INSERT INTO dbo.Setting
	        ( 
	          MorningShiftStart ,
	          MorningShiftEnd ,
	          AfternoonShiftStart ,
	          AfternoonShiftEnd ,
	          NightShiftStart ,
	          NightShiftEnd ,
	          WorkingDayStart ,
	          WorkingDayEnd ,
	          WorkingDayAmount , 
	          SalaryDay ,
	          SumUpDay
	        )
			OUTPUT Inserted.SettingID
	VALUES  ( 
	          @MorningShiftStart , -- MorningShiftStart - time
	          @MorningShiftEnd , -- MorningShiftEnd - time
	          @AfternoonShiftStart , -- AfternoonShiftStart - time
	          @AfternoonShiftEnd , -- AfternoonShiftEnd - time
	          @NightShiftStart , -- NightShiftStart - time
	          @NightShiftEnd , -- NightShiftEnd - time
	          @WorkingDayStart , -- WorkingDayStart - int
			  @WorkingDayEnd , -- WorkingDayEnd - int
	          @WorkingDayAmount , -- WorkingDayAmount - int
	          @SalaryDay , -- SalaryDay - int
	          @SumUpDay -- WokingDayEnd - int
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Setting_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Setting_Update]
			@SettingID UNIQUEIDENTIFIER,
			@MorningShiftStart DATETIME,
	          @MorningShiftEnd DATETIME,
	          @AfternoonShiftStart DATETIME ,
	          @AfternoonShiftEnd DATETIME,
	          @NightShiftStart DATETIME,
	          @NightShiftEnd DATETIME,
	          @WorkingDayStart INT,
	          @WorkingDayEnd INT,
	          @WorkingDayAmount INT,
	          @SalaryDay INT,
	          @SumUpDay int
AS
BEGIN
	UPDATE dbo.Setting SET
	MorningShiftStart = @MorningShiftStart,
	MorningShiftEnd = @MorningShiftEnd,
	AfternoonShiftStart = @AfternoonShiftStart,
	AfternoonShiftEnd = @AfternoonShiftEnd,
	NightShiftStart = @NightShiftStart,
	NightShiftEnd = @NightShiftEnd,
	WorkingDayStart = @WorkingDayStart,
	WorkingDayEnd = @WorkingDayEnd,
	WorkingDayAmount = @WorkingDayEnd,
	SalaryDay = @SalaryDay,
	SumUpDay = @SumUpDay
	WHERE SettingID = @SettingID
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Shop_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Shop_Insert]
		@ShopCode NVARCHAR(50),
		@ShopName NVARCHAR(255),
		@Address NVARCHAR(255),
		@PhoneNumber NVARCHAR(50)
AS
BEGIN
	INSERT	dbo.Shop
	        (
	          ShopCode ,
	          ShopName ,
	          Address ,
	          PhoneNumber
	        )
			OUTPUT Inserted.ShopID
	VALUES  (
	          @ShopCode,
			  @ShopName,
			  @Address,
			  @PhoneNumber
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Shop_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Shop_Update]
	@ShopID UNIQUEIDENTIFIER,
		@ShopCode NVARCHAR(50),
		@ShopName NVARCHAR(255),
		@Address NVARCHAR(255),
		@PhoneNumber NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.Shop SET
    ShopCode = @ShopCode,
	ShopName = @ShopName,
	Address = @Address,
	PhoneNumber = @PhoneNumber
	WHERE ShopID = @ShopID
	SELECT TOP 1 * FROM dbo.Shop WHERE ShopID = @ShopID
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Staff_GetNewestNo]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- DescriNVion:	<DescriNVion,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Staff_GetNewestNo]
AS
BEGIN
	DECLARE @StaffCode NVARCHAR(8)
	IF (SELECT COUNT(dbo.Staff.StaffCode) FROM dbo.Staff WHERE dbo.Staff.StaffCode LIKE 'NV%') = 0
		BEGIN
			SET @StaffCode = 'NV000001'
		END
	ELSE
		BEGIN
			SELECT @StaffCode = MAX(RIGHT(dbo.Staff.StaffCode, 6)) FROM dbo.Staff WHERE dbo.Staff.StaffCode LIKE 'NV%'
			SELECT @StaffCode = CASE
					WHEN @StaffCode >= 99999 THEN 'NV' + CONVERT(CHAR, CONVERT(INT, @StaffCode) + 1)
					WHEN @StaffCode >= 9999 and @StaffCode < 99999 THEN 'NV0' + CONVERT(CHAR, CONVERT(INT, @StaffCode) + 1)
					WHEN @StaffCode >= 999 and @StaffCode < 9999 THEN 'NV00' + CONVERT(CHAR, CONVERT(INT, @StaffCode) + 1)
					WHEN @StaffCode >= 99 and @StaffCode < 999 THEN 'NV000' + CONVERT(CHAR, CONVERT(INT, @StaffCode) + 1)
					WHEN @StaffCode >= 9 and @StaffCode < 99 THEN 'NV0000' + CONVERT(CHAR, CONVERT(INT, @StaffCode) + 1)
					WHEN @StaffCode < 9 THEN 'NV00000' + CONVERT(CHAR, CONVERT(INT, @StaffCode) + 1)
			END
		END
	SELECT @StaffCode AS StaffCode
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Staff_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Staff_Insert]
			@StaffCode NVARCHAR(50),
	          @StaffName NVARCHAR(100),
	          @Password NVARCHAR(50),
			  @ShopID UNIQUEIDENTIFIER,
	          @Birthday DATETIME,
	          @Gender NVARCHAR(20),
	          @RoleType INT,
	          @IdentityNumber NVARCHAR(50),
	          @DateOfIssued DATETIME,
	          @PlaceOfIssued NVARCHAR(255),
	          @Avatar NVARCHAR(255),	         
	          @MobilePhone NVARCHAR(255),
	          @HomePhone NVARCHAR(255),
	          @Email NVARCHAR(255),
			  @TimeWorkingStatus NVARCHAR(255),
	          @RegularAddress NVARCHAR(255),
	          @RegularNation NVARCHAR(255),
	          @RegularProvince NVARCHAR(255),
	          @RegularDistrict NVARCHAR(255),
	          @RegularTown NVARCHAR(255),
	          @RecentAddress NVARCHAR(255),
	          @RecentNation NVARCHAR(255),
	          @RecentProvince NVARCHAR(255),
	          @RecentDistrict NVARCHAR(255),
	          @RecentTown NVARCHAR(255),
	          @EmerContactName NVARCHAR(255),
	          @EmerContactRelation NVARCHAR(255),
	          @EmerContactMobilePhone NVARCHAR(255),
	          @EmerContactHomePhone NVARCHAR(255),
	          @EmerContactEmail NVARCHAR(255),
	          @EmerContactAddress NVARCHAR(255),
	          @Salary NVARCHAR(255),
	          @WokingStatus NVARCHAR(255),
	          @TryingWorkFrom DATETIME,
	          @TryingWorkTo DATETIME,
	          @OffcialWorkFrom DATETIME,
	          @OffcialWorkTo DATETIME
AS
BEGIN
	INSERT dbo.Staff
	        (
	          StaffCode ,
	          StaffName ,
	          Password ,
			  ShopID,
	          Birthday ,
	          Gender ,
	          RoleType ,
	          IdentityNumber ,
	          DateOfIssued ,
	          PlaceOfIssued ,
	          Avatar ,
	          TimeWorkingStatus ,
	          MobilePhone ,
	          HomePhone ,
	          Email ,
	          RegularAddress ,
	          RegularNation ,
	          RegularProvince ,
	          RegularDistrict ,
	          RegularTown ,
	          RecentAddress ,
	          RecentNation ,
	          RecentProvince ,
	          RecentDistrict ,
	          RecentTown ,
	          EmerContactName ,
	          EmerContactRelation ,
	          EmerContactMobilePhone ,
	          EmerContactHomePhone ,
	          EmerContactEmail ,
	          EmerContactAddress ,
	          Salary ,
	          WokingStatus ,
	          TryingWorkFrom ,
	          TryingWorkTo ,
	          OffcialWorkFrom ,
	          OffcialWorkTo
	        )
			OUTPUT Inserted.StaffID
	VALUES  (
			@StaffCode ,
	          @StaffName ,
	          @Password ,
			   @ShopID,
	          @Birthday ,
	          @Gender ,
	          @RoleType ,
	          @IdentityNumber ,
	          @DateOfIssued ,
	          @PlaceOfIssued ,
	          @Avatar ,
	          @TimeWorkingStatus ,
	          @MobilePhone ,
	          @HomePhone ,
	          @Email ,
	          @RegularAddress ,
	          @RegularNation ,
	          @RegularProvince ,
	          @RegularDistrict ,
	          @RegularTown ,
	          @RecentAddress ,
	          @RecentNation ,
	          @RecentProvince ,
	          @RecentDistrict ,
	          @RecentTown ,
	          @EmerContactName ,
	          @EmerContactRelation ,
	          @EmerContactMobilePhone ,
	          @EmerContactHomePhone ,
	          @EmerContactEmail ,
	          @EmerContactAddress ,
	          @Salary ,
	          @WokingStatus ,
	          @TryingWorkFrom ,
	          @TryingWorkTo ,
	          @OffcialWorkFrom ,
	          @OffcialWorkTo
	        );
			INSERT	dbo.Account
			        ( 
			Username ,
	          Password ,
	          StaffCode ,
			  StaffName,
	          RoleType,
			  ShopID
			        )
			VALUES  (  @StaffCode , -- Username - nvarchar(50)
	          @Password, -- Password - nvarchar(50)
			@StaffCode, -- StaffID - uniqueidentifier
			@StaffName,
	          @RoleType,
			  @ShopID
			        )
	     
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Staff_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Staff_Update]
				@StaffID UNIQUEIDENTIFIER,
				@StaffCode NVARCHAR(50),
	          @StaffName NVARCHAR(100),
	          @Password NVARCHAR(50),
	          @Birthday DATETIME,
	          @Gender NVARCHAR(20),
	          @RoleType int,
	          @IdentityNumber NVARCHAR(50),
	          @DateOfIssued DATETIME,
	          @PlaceOfIssued NVARCHAR(255),
	          @Avatar NVARCHAR(255),
	          @TimeWorkingStatus NVARCHAR(255),
	          @MobilePhone NVARCHAR(255),
	          @HomePhone NVARCHAR(255),
	          @Email NVARCHAR(255),
	          @RegularAddress NVARCHAR(255),
	          @RegularNation NVARCHAR(255),
	          @RegularProvince NVARCHAR(255),
	          @RegularDistrict NVARCHAR(255),
	          @RegularTown NVARCHAR(255),
	          @RecentAddress NVARCHAR(255),
	          @RecentNation NVARCHAR(255),
	          @RecentProvince NVARCHAR(255),
	          @RecentDistrict NVARCHAR(255),
	          @RecentTown NVARCHAR(255),
	          @EmerContactName NVARCHAR(255),
	          @EmerContactRelation NVARCHAR(255),
	          @EmerContactMobilePhone NVARCHAR(255),
	          @EmerContactHomePhone NVARCHAR(255),
	          @EmerContactEmail NVARCHAR(255),
	          @EmerContactAddress NVARCHAR(255),
	          @Salary NVARCHAR(255),
	          @WokingStatus NVARCHAR(255),
	          @TryingWorkFrom DATETIME,
	          @TryingWorkTo DATETIME,
	          @OffcialWorkFrom DATETIME,
	          @OffcialWorkTo DATETIME
AS
BEGIN
UPDATE dbo.Staff SET
			StaffCode =	 @StaffCode ,
	          StaffName=@StaffName ,
	          Password = @Password ,
	          Birthday=@Birthday ,
	         Gender = @Gender ,
	          RoleType = @RoleType ,
	          IdentityNumber = @IdentityNumber ,
	          DateOfIssued = @DateOfIssued ,
	          PlaceOfIssued =@PlaceOfIssued ,
	          Avatar = @Avatar ,
	          TimeWorkingStatus = @TimeWorkingStatus ,
	          MobilePhone = @MobilePhone ,
	          HomePhone = @HomePhone ,
	          Email = @Email ,
	          RegularAddress = @RegularAddress ,
	          RegularNation = @RegularNation ,
	          RegularProvince = @RegularProvince ,
	          RegularDistrict = @RegularDistrict ,
	          RegularTown = @RegularTown ,
	          RecentAddress = @RecentAddress ,
	          RecentNation = @RecentNation ,
	          RecentProvince = @RecentProvince ,
	          RecentDistrict = @RecentDistrict ,
	          RecentTown = @RecentTown ,
	          EmerContactName = @EmerContactName ,
	          EmerContactRelation = @EmerContactRelation ,
	          EmerContactMobilePhone = @EmerContactMobilePhone ,
	          EmerContactHomePhone = @EmerContactHomePhone ,
	          EmerContactEmail = @EmerContactEmail ,
	          EmerContactAddress = @EmerContactAddress ,
	          Salary = @Salary ,
	          WokingStatus = @WokingStatus ,
	          TryingWorkFrom = @TryingWorkFrom ,
	          TryingWorkTo = @TryingWorkTo ,
	          OffcialWorkFrom = @OffcialWorkFrom ,
	          OffcialWorkTo = @OffcialWorkTo
			  WHERE StaffID = @StaffID;
			  SELECT TOP 1 * FROM dbo.Staff WHERE StaffID = @StaffID;
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Store_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Store_Insert]
				@ShopID UNIQUEIDENTIFIER,
	          @SKUCode NVARCHAR(20),
	          @ItemName NVARCHAR(100),
	          @Unit NVARCHAR(50),
	          @ItemGroupName NVARCHAR(100),
	          @ChangeDate DATETIME,
	          @InAmount INT,
			  @OutAmount INT,
			  @UnitPrice MONEY
AS
BEGIN
	INSERT dbo.Store
	        ( 
				ShopID ,
	          SKUCode ,
	          ItemName ,
	          Unit ,
	          ItemGroupName ,
	          ChangeDate ,
	          InAmount,
			  OutAmount,
			  UnitPrice
	        )
			OUTPUT Inserted.StoreID
	VALUES  (
			@ShopID,
			@SKUCode,
			@ItemName,
			@Unit,
			@ItemGroupName,
			@ChangeDate,
			@InAmount,
			@OutAmount,
			@UnitPrice
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_StoreReport_GetCurrentAmount]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_StoreReport_GetCurrentAmount]
		@ShopID UNIQUEIDENTIFIER,
		@StartDate DATETIME,
		@EndDate DATETIME
AS
BEGIN
	SELECT SKUCode, IsIn, MAX(ItemName) AS ItemName, MAX(Unit) AS Unit, UnitPrice, MAX(ItemGroupName) AS ItemGroupName, 
	SUM(Amount) AS Amount FROM dbo.Store GROUP BY SKUCode, IsIn, UnitPrice
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_StoreReport_GetCurrentItemAmount]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_StoreReport_GetCurrentItemAmount]
		@ShopID UNIQUEIDENTIFIER,
		@StartDate DATETIME,
		@EndDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL
	BEGIN 
		SELECT 
           SKUCode ,
           MAX(ItemName) AS ItemName,
           MAX(Unit) AS Unit,
           Max(ItemGroupName )AS ItemGroupName,
           SUM(InAmount) AS InAmount,
		   SUM(OutAmount) AS OutAmount,
           MAX(UnitPrice) AS UnitPrice
			FROM dbo.Store WHERE ShopID = @ShopID AND CAST(ChangeDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND
            CAST(@EndDate AS DATE)
		   GROUP BY SKUCode
	END
    ELSE 
	BEGIN
			SELECT 
           SKUCode ,
           MAX(ItemName) AS ItemName,
           MAX(Unit) AS Unit,
           Max(ItemGroupName )AS ItemGroupName,
           SUM(InAmount) AS InAmount,
		   SUM(OutAmount) AS OutAmount,
           MAX(UnitPrice) AS UnitPrice
		    FROM dbo.Store WHERE CAST(ChangeDate AS DATE) BETWEEN CAST(@StartDate AS DATE) AND
            CAST(@EndDate AS DATE)
		   GROUP BY SKUCode
	END
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_StoreReport_GetDataByItem]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_StoreReport_GetDataByItem]
		@ShopID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT SKUCode, MAX(ItemName) AS ItemName, MAX(Unit) AS Unit, MAX(ItemGroupName) AS ItemGroupName, 
	SUM(Amount) AS Amount FROM dbo.Store GROUP BY SKUCode
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_StoreReport_GetPreAmount]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_StoreReport_GetPreAmount]
		@ShopID UNIQUEIDENTIFIER,
		@StartDate DATETIME,
		@EndDate DATETIME
AS
BEGIN
	SELECT SKUCode, MAX(ItemName) AS ItemName, MAX(Unit) AS Unit, UnitPrice, MAX(ItemGroupName) AS ItemGroupName, 
	SUM(Amount) AS Amount FROM dbo.Store GROUP BY SKUCode, UnitPrice
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_StoreReport_GetPreItemAmount]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE
 PROCEDURE [dbo].[Proc_StoreReport_GetPreItemAmount]
		@ShopID UNIQUEIDENTIFIER,
		@StartDate DATETIME
AS
BEGIN
	IF @ShopID IS NOT NULL
	BEGIN 
		SELECT 
           SKUCode ,
           MAX(ItemName) AS ItemName,
           MAX(Unit) AS Unit,
           Max(ItemGroupName )AS ItemGroupName,
           SUM(InAmount) AS InAmount,
		   SUM(OutAmount) AS OutAmount,
           MAX(UnitPrice) AS UnitPrice
			FROM dbo.Store WHERE ShopID = @ShopID AND CAST(ChangeDate AS DATE) < CAST(@StartDate AS DATE)
		   GROUP BY SKUCode
	END
    ELSE 
	BEGIN
			SELECT 
           SKUCode ,
           MAX(ItemName) AS ItemName,
           MAX(Unit) AS Unit,
           Max(ItemGroupName )AS ItemGroupName,
           SUM(InAmount) AS InAmount,
		   SUM(OutAmount) AS OutAmount,
           MAX(UnitPrice) AS UnitPrice
		    FROM dbo.Store WHERE CAST(ChangeDate AS DATE) < CAST(@StartDate AS DATE)
		   GROUP BY SKUCode
	END
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Supplier_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Supplier_Insert]
			@SupplierCode NVARCHAR(50),
	          @SupplierName NVARCHAR(100),
	          @SupplierAddress NVARCHAR(255),
	          @BankAccount NVARCHAR(50),
	          @BankName NVARCHAR(255),
	          @BankBranch NVARCHAR(255),
	          @SupplierPhone NVARCHAR(50),
	          @ContactName NVARCHAR(100),
	          @ContactPhone NVARCHAR(50),
	          @ContactEmail NVARCHAR(50),
	          @ContactAddress NVARCHAR(255)
AS
BEGIN
	INSERT dbo.Supplier
	        ( 
	          SupplierCode ,
	          SupplierName ,
	          SupplierAddress ,
	          BankAccount ,
	          BankName ,
	          BankBranch ,
	          SupplierPhone ,
	          ContactName ,
	          ContactPhone ,
	          ContactEmail ,
	          ContactAddress
	        )
			OUTPUT Inserted.SupplierID
	VALUES  ( 
	          @SupplierCode,
			  @SupplierName,
			  @SupplierAddress,
			  @BankAccount,
			  @BankName,
			  @BankBranch,
			  @SupplierPhone,
			  @ContactName,
			  @ContactPhone,
			  @ContactEmail,
			  @ContactAddress
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Supplier_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Supplier_Update]
			@SupplierID UNIQUEIDENTIFIER,
			@SupplierCode NVARCHAR(50),
	          @SupplierName NVARCHAR(100),
	          @SupplierAddress NVARCHAR(255),
	          @BankAccount NVARCHAR(50),
	          @BankName NVARCHAR(255),
	          @BankBranch NVARCHAR(255),
	          @SupplierPhone NVARCHAR(50),
	          @ContactName NVARCHAR(100),
	          @ContactPhone NVARCHAR(50),
	          @ContactEmail NVARCHAR(50),
	          @ContactAddress NVARCHAR(255)
AS
BEGIN
	UPDATE dbo.Supplier
	SET      SupplierCode = @SupplierCode,
	          SupplierName = @SupplierName,
	          SupplierAddress = @SupplierAddress,
	          BankAccount =@BankAccount,
	          BankName = @BankName,
	          BankBranch = @BankBranch,
	          SupplierPhone = @SupplierPhone,
	          ContactName = @ContactName,
	          ContactPhone = @ContactPhone,
	          ContactEmail = @ContactEmail,
	          ContactAddress = @ContactAddress
			  WHERE SupplierID = @SupplierID
			  SELECT TOP 1 * FROM dbo.Supplier WHERE SupplierID = @SupplierID
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Unit_Insert]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Unit_Insert]
	          @UnitName NVARCHAR(255),
	          @Description NVARCHAR(255),
	          @Status bit
AS
BEGIN
	INSERT dbo.Unit
	        ( UnitName ,
	          Description ,
	          Status
	        )
			OUTPUT Inserted.UnitID
	VALUES  (
	          @UnitName , -- UnitName - nvarchar(255)
	          @Description , -- Description - nvarchar(255)
	          @Status -- Status - bit
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Unit_Update]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Unit_Update]
	@UnitID UNIQUEIDENTIFIER,
	@UnitName NVARCHAR(255),
	@Description NVARCHAR(255),
	@Status bit
AS
BEGIN
	UPDATE	dbo.Unit
	SET
	          UnitName = @UnitName,
	          Description = @Description,
	          Status = @Status WHERE UnitID = @UnitID;
			  SELECT TOP 1 * FROM dbo.Unit WHERE UnitID = @UnitID;
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_WorkDay_GetByUser]    Script Date: 2/5/2020 7:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_WorkDay_GetByUser]
	@UserID UNIQUEIDENTIFIER,
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	SELECT 
           CheckIn ,
           CheckOut
         FROM dbo.WorkDay WHERE UserID = @UserID AND CAST(CheckIn AS DATE) BETWEEN CAST(@StartDate AS DATE) AND CAST(@EndDate AS Date)
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên tài khoản' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mật khẩu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên nhân viên' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'StaffName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã nhân viên' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'StaffCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Loại người dùng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'RoleType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID cửa hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'ShopID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên khách hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số điện thoại' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PhoneNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'InvoiceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID Nhân viên bán hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'StaffName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'CustomerPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên khách hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'CustomerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Thành tiền' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'TotalMoney'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Invoice', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên sản phẩm' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InvoiceDetail', @level2type=N'COLUMN',@level2name=N'ItemName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đơn giá' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InvoiceDetail', @level2type=N'COLUMN',@level2name=N'UnitPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số lượng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InvoiceDetail', @level2type=N'COLUMN',@level2name=N'Amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InvoiceDetail', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InvoiceDetail', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InvoiceDetail', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InvoiceDetail', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Phiếu nhập kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'InwardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số phiếu nhập' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'InwardNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày nhập' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'InwardDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID kho xuất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'ShopID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tổng tiền' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'TotalMoney'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Diễn giải' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người giao' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'Deliver'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đối tượng xuất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'InStaffCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Inward', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'InwardDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID phiếu nhập kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'InwardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại mã hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'SKUCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID Kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'ItemName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số lượng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'Amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đơn giá' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'UnitPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InwardDetail', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'ItemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'ItemName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại Mã nhóm hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'ItemGroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại Mã nhà cung cấp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'SupplierName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'SKUCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Giá mua' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'BuyPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Giá bán' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'SellPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại Đơn vị tính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'UnitName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ảnh hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'ItemImage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ItemGroup', @level2type=N'COLUMN',@level2name=N'ItemGroupID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên nhóm hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ItemGroup', @level2type=N'COLUMN',@level2name=N'ItemGroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Diễn giải' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ItemGroup', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ItemGroup', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ItemGroup', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ItemGroup', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ItemGroup', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Phiếu xuất kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'OutwardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số phiếu xuất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'OutwardNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày xuất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'OutwardDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID kho xuất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'ShopID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tổng tiền' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'TotalMoney'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Diễn giải' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người giao' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'Deliver'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đối tượng xuất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'InStaffCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Outward', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'OutwardDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID phiếu xuất kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'OutwardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại mã hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'SKUCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID Kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'ItemName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số lượng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'Amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đơn giá' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'UnitPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OutwardDetail', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'ReceiptID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số chứng từ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'ReceiptNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chứng từ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'ReceiptDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Loại phiếu (0: thu, 1: chi)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'ReceiptType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID nhân viên thu/chi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'StaffCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại Đối tượng nộp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'AccountObjectPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên đối tượng nộp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'AccountObjectName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Địa chỉ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tổng tiền' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'TotalMoney'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lý do thu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'ReceiptReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Receipt', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'ReceiptDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa ngoại ID phiếu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'ReceiptID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số lượng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'ReceiptCategory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Diễn giải' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số tiền' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'Money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quan hệ master-detail phiếu chứng từ và chi tiết' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReceiptDetail', @level2type=N'CONSTRAINT',@level2name=N'FK_ReceiptDetail_Receipt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Setting', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Setting', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Setting', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Setting', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'ShopID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã cửa hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'ShopCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên cửa hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'ShopName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Địa chỉ cửa hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số điện thoại cửa hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'PhoneNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shop', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'StaffID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã nhân viên' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'StaffCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên nhân viên' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'StaffName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày sinh' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'Birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Giới tính (1:Nam, 2: Nữ: 3: Khác)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vai trò trong hệ thống' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'RoleType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số CMT/Hộ chiếu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'IdentityNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày cấp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'DateOfIssued'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nơi cấp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'PlaceOfIssued'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Staff', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'StoreID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã cửa hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'ShopID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã mặt hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'SKUCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên cửa hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'ItemName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Địa chỉ cửa hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ghi chú' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'ItemGroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'SupplierID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên nhà cung cấp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'SupplierName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Địa chỉ nhà cung cấp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'SupplierAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số điện thoại' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'SupplierPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Khóa chính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Unit', @level2type=N'COLUMN',@level2name=N'UnitID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên đơn vị tính' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Unit', @level2type=N'COLUMN',@level2name=N'UnitName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mô tả' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Unit', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Trạng thái' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Unit', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Unit', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Unit', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Unit', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Unit', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WorkDay', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WorkDay', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WorkDay', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Người chỉnh sửa cuối' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WorkDay', @level2type=N'COLUMN',@level2name=N'ModifiedBy'
GO
USE [master]
GO
ALTER DATABASE [MShopKeeper] SET  READ_WRITE 
GO
