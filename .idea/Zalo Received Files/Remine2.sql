USE [master]
GO
/****** Object:  Database [building_management27]    Script Date: 06/06/2025 12:27:59 CH ******/
CREATE DATABASE [building_management27]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'building_management27', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\building_management27.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'building_management27_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\building_management27_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [building_management27] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [building_management27].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [building_management27] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [building_management27] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [building_management27] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [building_management27] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [building_management27] SET ARITHABORT OFF 
GO
ALTER DATABASE [building_management27] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [building_management27] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [building_management27] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [building_management27] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [building_management27] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [building_management27] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [building_management27] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [building_management27] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [building_management27] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [building_management27] SET  ENABLE_BROKER 
GO
ALTER DATABASE [building_management27] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [building_management27] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [building_management27] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [building_management27] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [building_management27] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [building_management27] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [building_management27] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [building_management27] SET RECOVERY FULL 
GO
ALTER DATABASE [building_management27] SET  MULTI_USER 
GO
ALTER DATABASE [building_management27] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [building_management27] SET DB_CHAINING OFF 
GO
ALTER DATABASE [building_management27] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [building_management27] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [building_management27] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [building_management27] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'building_management27', N'ON'
GO
ALTER DATABASE [building_management27] SET QUERY_STORE = ON
GO
ALTER DATABASE [building_management27] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [building_management27]
GO
/****** Object:  Table [dbo].[Amenities]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Amenities](
	[AmenityId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AmenityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assignments]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignments](
	[AssignmentId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RoomId] [int] NULL,
	[RoleNote] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AssignmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[CustomerID] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK__Contract__C90D346956915299] PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Buildings]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buildings](
	[BuildingId] [int] IDENTITY(1,1) NOT NULL,
	[BuildingName] [nvarchar](100) NULL,
	[Address] [nvarchar](200) NULL,
	[Description] [nvarchar](255) NULL,
	[Location] [nvarchar](50) NULL,
	[phone_number] [varchar](50) NULL,
	[check_in_time] [time](7) NULL,
	[check_out_time] [time](7) NULL,
	[reception_247] [bit] NULL,
	[languages_supported] [nvarchar](200) NULL,
 CONSTRAINT [PK__Building__5463CDC496130966] PRIMARY KEY CLUSTERED 
(
	[BuildingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[Gender] [nvarchar](10) NULL,
	[DateOfBirth] [date] NULL,
	[Status] [nvarchar](50) NULL,
	[AvatarUrl] [nvarchar](max) NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastLogin] [datetime] NULL,
	[IdentityNumber] [varchar](50) NULL,
	[JoinDate] [date] NULL,
 CONSTRAINT [PK__Customer__A4AE64B89C9EFFB0] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerVouchers]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerVouchers](
	[CustomerVoucherId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[VoucherId] [int] NOT NULL,
	[IsUsed] [bit] NOT NULL,
	[AssignedDate] [datetime] NULL,
	[UsedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerVoucherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NOT NULL,
	[InvoiceDate] [datetime] NULL,
	[RoomTotal] [decimal](18, 2) NOT NULL,
	[ServiceTotal] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LaundryItems]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LaundryItems](
	[LaundryItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ItemName] [nvarchar](100) NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [decimal](10, 2) NULL,
	[TotalPrice]  AS ([Quantity]*[UnitPrice]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[LaundryItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Summary] [nvarchar](500) NULL,
	[Content] [nvarchar](max) NOT NULL,
	[ImageURL] [nvarchar](255) NULL,
	[DatePosted] [datetime] NULL,
	[IsPublished] [bit] NULL,
	[UserId] [int] NULL,
	[BuildingId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[NewsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[SenderUserID] [int] NULL,
	[SenderCustomerID] [int] NULL,
	[Message] [nvarchar](max) NOT NULL,
	[SentAt] [datetime] NULL,
	[ReceiverRole] [nvarchar](50) NULL,
	[IsBroadcast] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationStatus]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationStatus](
	[NotificationID] [int] NOT NULL,
	[ReceiverType] [nvarchar](10) NOT NULL,
	[ReceiverID] [int] NOT NULL,
	[IsRead] [bit] NULL,
	[ReadAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC,
	[ReceiverType] ASC,
	[ReceiverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[RoomId] [int] NOT NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[PaymentMethod] [varchar](50) NOT NULL,
	[PaymentStatus] [varchar](20) NULL,
	[PaymentDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Roles__8AFACE1A5E614135] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomAmenities]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomAmenities](
	[RoomId] [int] NOT NULL,
	[AmenityId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC,
	[AmenityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomReviews]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomReviews](
	[ReviewId] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Rating] [int] NULL,
	[Comment] [nvarchar](1000) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[FloorNumber] [int] NULL,
	[RoomNumber] [nvarchar](20) NULL,
	[RoomType] [nvarchar](50) NULL,
	[Price] [bigint] NULL,
	[MaxOccupancy] [int] NULL,
	[Description] [nvarchar](500) NULL,
	[ImageUrl] [nvarchar](500) NULL,
	[Status] [nvarchar](50) NULL,
	[BuildingId] [int] NULL,
 CONSTRAINT [PK__Rooms__328639396908BCE4] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceOrders]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceOrders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[ServiceId] [int] NULL,
	[UserId] [int] NULL,
	[OrderDate] [datetime] NULL,
	[Status] [varchar](50) NULL,
	[Notes] [text] NULL,
	[RoomId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](100) NULL,
	[ServiceType] [varchar](50) NULL,
	[Description] [text] NULL,
	[Price] [decimal](10, 2) NULL,
	[ImageURL] [varchar](255) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupportMessages]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupportMessages](
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[StaffId] [int] NULL,
	[SenderType] [nvarchar](20) NOT NULL,
	[MessageContent] [nvarchar](max) NOT NULL,
	[SentAt] [datetime] NULL,
	[IsRead] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[LastLogin] [datetime] NULL,
	[RoleId] [int] NULL,
	[StatusId] [tinyint] NULL,
	[CreationDate] [datetime] NULL,
	[AvatarUrl] [nvarchar](max) NULL,
	[FullName] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[DateOfBirth] [date] NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[IdentityNumber] [varchar](50) NULL,
	[JoinDate] [date] NULL,
 CONSTRAINT [PK__Users__1788CC4C762157D1] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vouchers]    Script Date: 06/06/2025 12:28:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vouchers](
	[VoucherId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[DiscountPercent] [int] NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[MinOrderAmount] [decimal](10, 2) NULL,
	[Quantity] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[UserId] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[VoucherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Amenities] ON 

INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (1, N'Wifi miễn phí', N'Kết nối internet không dây tốc độ cao')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (2, N'Tivi', N'Tivi màn hình phẳng với các kênh truyền hình cáp')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (3, N'Điều hòa', N'Hệ thống điều hòa nhiệt độ tự động')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (4, N'Mini bar', N'Tủ lạnh nhỏ chứa đồ uống và đồ ăn nhẹ')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (5, N'Dịch vụ phòng 24/7', N'Dịch vụ hỗ trợ và phục vụ khách hàng mọi lúc')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (6, N'Phòng tắm riêng', N'Phòng tắm riêng trong phòng với đầy đủ tiện nghi')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (7, N'Bãi đỗ xe', N'Chỗ đậu xe an toàn và rộng rãi')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (8, N'Hồ bơi', N'Hồ bơi ngoài trời dành cho khách')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (9, N'Phòng tập gym', N'Phòng tập thể dục với trang thiết bị hiện đại')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (10, N'Nhà hàng', N'Nhà hàng phục vụ các món ăn đa dạng và chất lượng')
SET IDENTITY_INSERT [dbo].[Amenities] OFF
GO
SET IDENTITY_INSERT [dbo].[Assignments] ON 

INSERT [dbo].[Assignments] ([AssignmentId], [UserId], [RoomId], [RoleNote]) VALUES (1, 4, 1, N'Nhân viên kỹ thuật')
INSERT [dbo].[Assignments] ([AssignmentId], [UserId], [RoomId], [RoleNote]) VALUES (2, 3, 2, N'Lễ tân trực phòng')
INSERT [dbo].[Assignments] ([AssignmentId], [UserId], [RoomId], [RoleNote]) VALUES (3, 2, 3, N'Quản lý khu vực')
SET IDENTITY_INSERT [dbo].[Assignments] OFF
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (1, 1, NULL, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'1')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (2, 2, NULL, CAST(N'2024-02-01' AS Date), CAST(N'2025-01-31' AS Date), N'2')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (3, 3, NULL, CAST(N'2024-06-01' AS Date), CAST(N'2024-06-04' AS Date), N'3')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (4, 4, NULL, CAST(N'2024-06-02' AS Date), CAST(N'2024-06-05' AS Date), N'1')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (5, 5, NULL, CAST(N'2024-06-03' AS Date), CAST(N'2024-06-06' AS Date), N'2')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (6, 6, NULL, CAST(N'2024-06-04' AS Date), CAST(N'2024-06-07' AS Date), N'3')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (7, 7, NULL, CAST(N'2024-06-05' AS Date), CAST(N'2024-06-08' AS Date), N'4')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (8, 8, NULL, CAST(N'2024-06-06' AS Date), CAST(N'2024-06-09' AS Date), N'4')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (9, 9, NULL, CAST(N'2024-06-07' AS Date), CAST(N'2024-06-10' AS Date), N'4')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (10, 10, NULL, CAST(N'2024-06-08' AS Date), CAST(N'2024-06-11' AS Date), N'3')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (11, 3, NULL, CAST(N'2024-06-01' AS Date), CAST(N'2024-06-04' AS Date), N'2')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (12, 4, NULL, CAST(N'2024-06-02' AS Date), CAST(N'2024-06-05' AS Date), N'1')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (13, 5, NULL, CAST(N'2024-06-03' AS Date), CAST(N'2024-06-06' AS Date), N'2')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (14, 6, NULL, CAST(N'2024-06-04' AS Date), CAST(N'2024-06-07' AS Date), N'3')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (15, 7, NULL, CAST(N'2024-06-05' AS Date), CAST(N'2024-06-08' AS Date), N'4')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (16, 8, NULL, CAST(N'2024-06-06' AS Date), CAST(N'2024-06-09' AS Date), N'5')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (17, 9, NULL, CAST(N'2024-06-07' AS Date), CAST(N'2024-06-10' AS Date), N'1')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (18, 10, NULL, CAST(N'2024-06-08' AS Date), CAST(N'2024-06-11' AS Date), N'2')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (19, 3, NULL, CAST(N'2024-06-01' AS Date), CAST(N'2024-06-04' AS Date), N'3')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (20, 4, NULL, CAST(N'2024-06-02' AS Date), CAST(N'2024-06-05' AS Date), N'4')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (21, 5, NULL, CAST(N'2024-06-03' AS Date), CAST(N'2024-06-06' AS Date), N'5')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (22, 6, NULL, CAST(N'2024-06-04' AS Date), CAST(N'2024-06-07' AS Date), N'6')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (23, 7, NULL, CAST(N'2024-06-05' AS Date), CAST(N'2024-06-08' AS Date), N'7')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (24, 8, NULL, CAST(N'2024-06-06' AS Date), CAST(N'2024-06-09' AS Date), N'7')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (25, 9, NULL, CAST(N'2024-06-07' AS Date), CAST(N'2024-06-10' AS Date), N'6')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (26, 10, NULL, CAST(N'2024-06-08' AS Date), CAST(N'2024-06-11' AS Date), N'8')
SET IDENTITY_INSERT [dbo].[Bookings] OFF
GO
SET IDENTITY_INSERT [dbo].[Buildings] ON 

INSERT [dbo].[Buildings] ([BuildingId], [BuildingName], [Address], [Description], [Location], [phone_number], [check_in_time], [check_out_time], [reception_247], [languages_supported]) VALUES (1, N'Tòa nhà A', N'123 Nguyễn Văn Cừ, Phường An Khánh, Ninh Kiều, Cần Thơ,Việt Nam ', N'Tòa nhà trung tâm', N'Cần Thơ ', N'0346141483', CAST(N'02:00:00' AS Time), CAST(N'12:00:00' AS Time), 1, N'Ngôn Ngữ Hỗ Trợ : Tiếng Việt, Tiếng Anh, Tiếng Nhật ')
INSERT [dbo].[Buildings] ([BuildingId], [BuildingName], [Address], [Description], [Location], [phone_number], [check_in_time], [check_out_time], [reception_247], [languages_supported]) VALUES (2, N'Tòa nhà B', N' Số 47 Thùy Vân, Phường 2, Thành phố Vũng Tàu, Bà Rịa - Vũng Tàu, Việt Nam', N'Tòa nhà van phòng', N'Vũng Tàu ', N'0346141483', CAST(N'02:00:00' AS Time), CAST(N'12:00:00' AS Time), 1, N'Ngôn Ngữ Hỗ Trợ : Tiếng Việt, Tiếng Anh, Tiếng Nhật ')
SET IDENTITY_INSERT [dbo].[Buildings] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (1, N'customer', N'c4ca4238a0b923820dcc509a6f75849b', N'JoinCena', N'0346141483', N'customer@example.com', NULL, N'Nam', CAST(N'2004-12-20' AS Date), N'1', N'images/face.jpg', CAST(N'2025-01-05T00:00:00.000' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 

INSERT [dbo].[Payments] ([PaymentId], [OrderId], [RoomId], [Amount], [PaymentMethod], [PaymentStatus], [PaymentDate]) VALUES (1, 1, 1, CAST(550000.00 AS Decimal(10, 2)), N'Credit Card', N'Completed', CAST(N'2025-04-30T12:09:33.153' AS DateTime))
INSERT [dbo].[Payments] ([PaymentId], [OrderId], [RoomId], [Amount], [PaymentMethod], [PaymentStatus], [PaymentDate]) VALUES (2, 2, 2, CAST(550000.00 AS Decimal(10, 2)), N'Cash', N'Completed', CAST(N'2025-04-30T12:09:33.153' AS DateTime))
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (1, N'Quản trị viên')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (2, N'Quản lý')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (3, N'Lễ tân')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (4, N'Nhân viên Kỹ Thuật ')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (5, N'Nhân viên Lao Công')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Rooms] ON 

INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (1, 1, N'101', N'Phòng đơn', 500000, 1, N'Rộng rãi', N'images/phongdon.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (2, 1, N'102', N'Phòng đôi', 700000, 2, N'Thoáng mát', N'images/phongdoi.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (3, 1, N'103', N'Phòng đôi', 700000, 2, N'Sang trọng', N'images/phongdoi1.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (4, 1, N'104', N'Phòng 5 người', 1500000, 5, N'Quý phái', N'images/phong5nguoi.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (5, 1, N'105', N'Phòng đơn', 500000, 1, N'Rộng rãi', N'images/phongdon1.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (6, 1, N'106', N'Phòng đôi', 800000, 2, N'Thoáng mát', N'images/phongdoi2.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (7, 1, N'107', N'Phòng 4 người', 1200000, 4, N'Sạch sẽ', N'images/phong4nguoi.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (8, 1, N'108', N'Phòng 5 người', 1500000, 5, N'Thoải mái', N'images/phong5nguoi1.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (9, 1, N'109', N'Phòng đơn', 500000, 1, N'Sang trọng', N'images/phongdon3.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (10, 2, N'200', N'Phòng đôi', 800000, 2, N'Thoáng mát', N'images/phongdoi3.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (11, 2, N'201', N'Phòng đơn', 500000, 1, N'Sạch sẽ', N'images/phongdon2.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (12, 2, N'202', N'Phòng đôi', 800000, 2, N'Rộng rãi', N'images/phongdoi4.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (13, 2, N'203', N'Phòng 4 người', 1200000, 4, N'Sang trọng', N'images/phong4nguoi1.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (14, 2, N'204', N'Phòng 5 người', 1500000, 5, N'Êm ái', N'images/phong5nguoi2.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (15, 2, N'205', N'Phòng đơn', 500000, 1, N'Rộng rãi', N'images/phongdon4.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (16, 2, N'206', N'Phòng đôi', 800000, 2, N'Thoáng mát', N'images/phongdoi5.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (17, 2, N'207', N'Phòng 4 người', 1200000, 4, N'Thoáng mát', N'images/phong4nguoi2.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (18, 2, N'208', N'Phòng đơn', 500000, 2, N'Sang trọng', N'images/phongdon5.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (19, 2, N'209', N'Phòng 5 người', 1500000, 5, N'Rộng rãi', N'images/phong5nguoi3.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (20, 3, N'300', N'Phòng đôi', 800000, 2, N'Sạch sẽ', N'images/phongdoi6.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (21, 3, N'301', N'Phòng 4 người', 1200000, 4, N'Thoải mái', N'images/phong4nguoi3.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (22, 3, N'302', N'Phòng 5 người', 1500000, 5, N'Thoáng mát', N'images/phong5nguoi4.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (23, 3, N'303', N'Phòng đơn', 500000, 1, N'Thoải mái', N'images/phongdon6.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (24, 3, N'304', N'Phòng đôi', 800000, 2, N'Sang trọng', N'images/phongdoi7.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (25, 3, N'305', N'Phòng 4 người', 1200000, 4, N'Sạch sẽ', N'images/phong4nguoi4.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (26, 3, N'306', N'Phòng đơn', 500000, 2, N'Rộng rãi', N'images/phongdon7.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (27, 3, N'307', N'Phòng đôi', 800000, 2, N'Rộng rãi', N'images/phongdoi8.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (28, 3, N'308', N'Phòng 4 người', 1200000, 4, N'Thoáng mát', N'images/phong4nguoi5.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (29, 3, N'309', N'Phòng 5 người', 1500000, 5, N'Sang trọng', N'images/phong5nguoi5.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (30, 4, N'400', N'Phòng đôi', 800000, 2, N'Quý phái', N'images/phongdoi9.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (31, 4, N'401', N'Phòng đơn', 500000, 1, N'Êm ái', N'images/phongdon8.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (32, 4, N'402', N'Phòng 4 người', 1200000, 4, N'Rộng rãi', N'images/phong4nguoi6.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (33, 4, N'403', N'Phòng đôi', 800000, 2, N'Sạch sẽ', N'images/phongdoi10.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (34, 4, N'404', N'Phòng 5 người', 1500000, 5, N'Thoải mái', N'images/phong5nguoi6.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (35, 4, N'405', N'Phòng đơn', 500000, 1, N'Thoáng mát', N'images/phongdon9.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (36, 4, N'406', N'Phòng 4 người', 1200000, 4, N'Sang trọng', N'images/phong4nguoi7.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (37, 4, N'407', N'Phòng 5 người', 1500000, 5, N'Sạch sẽ', N'images/phong5nguoi7.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (38, 4, N'408', N'Phòng đơn', 500000, 1, N'Rộng rãi', N'images/phongdon10.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (39, 4, N'409', N'Phòng đôi', 800000, 2, N'Êm ái', N'images/phongdoi11.jpg', NULL, 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (40, 5, N'101', N'Phòng 4 người', 1200000, 4, N'Êm ái', N'images/phong4nguoi8.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (41, 5, N'102', N'Phòng don', 500000, 1, N'Thoáng mát', N'images/phongdon11.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (42, 5, N'103', N'Phòng don', 500000, 1, N'Thoáng mát', N'images/phongdon12.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (43, 5, N'104', N'Phòng đôi', 700000, 2, N'Sạch sẽ', N'images/phongdoi12.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (44, 5, N'105', N'Phòng đôi', 700000, 2, N'Sạch sẽ', N'images/phongdoi13.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (45, 5, N'106', N'Phòng cao cấp', 1200000, 3, N'Sang trọng', N'images/phongcaocap.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (46, 5, N'107', N'Phòng cao cấp', 1200000, 3, N'Rộng rãi', N'images/phongcaocap1.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (47, 5, N'108', N'Phòng don', 520000, 1, N'Quý phái', N'images/phongdon13.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (48, 5, N'109', N'Phòng don', 520000, 1, N'Sang trọng', N'images/phongdon14.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (49, 6, N'200', N'Phòng đôi', 730000, 2, N'Sang trọng', N'images/phongdoi14.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (50, 6, N'201', N'Phòng đôi', 730000, 2, N'Sang trọng', N'images/phongdoi15.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (51, 6, N'202', N'Phòng cao cấp', 1250000, 3, N'Rộng rãi', N'images/phongcaocap2.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (52, 6, N'203', N'Phòng cao cấp', 1250000, 3, N'Thoáng mát', N'images/phongcaocap3.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (53, 6, N'204', N'Phòng đơn', 540000, 1, N'Sang trọng', N'images/phongdon15.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (54, 6, N'205', N'Phòng đơn', 540000, 1, N'Sạch sẽ', N'images/phongdon16.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (55, 6, N'206', N'Phòng đôi', 750000, 2, N'Êm ái', N'images/phongdoi16.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (56, 6, N'207', N'Phòng đôi', 750000, 2, N'Thoải mái', N'images/phongdoi17.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (57, 6, N'208', N'Phòng cao cấp', 1300000, 3, N'Quý phái', N'images/phongcaocap4.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (58, 6, N'209', N'Phòng cao cấp', 1300000, 3, N'Rộng rãi', N'images/phongcaocap5.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (59, 7, N'300', N'Phòng đơn', 560000, 1, N'Thoáng mát', N'images/phongdon17.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (60, 7, N'301', N'Phòng đơn', 560000, 1, N'Sang trọng', N'images/phongdon18.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (61, 7, N'302', N'Phòng đôi', 770000, 2, N'Sạch sẽ', N'images/phongdoi18.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (62, 7, N'303', N'Phòng đôi', 770000, 2, N'Êm ái', N'images/phongdoi19.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (63, 7, N'304', N'Phòng cao cấp', 1350000, 3, N'Thoải mái', N'images/phongcaocap6.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (64, 7, N'305', N'Phòng cao cấp', 1350000, 3, N'Quý phái', N'images/phongcaocap7.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (65, 7, N'306', N'Phòng đơn', 580000, 1, N'Rộng rãi', N'images/phongdon19.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (66, 7, N'307', N'Phòng đơn', 580000, 1, N'Thoáng mát', N'images/phongdon20.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (67, 7, N'308', N'Phòng đôi', 790000, 2, N'Sang trọng', N'images/phongdoi20.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (68, 7, N'309', N'Phòng đôi', 790000, 2, N'Sạch sẽ', N'images/phongdoi21.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (69, 8, N'400', N'Phòng cao cấp', 1400000, 3, N'Thoải mái', N'images/phongcaocap8.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (70, 8, N'401', N'Phòng cao cấp', 1400000, 3, N'Quý phái', N'images/phongcaocap9.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (71, 8, N'402', N'Phòng Suite', 1800000, 4, N'Rộng rãi', N'images/phongsuite.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (72, 8, N'403', N'Phòng Suite', 1850000, 4, N'Thoáng mát', N'images/phongsuite1.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (73, 8, N'404', N'Phòng Suite', 1900000, 4, N'Sang trọng', N'images/phongsuite2.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (74, 8, N'405', N'Phòng Suite', 1950000, 4, N'Sạch sẽ', N'images/phongsuite3.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (75, 8, N'406', N'Phòng Suite', 2000000, 4, N'Thoải mái', N'images/phongsuite4.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (76, 8, N'407', N'Phòng đơn', 500000, 1, N'Quý phái', N'images/phongdon21.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (77, 8, N'408', N'Phòng đơn', 520000, 1, N'Rộng rãi', N'images/phongdon22.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (78, 8, N'409', N'Phòng đôi', 750000, 2, N'Thoáng mát', N'images/phongdoi22.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (79, 9, N'500', N'Phòng đôi', 770000, 2, N'Sang trọng', N'images/phongdoi23.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (80, 9, N'501', N'Phòng cao cấp', 1400000, 3, N'Sạch sẽ', N'images/phongcaocap10.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (81, 9, N'502', N'Phòng đơn', 510000, 1, N'Thoải mái', N'images/phongdon23.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (82, 9, N'503', N'Phòng đơn', 530000, 1, N'Quý phái', N'images/phongdon24.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (83, 9, N'504', N'Phòng đôi', 760000, 2, N'Êm ái', N'images/phongdoi24.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (84, 9, N'505', N'Phòng đôi', 780000, 2, N'Êm ái', N'images/phongdoi25.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (85, 5, N'506', N'Phòng cao cấp', 1420000, 3, N'Quý phái', N'images/phongcaocap11.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (86, 5, N'507', N'Phòng đôi', 700000, 2, N'Sạch sẽ', N'images/phongdoi26.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (87, 9, N'508', N'Phòng cao cấp', 1250000, 3, N'Sang trọng', N'images/phongcaocap12.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (88, 9, N'509', N'Phòng Suite', 1900000, 4, N'Thoáng mát', N'images/phongsuite5.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (89, 10, N'600', N'Phòng đơn', 560000, 1, N'Rộng rãi', N'images/phongdon25.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (90, 10, N'601', N'Phòng đôi', 800000, 2, N'Quý phái', N'images/phongdoi27.jpg', NULL, 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (92, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
SET IDENTITY_INSERT [dbo].[Rooms] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (1, N'admin01', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 1, 1, CAST(N'2025-01-01T00:00:00.000' AS DateTime), N'images/face.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (2, N'manager01', N'E10ADC3949BA59ABBE56E057F20F883EE10ADC3949BA59ABBE56E057F20F883E', NULL, 2, 1, CAST(N'2025-01-02T00:00:00.000' AS DateTime), N'images/face.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (3, N'reception01', N'E10ADC3949BA59ABBE56E057F20F883E', NULL, 3, 1, CAST(N'2025-01-03T00:00:00.000' AS DateTime), N'images/face.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (4, N'staff01', N'E10ADC3949BA59ABBE56E057F20F883E', NULL, 4, 1, CAST(N'2025-01-04T00:00:00.000' AS DateTime), N'images/face.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (5, N'customer', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 3, 1, CAST(N'2025-01-05T00:00:00.000' AS DateTime), N'images/face.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (6, N'thanhnguyen', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-06T00:00:00.000' AS DateTime), N'images/face.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (7, N'hoaanh', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 3, 1, CAST(N'2025-01-07T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (8, N'minhtrung', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-08T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (9, N'lethao', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 3, 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (10, N'phuctran', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-10T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (11, N'kimanh', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-11T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (12, N'ngocdung', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-12T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (13, N'cuongle', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-13T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (14, N'lanpham', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-14T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (15, N'ducthang', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-15T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (16, N'tuyetmai', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-16T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (17, N'anhkhoa', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 2, 1, CAST(N'2025-01-17T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (18, N'thanhha', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-18T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (19, N'vuthao', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-19T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (20, N'namnguyen', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-20T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (21, N'duongngan', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-21T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (22, N'sonle', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-22T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (23, N'tuananh', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 4, 1, CAST(N'2025-01-23T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (24, N'hoangyen', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-01-24T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (25, N'manhhung', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-01-25T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (26, N'nhungcao', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-01-26T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (27, N'khanhlinh', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-01-27T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (28, N'trungkien', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-01-28T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (29, N'haianh', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-01-29T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (30, N'leminhchau', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-01-30T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (31, N'quanghuy', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-01-31T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (32, N'tienthanh', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-02-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (33, N'bichtram', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-02-02T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (34, N'xuanbao', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 3, 1, CAST(N'2025-02-03T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [StatusId], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (35, N'ngocthao', N'c4ca4238a0b923820dcc509a6f75849b', NULL, 5, 1, CAST(N'2025-02-04T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__C9F284564BDA72F0]    Script Date: 06/06/2025 12:28:00 CH ******/
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [UQ__Customer__C9F284564BDA72F0] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E44675469E]    Script Date: 06/06/2025 12:28:00 CH ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ__Users__536C85E44675469E] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Vouchers__A25C5AA748997FC8]    Script Date: 06/06/2025 12:28:00 CH ******/
ALTER TABLE [dbo].[Vouchers] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF__Customers__Statu__0D7A0286]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF__Customers__Creat__0E6E26BF]  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[CustomerVouchers] ADD  DEFAULT ((0)) FOR [IsUsed]
GO
ALTER TABLE [dbo].[CustomerVouchers] ADD  DEFAULT (getdate()) FOR [AssignedDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [InvoiceDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [ServiceTotal]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [TotalAmount]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[News] ADD  DEFAULT (getdate()) FOR [DatePosted]
GO
ALTER TABLE [dbo].[News] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [SentAt]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [IsBroadcast]
GO
ALTER TABLE [dbo].[NotificationStatus] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT ('Pending') FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[RoomReviews] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ServiceOrders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[SupportMessages] ADD  DEFAULT (getdate()) FOR [SentAt]
GO
ALTER TABLE [dbo].[SupportMessages] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__StatusId__4D5F7D71]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Vouchers] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [FK__Assignmen__RoomI__4BAC3F29] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [FK__Assignmen__RoomI__4BAC3F29]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [FK__Assignmen__UserI__4AB81AF0] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [FK__Assignmen__UserI__4AB81AF0]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Booking_Customers]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Rooms] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Booking_Rooms]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Users] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Booking_Users]
GO
ALTER TABLE [dbo].[CustomerVouchers]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerVouchers]  WITH CHECK ADD FOREIGN KEY([VoucherId])
REFERENCES [dbo].[Vouchers] ([VoucherId])
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD FOREIGN KEY([BookingId])
REFERENCES [dbo].[Bookings] ([BookingId])
GO
ALTER TABLE [dbo].[LaundryItems]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[ServiceOrders] ([OrderId])
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK__News__BuildingID__236943A5] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Buildings] ([BuildingId])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK__News__BuildingID__236943A5]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK__News__UserId__245D67DE] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK__News__UserId__245D67DE]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_SenderCustomer] FOREIGN KEY([SenderCustomerID])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_SenderCustomer]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_SenderUser] FOREIGN KEY([SenderUserID])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_SenderUser]
GO
ALTER TABLE [dbo].[NotificationStatus]  WITH CHECK ADD FOREIGN KEY([NotificationID])
REFERENCES [dbo].[Notifications] ([NotificationID])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK__Payments__RoomId__498EEC8D] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK__Payments__RoomId__498EEC8D]
GO
ALTER TABLE [dbo].[RoomAmenities]  WITH CHECK ADD FOREIGN KEY([AmenityId])
REFERENCES [dbo].[Amenities] ([AmenityId])
GO
ALTER TABLE [dbo].[RoomAmenities]  WITH CHECK ADD FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[RoomReviews]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[RoomReviews]  WITH CHECK ADD FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[Rooms]  WITH CHECK ADD  CONSTRAINT [FK_Rooms_Buildings] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Buildings] ([BuildingId])
GO
ALTER TABLE [dbo].[Rooms] CHECK CONSTRAINT [FK_Rooms_Buildings]
GO
ALTER TABLE [dbo].[ServiceOrders]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[ServiceOrders]  WITH CHECK ADD FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Services] ([ServiceId])
GO
ALTER TABLE [dbo].[ServiceOrders]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ServiceOrders]  WITH CHECK ADD  CONSTRAINT [FK_ServiceOrders_Rooms] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[ServiceOrders] CHECK CONSTRAINT [FK_ServiceOrders_Rooms]
GO
ALTER TABLE [dbo].[SupportMessages]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[SupportMessages]  WITH CHECK ADD FOREIGN KEY([StaffId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
ALTER TABLE [dbo].[RoomReviews]  WITH CHECK ADD CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [building_management27] SET  READ_WRITE 
GO
