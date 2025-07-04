USE [master]
GO
/****** Object:  Database [building_management27]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[Amenities]    Script Date: 6/16/2025 10:42:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Amenities](
	[AmenityId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK__Amenitie__842AF52BFD7A5843] PRIMARY KEY CLUSTERED 
(
	[AmenityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assignments]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[Bookings]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[Buildings]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[CustomerVouchers]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[Invoices]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[LaundryItems]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[News]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[Notifications]    Script Date: 6/16/2025 10:42:55 PM ******/
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
/****** Object:  Table [dbo].[NotificationStatus]    Script Date: 6/16/2025 10:42:56 PM ******/
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
/****** Object:  Table [dbo].[Payments]    Script Date: 6/16/2025 10:42:56 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 6/16/2025 10:42:56 PM ******/
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
/****** Object:  Table [dbo].[RoomAmenities]    Script Date: 6/16/2025 10:42:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomAmenities](
	[RoomId] [int] NOT NULL,
	[AmenityId] [int] NOT NULL,
 CONSTRAINT [PK__RoomAmen__9AC4964B67360EE7] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC,
	[AmenityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomReviews]    Script Date: 6/16/2025 10:42:56 PM ******/
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
/****** Object:  Table [dbo].[Rooms]    Script Date: 6/16/2025 10:42:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[FloorNumber] [int] NULL,
	[RoomNumber] [nvarchar](20) NULL,
	[RoomType] [nvarchar](50) NULL,
	[BedType] [nvarchar](50) NULL,
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
/****** Object:  Table [dbo].[ServiceOrders]    Script Date: 6/16/2025 10:42:56 PM ******/
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
/****** Object:  Table [dbo].[Services]    Script Date: 6/16/2025 10:42:56 PM ******/
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
/****** Object:  Table [dbo].[SupportMessages]    Script Date: 6/16/2025 10:42:56 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 6/16/2025 10:42:56 PM ******/
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
	[Status] [nvarchar](50) NULL,
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
/****** Object:  Table [dbo].[Vouchers]    Script Date: 6/16/2025 10:42:56 PM ******/
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

INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (1, N'Free Wi-Fi', N'Unlimited high-speed wireless internet access')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (2, N'Flat Screen TV', N'Enjoy entertainment with a modern flat-screen television')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (3, N'Air Conditioning', N'Room equipped with individual air conditioning control')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (4, N'Coffee Maker', N'In-room coffee maker for your convenience')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (5, N'Private Bathroom', N'En-suite bathroom with full amenities')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (6, N'Room Service', N'Order food and beverages to your room at any time')
INSERT [dbo].[Amenities] ([AmenityId], [Name], [Description]) VALUES (7, N'Safe Box', N'Secure safe to store your personal belongings')
SET IDENTITY_INSERT [dbo].[Amenities] OFF
GO
SET IDENTITY_INSERT [dbo].[Assignments] ON 

INSERT [dbo].[Assignments] ([AssignmentId], [UserId], [RoomId], [RoleNote]) VALUES (2, 3, 2, N'staff')
INSERT [dbo].[Assignments] ([AssignmentId], [UserId], [RoomId], [RoleNote]) VALUES (3, 2, 3, N'staff')
SET IDENTITY_INSERT [dbo].[Assignments] OFF
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (1, 1, NULL, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (2, 2, NULL, CAST(N'2024-02-01' AS Date), CAST(N'2025-01-31' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (3, 3, NULL, CAST(N'2024-06-01' AS Date), CAST(N'2024-06-04' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (4, 4, NULL, CAST(N'2024-06-02' AS Date), CAST(N'2024-06-05' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (5, 5, NULL, CAST(N'2024-06-03' AS Date), CAST(N'2024-06-06' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (6, 6, NULL, CAST(N'2024-06-04' AS Date), CAST(N'2024-06-07' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (7, 7, NULL, CAST(N'2024-06-05' AS Date), CAST(N'2024-06-08' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (8, 8, NULL, CAST(N'2024-06-06' AS Date), CAST(N'2024-06-09' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (9, 9, NULL, CAST(N'2024-06-07' AS Date), CAST(N'2024-06-10' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (10, 10, NULL, CAST(N'2024-06-08' AS Date), CAST(N'2024-06-11' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (11, 3, NULL, CAST(N'2024-06-01' AS Date), CAST(N'2024-06-04' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (12, 4, NULL, CAST(N'2024-06-02' AS Date), CAST(N'2024-06-05' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (13, 5, NULL, CAST(N'2024-06-03' AS Date), CAST(N'2024-06-06' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (14, 6, NULL, CAST(N'2024-06-04' AS Date), CAST(N'2024-06-07' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (15, 7, NULL, CAST(N'2024-06-05' AS Date), CAST(N'2024-06-08' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (16, 8, NULL, CAST(N'2024-06-06' AS Date), CAST(N'2024-06-09' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (17, 9, NULL, CAST(N'2024-06-07' AS Date), CAST(N'2024-06-10' AS Date), N'Checked in')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (18, 10, NULL, CAST(N'2024-06-08' AS Date), CAST(N'2024-06-11' AS Date), N'Confirmed')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (19, 3, NULL, CAST(N'2024-06-01' AS Date), CAST(N'2024-06-04' AS Date), N'Confirmed')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (20, 4, NULL, CAST(N'2024-06-02' AS Date), CAST(N'2024-06-05' AS Date), N'Confirmed')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (21, 5, NULL, CAST(N'2024-06-03' AS Date), CAST(N'2024-06-06' AS Date), N'Confirmed')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (22, 6, NULL, CAST(N'2024-06-04' AS Date), CAST(N'2024-06-07' AS Date), N'Confirmed')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (23, 7, NULL, CAST(N'2024-06-05' AS Date), CAST(N'2024-06-08' AS Date), N'Confirmed')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (24, 8, NULL, CAST(N'2024-06-06' AS Date), CAST(N'2024-06-09' AS Date), N'Waiting for processing')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (25, 9, NULL, CAST(N'2024-06-07' AS Date), CAST(N'2024-06-10' AS Date), N'Chờ xử lý')
INSERT [dbo].[Bookings] ([BookingId], [RoomId], [CustomerID], [StartDate], [EndDate], [Status]) VALUES (26, 10, NULL, CAST(N'2024-06-08' AS Date), CAST(N'2024-06-11' AS Date), N'Waiting for processing')
SET IDENTITY_INSERT [dbo].[Bookings] OFF
GO
SET IDENTITY_INSERT [dbo].[Buildings] ON 

INSERT [dbo].[Buildings] ([BuildingId], [BuildingName], [Address], [Description], [Location], [phone_number], [check_in_time], [check_out_time], [reception_247], [languages_supported]) VALUES (1, N'Building A', N'123 Nguyen Van Cu, An Khanh Ward, Ninh Kieu, Can Tho, Vietnam', N'Central building', N'Can Tho', N'0346141483', CAST(N'02:00:00' AS Time), CAST(N'12:00:00' AS Time), 1, N'Supported Languages: Vietnamese, English, Japanese')
INSERT [dbo].[Buildings] ([BuildingId], [BuildingName], [Address], [Description], [Location], [phone_number], [check_in_time], [check_out_time], [reception_247], [languages_supported]) VALUES (2, N'Building B', N'No. 47 Thuy Van, Ward 2, Vung Tau City, Ba Ria - Vung Tau, Vietnam', N'Room valve building', N'Can Tho', N'0346141483', CAST(N'02:00:00' AS Time), CAST(N'12:00:00' AS Time), 1, N'Ngôn Ngữ Hỗ Trợ : Tiếng Việt, Tiếng Anh, Tiếng Nhật ')
SET IDENTITY_INSERT [dbo].[Buildings] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (1, N'customer', N'c4ca4238a0b923820dcc509a6f75849b', N'JoinCena', N'0346141483', N'customer@example.com', N'61 Nguyen Thi Minh Khai, Da Nang', N'Male', CAST(N'2004-12-20' AS Date), N'Active', N'images/Customer1.jpg', CAST(N'2025-01-05T00:00:00.000' AS DateTime), CAST(N'2025-06-30T23:47:47.987' AS DateTime), N'123456789990', NULL)
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (2, N'Customer02', N'c4ca4238a0b923820dcc509a6f75849b', N'Bob Tran', N'0901000002', N'bob02@example.com', N'456 Tran Hung Dao, Hanoi', N'Male', CAST(N'1992-05-15' AS Date), N'Active', N'images/Customer2.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-13T23:47:47.987' AS DateTime), N'123456789002', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (3, N'Customer03', N'c4ca4238a0b923820dcc509a6f75849b', N'Carol Pham', N'0901000003', N'carol03@example.com', N'789 Nguyen Trai, Da Nang', N'Female', CAST(N'1998-07-22' AS Date), N'Active', N'images/Customer3.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-14T23:47:47.987' AS DateTime), N'123456789003', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (4, N'Customer04', N'c4ca4238a0b923820dcc509a6f75849b', N'David Le', N'0901000004', N'david04@example.com', N'12 Ba Trieu, Hue', N'Male', CAST(N'1989-03-30' AS Date), N'Active', N'images/Customer4.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-15T23:47:47.987' AS DateTime), N'123456789004', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (5, N'Customer05', N'c4ca4238a0b923820dcc509a6f75849b', N'Emma Vo', N'0901000005', N'emma05@example.com', N'234 Hai Ba Trung, HCMC', N'Female', CAST(N'1991-12-10' AS Date), N'Active', N'images/Customer5.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-16T23:47:47.987' AS DateTime), N'123456789005', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (6, N'Customer06', N'c4ca4238a0b923820dcc509a6f75849b', N'Frank Bui', N'0901000006', N'frank06@example.com', N'89 Nguyen Hue, Can Tho', N'Male', CAST(N'1988-06-25' AS Date), N'Active', N'images/Customer6.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-17T23:47:47.987' AS DateTime), N'123456789006', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (7, N'Customer07', N'c4ca4238a0b923820dcc509a6f75849b', N'Grace Do', N'0901000007', N'grace07@example.com', N'77 Bach Dang, Da Nang', N'Female', CAST(N'1994-11-13' AS Date), N'Active', N'images/Customer7.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-18T23:47:47.987' AS DateTime), N'123456789007', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (8, N'Customer08', N'c4ca4238a0b923820dcc509a6f75849b', N'Henry Hoang', N'0901000008', N'henry08@example.com', N'33 Ly Thuong Kiet, HCMC', N'Male', CAST(N'1990-09-09' AS Date), N'Active', N'images/Customer8.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-19T23:47:47.987' AS DateTime), N'123456789008', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (9, N'Customer09', N'c4ca4238a0b923820dcc509a6f75849b', N'Ivy Mai', N'0901000009', N'ivy09@example.com', N'66 Phan Chu Trinh, HN', N'Female', CAST(N'1996-08-01' AS Date), N'Active', N'images/Customer9.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-20T23:47:47.987' AS DateTime), N'123456789009', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (10, N'Customer010', N'c4ca4238a0b923820dcc509a6f75849b', N'Jack Nguyen', N'0901000010', N'jack10@example.com', N'55 Dinh Tien Hoang, HCMC', N'Male', CAST(N'1993-10-05' AS Date), N'Active', N'images/Customer10.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-21T23:47:47.987' AS DateTime), N'123456789010', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (11, N'Customer011', N'c4ca4238a0b923820dcc509a6f75849b', N'Kim Tran', N'0901000011', N'kim11@example.com', N'100 Le Van Sy, HCMC', N'Female', CAST(N'1997-02-14' AS Date), N'Active', N'images/Customer11.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-22T23:47:47.987' AS DateTime), N'123456789011', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (12, N'Customer012', N'c4ca4238a0b923820dcc509a6f75849b', N'Leo Ha', N'0901000012', N'leo12@example.com', N'49 Ton Duc Thang, Hue', N'Male', CAST(N'1987-07-17' AS Date), N'Active', N'images/Customer12.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-23T23:47:47.987' AS DateTime), N'123456789012', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (13, N'Customer013', N'c4ca4238a0b923820dcc509a6f75849b', N'Mina Dang', N'0901000013', N'mina13@example.com', N'27 Pasteur, Da Lat', N'Female', CAST(N'1992-03-29' AS Date), N'Active', N'images/Customer13.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-24T23:47:47.987' AS DateTime), N'123456789013', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (14, N'Customer014', N'c4ca4238a0b923820dcc509a6f75849b', N'Nathan Pham', N'0901000014', N'nathan14@example.com', N'120 Nguyen Thai Hoc, Vung Tau', N'Male', CAST(N'1985-11-19' AS Date), N'Active', N'images/Customer14.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-25T23:47:47.987' AS DateTime), N'123456789014', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (15, N'Customer015', N'c4ca4238a0b923820dcc509a6f75849b', N'Olivia Le', N'0901000015', N'olivia15@example.com', N'74 Pham Ngu Lao, Hue', N'Female', CAST(N'1991-01-22' AS Date), N'Active', N'images/Customer15.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-26T23:47:47.987' AS DateTime), N'123456789015', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (16, N'Customer016', N'c4ca4238a0b923820dcc509a6f75849b', N'Paul Vu', N'0901000016', N'paul16@example.com', N'19 Mac Dinh Chi, HCMC', N'Male', CAST(N'1986-06-05' AS Date), N'Active', N'images/Customer16.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-27T23:47:47.987' AS DateTime), N'123456789016', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (17, N'Customer017', N'c4ca4238a0b923820dcc509a6f75849b', N'Quinn Vo', N'0901000017', N'quinn17@example.com', N'88 Tran Quoc Toan, Hanoi', N'Female', CAST(N'1999-09-30' AS Date), N'Active', N'images/Customer17.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-28T23:47:47.987' AS DateTime), N'123456789017', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (18, N'Customer018', N'c4ca4238a0b923820dcc509a6f75849b', N'Ryan Ngo', N'0901000018', N'ryan18@example.com', N'21 Hoang Dieu, HCMC', N'Male', CAST(N'1995-04-08' AS Date), N'Active', N'images/Customer18.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-29T23:47:47.987' AS DateTime), N'123456789018', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (19, N'Customer019', N'c4ca4238a0b923820dcc509a6f75849b', N'Sophie Bui', N'0901000019', N'sophie19@example.com', N'61 Nguyen Thi Minh Khai, Da Nang', N'Female', CAST(N'1993-12-02' AS Date), N'Active', N'images/Customer19.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-06-30T23:47:47.987' AS DateTime), N'123456789019', CAST(N'2025-06-11' AS Date))
INSERT [dbo].[Customers] ([CustomerId], [UserName], [Password], [FullName], [Phone], [Email], [Address], [Gender], [DateOfBirth], [Status], [AvatarUrl], [CreationDate], [LastLogin], [IdentityNumber], [JoinDate]) VALUES (20, N'Customer020', N'c4ca4238a0b923820dcc509a6f75849b', N'Tommy Truong', N'0901000020', N'tommy20@example.com', N'88 Vo Van Tan, Can Tho', N'Male', CAST(N'1990-08-11' AS Date), N'Active', N'images/Customer20.jpg', CAST(N'2025-06-11T23:47:47.987' AS DateTime), CAST(N'2025-07-01T23:47:47.987' AS DateTime), N'123456789020', CAST(N'2025-06-11' AS Date))
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 

INSERT [dbo].[Payments] ([PaymentId], [OrderId], [RoomId], [Amount], [PaymentMethod], [PaymentStatus], [PaymentDate]) VALUES (1, 1, 1, CAST(550000.00 AS Decimal(10, 2)), N'Credit Card', N'Completed', CAST(N'2025-04-30T12:09:33.153' AS DateTime))
INSERT [dbo].[Payments] ([PaymentId], [OrderId], [RoomId], [Amount], [PaymentMethod], [PaymentStatus], [PaymentDate]) VALUES (2, 2, 2, CAST(550000.00 AS Decimal(10, 2)), N'Cash', N'Completed', CAST(N'2025-04-30T12:09:33.153' AS DateTime))
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (1, N'admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (2, N'Receptionist')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (3, N'nhân viên phục vụ')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (1, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (1, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (1, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (1, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (1, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (1, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (1, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (2, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (2, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (2, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (2, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (2, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (2, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (2, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (3, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (3, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (3, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (3, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (3, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (3, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (3, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (4, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (4, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (4, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (4, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (4, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (4, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (4, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (5, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (5, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (5, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (5, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (5, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (5, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (5, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (6, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (6, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (6, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (6, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (6, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (6, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (6, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (7, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (7, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (7, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (7, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (7, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (7, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (7, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (8, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (8, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (8, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (8, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (8, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (8, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (8, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (9, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (9, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (9, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (9, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (9, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (9, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (9, 7)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (10, 1)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (10, 2)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (10, 3)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (10, 4)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (10, 5)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (10, 6)
INSERT [dbo].[RoomAmenities] ([RoomId], [AmenityId]) VALUES (10, 7)
GO
SET IDENTITY_INSERT [dbo].[RoomReviews] ON 

INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (2, 1, 1, 5, N'The room was exceptionally clean and well-organized. I had a wonderful night’s sleep.', CAST(N'2024-01-10T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (3, 1, 2, 4, N'Quiet location and helpful staff. Air conditioning could be improved.', CAST(N'2024-01-11T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (4, 1, 3, 5, N'Fantastic stay! The room exceeded my expectations in every way.', CAST(N'2024-01-12T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (5, 1, 4, 3, N'The mattress was too firm for my liking, but overall okay.', CAST(N'2024-01-13T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (6, 1, 5, 4, N'Great place for the price. Walking distance to main attractions.', CAST(N'2024-01-14T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (7, 2, 6, 5, N'I loved the modern design. Everything felt new and fresh.', CAST(N'2024-02-10T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (8, 2, 7, 4, N'Service was quick and efficient. Room was spotless.', CAST(N'2024-02-11T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (9, 2, 8, 4, N'Decent stay overall. Good for short business trips.', CAST(N'2024-02-12T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (10, 2, 9, 5, N'Amazing view from the window and plenty of natural light.', CAST(N'2024-02-13T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (11, 2, 10, 3, N'The room was smaller than expected, but still comfortable.', CAST(N'2024-02-14T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (12, 3, 11, 4, N'Room smelled a bit odd at first, but got better after airing.', CAST(N'2024-03-10T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (13, 3, 12, 5, N'Absolutely loved it! Would definitely come back.', CAST(N'2024-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (14, 3, 13, 4, N'Hot water was inconsistent, but staff responded quickly.', CAST(N'2024-03-12T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (15, 3, 14, 3, N'Room was a bit noisy due to street traffic.', CAST(N'2024-03-13T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (16, 3, 15, 5, N'Perfect stay. Everything was clean and well maintained.', CAST(N'2024-03-14T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (17, 4, 16, 5, N'The room looked even better than the pictures. Very professional setup.', CAST(N'2024-04-10T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (18, 4, 17, 4, N'Fast check-in, strong wifi, and great value.', CAST(N'2024-04-11T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (19, 4, 18, 3, N'Too far from the elevator, which was a bit inconvenient.', CAST(N'2024-04-12T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (20, 4, 19, 5, N'I liked the working desk. It was perfect for my remote job.', CAST(N'2024-04-13T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (21, 4, 20, 4, N'Breakfast was tasty, and the room was bright and airy.', CAST(N'2024-04-14T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (22, 5, 1, 5, N'Incredible value for money. The small balcony was a pleasant surprise.', CAST(N'2024-05-10T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (23, 5, 2, 4, N'Well equipped room with a spacious bathroom.', CAST(N'2024-05-11T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (24, 5, 3, 4, N'The scent in the room could be fresher, but otherwise excellent.', CAST(N'2024-05-12T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (25, 5, 4, 5, N'Ideal for relaxation. Peaceful atmosphere and nice decor.', CAST(N'2024-05-13T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (26, 5, 5, 3, N'Staff seemed undertrained. Room was fine, though.', CAST(N'2024-05-14T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (34, 1, 5, 4, N'Clean room, friendly staff', CAST(N'2025-06-12T10:47:30.387' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (43, 5, 6, 5, N'Staff seemed undertrained. Room was fine, though.', CAST(N'2025-12-06T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (44, 5, 6, 5, N'The room looked even better than the pictures. Very professional setup.', CAST(N'2025-12-06T00:00:00.000' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (45, 6, 1, 5, N'Room was a bit noisy due to street traffic.', CAST(N'2025-06-12T11:29:04.027' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (46, 6, 1, 5, N'I liked the working desk. It was perfect for my remote job.', CAST(N'2025-06-12T11:30:07.377' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (47, 7, 1, 5, N'I loved the modern design. Everything felt new and fresh.', CAST(N'2025-06-12T12:10:17.893' AS DateTime))
INSERT [dbo].[RoomReviews] ([ReviewId], [RoomId], [CustomerId], [Rating], [Comment], [CreatedAt]) VALUES (48, 3, 1, 5, N'Phòng này sạch sẽ và thoáng mát quá ì i', CAST(N'2025-06-16T21:34:20.573' AS DateTime))
SET IDENTITY_INSERT [dbo].[RoomReviews] OFF
GO
SET IDENTITY_INSERT [dbo].[Rooms] ON 

INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (1, 1, N'101', N'Standard Room', N'Single Bed', 500000, 1, N'Spacious', N'images/phongdon.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (2, 1, N'102', N'Standard Room', N'Twin Beds', 700000, 2, N'Cool', N'images/phongdoi.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (3, 1, N'103', N'Standard Room', N'Twin Beds', 700000, 2, N'Luxurious', N'images/phongdoi1.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (4, 1, N'104', N'Suite Room', N'King Bed', 1500000, 5, N'Noble', N'images/phong5nguoi.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (5, 1, N'105', N'Standard Room', N'Single Bed', 500000, 1, N'Spacious', N'images/phongdon1.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (6, 1, N'106', N'Standard Room', N'Twin Beds', 800000, 2, N'Cool', N'images/phongdoi2.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (7, 1, N'107', N'Queen Bed', N'Queen Bed', 1200000, 4, N'Clean', N'images/phong4nguoi.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (8, 1, N'108', N'Suite Room', N'King Bed', 1500000, 5, N'Comfortable', N'images/phong5nguoi1.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (9, 1, N'109', N'Standard Room', N'Single Bed', 500000, 1, N'Luxurious', N'images/phongdon3.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (10, 2, N'200', N'Standard Room', N'Twin Beds', 800000, 2, N'Cool', N'images/phongdoi3.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (11, 2, N'201', N'Standard Room', N'Single Bed', 500000, 1, N'Clean', N'images/phongdon2.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (12, 2, N'202', N'Standard Room', N'Twin Beds', 800000, 2, N'Spacious', N'images/phongdoi4.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (13, 2, N'203', N'Queen Bed', N'Queen Bed', 1200000, 4, N'Luxurious', N'images/phong4nguoi1.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (14, 2, N'204', N'Suite Room', N'King Bed', 1500000, 5, N'Soft', N'images/phong5nguoi2.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (15, 2, N'205', N'Standard Room', N'Single Bed', 500000, 1, N'Spacious', N'images/phongdon4.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (16, 2, N'206', N'Standard Room', N'Twin Beds', 800000, 2, N'Cool', N'images/phongdoi5.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (17, 2, N'207', N'Queen Bed', N'Queen Bed', 1200000, 4, N'Cool', N'images/phong4nguoi2.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (18, 2, N'208', N'Standard Room', N'Single Bed', 500000, 2, N'Luxurious', N'images/phongdon5.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (19, 2, N'209', N'Suite Room', N'King Bed', 1500000, 5, N'Spacious', N'images/phong5nguoi3.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (20, 3, N'300', N'Standard Room', N'Twin Beds', 800000, 2, N'Clean', N'images/phongdoi6.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (21, 3, N'301', N'Queen Bed', N'Queen Bed', 1200000, 4, N'Comfortable', N'images/phong4nguoi3.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (22, 3, N'302', N'Suite Room', N'King Bed', 1500000, 5, N'Cool', N'images/phong5nguoi4.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (23, 3, N'303', N'Standard Room', N'Single Bed', 500000, 1, N'Comfortable', N'images/phongdon6.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (24, 3, N'304', N'Standard Room', N'Twin Beds', 800000, 2, N'Luxurious', N'images/phongdoi7.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (25, 3, N'305', N'Queen Bed', N'Queen Bed', 1200000, 4, N'Clean', N'images/phong4nguoi4.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (26, 3, N'306', N'Standard Room', N'Single Bed', 500000, 2, N'Spacious', N'images/phongdon7.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (27, 3, N'307', N'Standard Room', N'Twin Beds', 800000, 2, N'Spacious', N'images/phongdoi8.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (28, 3, N'308', N'Phòng 4 người', N'Queen Bed', 1200000, 4, N'Cool', N'images/phong4nguoi5.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (29, 3, N'309', N'Suite Room', N'King Bed', 1500000, 5, N'Luxurious', N'images/phong5nguoi5.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (30, 4, N'400', N'Standard Room', N'Twin Beds', 800000, 2, N'Noble', N'images/phongdoi9.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (31, 4, N'401', N'Standard Room', N'Single Bed', 500000, 1, N'Soft', N'images/phongdon8.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (32, 4, N'402', N'Room for 4 people', N'Queen Bed', 1200000, 4, N'Spacious', N'images/phong4nguoi6.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (33, 4, N'403', N'Standard Room', N'Twin Beds', 800000, 2, N'Clean', N'images/phongdoi10.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (34, 4, N'404', N'Suite Room', N'King Bed', 1500000, 5, N'Comfortable', N'images/phong5nguoi6.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (35, 4, N'405', N'Standard Room', N'Single Bed', 500000, 1, N'Cool', N'images/phongdon9.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (36, 4, N'406', N'Room for 4 people', N'Queen Bed', 1200000, 4, N'Luxurious', N'images/phong4nguoi7.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (37, 4, N'407', N'Suite Room', N'King Bed', 1500000, 5, N'Clean', N'images/phong5nguoi7.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (38, 4, N'408', N'Standard Room', N'Single Bed', 500000, 1, N'Spacious', N'images/phongdon10.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (39, 4, N'409', N'Standard Room', N'Twin Beds', 800000, 2, N'Soft', N'images/phongdoi11.jpg', N'Available', 1)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (40, 5, N'101', N'Room for 4 people', N'Queen Bed', 1200000, 4, N'Soft', N'images/phong4nguoi8.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (41, 5, N'102', N'Standard Room', N'Single Bed', 500000, 1, N'Cool', N'images/phongdon11.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (42, 5, N'103', N'Standard Room', N'Single Bed', 500000, 1, N'Cool', N'images/phongdon12.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (43, 5, N'104', N'Standard Room', N'Twin Beds', 700000, 2, N'Clean', N'images/phongdoi12.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (44, 5, N'105', N'Standard Room', N'Twin Beds', 700000, 2, N'Clean', N'images/phongdoi13.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (45, 5, N'106', N'Premium Room', N'Double Bed', 1200000, 3, N'Luxurious', N'images/phongcaocap.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (46, 5, N'107', N'Premium Room', N'Double Bed', 1200000, 3, N'Spacious', N'images/phongcaocap1.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (47, 5, N'108', N'Standard Room', N'Single Bed', 520000, 1, N'Noble', N'images/phongdon13.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (48, 5, N'109', N'Standard Room', N'Single Bed', 520000, 1, N'Luxurious', N'images/phongdon14.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (49, 6, N'200', N'Standard Room', N'Twin Beds', 730000, 2, N'Luxurious', N'images/phongdoi14.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (50, 6, N'201', N'Standard Room', N'Twin Beds', 730000, 2, N'Luxurious', N'images/phongdoi15.jpg', N'Available', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (51, 6, N'202', N'Premium Room', N'Double Bed', 1250000, 3, N'Spacious', N'images/phongcaocap2.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (52, 6, N'203', N'Premium Room', N'Double Bed', 1250000, 3, N'Cool', N'images/phongcaocap3.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (53, 6, N'204', N'Standard Room', N'Single Bed', 540000, 1, N'Luxurious', N'images/phongdon15.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (54, 6, N'205', N'Standard Room', N'Single Bed', 540000, 1, N'Clean', N'images/phongdon16.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (55, 6, N'206', N'Standard Room', N'Twin Beds', 750000, 2, N'Soft', N'images/phongdoi16.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (56, 6, N'207', N'Standard Room', N'Twin Beds', 750000, 2, N'Cool', N'images/phongdoi17.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (57, 6, N'208', N'Premium Room', N'Double Bed', 1300000, 3, N'Noble', N'images/phongcaocap4.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (58, 6, N'209', N'Premium Room', N'Double Bed', 1300000, 3, N'Spacious', N'images/phongcaocap5.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (59, 7, N'300', N'Standard Room', N'Single Bed', 560000, 1, N'Cool', N'images/phongdon17.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (60, 7, N'301', N'Standard Room', N'Single Bed', 560000, 1, N'Luxurious', N'images/phongdon18.jpg', N'Booked', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (61, 7, N'302', N'Standard Room', N'Twin Beds', 770000, 2, N'Clean', N'images/phongdoi18.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (62, 7, N'303', N'Standard Room', N'Twin Beds', 770000, 2, N'Soft', N'images/phongdoi19.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (63, 7, N'304', N'Premium Room', N'Double Bed', 1350000, 3, N'Cool', N'images/phongcaocap6.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (64, 7, N'305', N'Premium Room', N'Double Bed', 1350000, 3, N'Noble', N'images/phongcaocap7.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (65, 7, N'306', N'Standard Room', N'Single Bed', 580000, 1, N'Noble', N'images/phongdon19.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (66, 7, N'307', N'Standard Room', N'Single Bed', 580000, 1, N'Cool', N'images/phongdon20.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (67, 7, N'308', N'Standard Room', N'Twin Beds', 790000, 2, N'Luxurious', N'images/phongdoi20.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (68, 7, N'309', N'Standard Room', N'Twin Beds', 790000, 2, N'Clean', N'images/phongdoi21.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (69, 8, N'400', N'Premium Room', N'Double Bed', 1400000, 3, N'Comfortable', N'images/phongcaocap8.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (70, 8, N'401', N'Premium Room', N'Double Bed', 1400000, 3, N'Noble', N'images/phongcaocap9.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (71, 8, N'402', N'Suite Room', N'King Bed', 1800000, 4, N'Spacious', N'images/phongsuite.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (72, 8, N'403', N'Suite Room', N'King Bed', 1850000, 4, N'Cool', N'images/phongsuite1.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (73, 8, N'404', N'Suite Room', N'King Bed', 1900000, 4, N'Luxurious', N'images/phongsuite2.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (74, 8, N'405', N'Suite Room', N'King Bed', 1950000, 4, N'Clean', N'images/phongsuite3.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (75, 8, N'406', N'Suite Room', N'King Bed', 2000000, 4, N'Cool', N'images/phongsuite4.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (76, 8, N'407', N'Standard Room', N'Single Bed', 500000, 1, N'Noble', N'images/phongdon21.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (77, 8, N'408', N'Standard Room', N'Single Bed', 520000, 1, N'Spacious', N'images/phongdon22.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (78, 8, N'409', N'Standard Room', N'Twin Beds', 750000, 2, N'Cool', N'images/phongdoi22.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (79, 9, N'500', N'Standard Room', N'Twin Beds', 770000, 2, N'Luxurious', N'images/phongdoi23.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (80, 9, N'501', N'Premium Room', N'Double Bed', 1400000, 3, N'Clean', N'images/phongcaocap10.jpg', N'In use', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (81, 9, N'502', N'Standard Room', N'Single Bed', 510000, 1, N'Comfortable', N'images/phongdon23.jpg', N'Maintenance', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (82, 9, N'503', N'Standard Room', N'Single Bed', 530000, 1, N'Noble', N'images/phongdon24.jpg', N'Maintenance', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (83, 9, N'504', N'Standard Room', N'Twin Beds', 760000, 2, N'Soft', N'images/phongdoi24.jpg', N'Maintenance', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (84, 9, N'505', N'Standard Room', N'Twin Beds', 780000, 2, N'Soft', N'images/phongdoi25.jpg', N'Maintenance', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (85, 5, N'506', N'Phòng cao cấp', N'Double Bed', 1420000, 3, N'Noble', N'images/phongcaocap11.jpg', N'Maintenance', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (86, 5, N'507', N'Standard Room', N'Twin Beds', 700000, 2, N'Clean', N'images/phongdoi26.jpg', N'Shut down', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (87, 9, N'508', N'Premium Room', N'Double Bed', 1250000, 3, N'Luxurious', N'images/phongcaocap12.jpg', N'Shut down', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (88, 9, N'509', N'Suite Room', N'King Bed', 1900000, 4, N'Cool', N'images/phongsuite5.jpg', N'Shut down', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (89, 10, N'600', N'Standard Room', N'Single Bed', 560000, 1, N'Spacious', N'images/phongdon25.jpg', N'Shut down', 2)
INSERT [dbo].[Rooms] ([RoomId], [FloorNumber], [RoomNumber], [RoomType], [BedType], [Price], [MaxOccupancy], [Description], [ImageUrl], [Status], [BuildingId]) VALUES (90, 10, N'601', N'Standard Room', N'Twin Beds', 800000, 2, N'Noble', N'images/phongdoi27.jpg', N'Shut down', 2)
SET IDENTITY_INSERT [dbo].[Rooms] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [Status], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (1, N'admin01', N'c4ca4238a0b923820dcc509a6f75849b', CAST(N'2025-06-15T09:30:00.000' AS DateTime), 1, N'1', CAST(N'2025-01-01T00:00:00.000' AS DateTime), N'images/face.jpg', N'Nguyễn Văn An', N'Male', CAST(N'1985-03-15' AS Date), N'0901234567', N'an.nguyen@example.com', N'123 Ly Thuong Kiet, Hanoi', N'1234567890', CAST(N'2020-01-10' AS Date))
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [Status], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (2, N'manager01', N'E10ADC3949BA59ABBE56E057F20F883EE10ADC3949BA59ABBE56E057F20F883E', CAST(N'2025-06-15T11:10:00.000' AS DateTime), 2, N'1', CAST(N'2025-01-02T00:00:00.000' AS DateTime), N'images/face.jpg', N'	Trần Thị Hương', N'Female', CAST(N'1990-07-22' AS Date), N'0912345678', N'huong.tran@example.com', N'45 Pasteur, District 1, HCMC', N'2345678901', CAST(N'2021-03-05' AS Date))
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [Status], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (3, N'reception01', N'E10ADC3949BA59ABBE56E057F20F883E', CAST(N'2025-06-15T13:45:00.000' AS DateTime), 3, N'1', CAST(N'2025-01-03T00:00:00.000' AS DateTime), N'images/face.jpg', N'Lê Minh Tâm', N'Male', CAST(N'1995-12-01' AS Date), N'0933456789', N'tam.le@example.com', N'789 Hoang Dieu, Da Nang', N'3456789012', CAST(N'2022-06-18' AS Date))
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [Status], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (5, N'khoadz', N'c4ca4238a0b923820dcc509a6f75849b', CAST(N'2025-06-15T08:20:00.000' AS DateTime), 3, N'1', CAST(N'2025-01-05T00:00:00.000' AS DateTime), N'images/face.jpg', N'Đỗ Khải Hoà', N'Male', CAST(N'1993-09-09' AS Date), N'0978123456', N'khoa.do@example.com', N'56 Nguyen Trai, Hanoi', N'4567890123', CAST(N'2023-01-22' AS Date))
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [Status], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (7, N'hoaanh', N'c4ca4238a0b923820dcc509a6f75849b', CAST(N'2025-06-14T18:15:00.000' AS DateTime), 3, N'1', CAST(N'2025-01-07T00:00:00.000' AS DateTime), NULL, N'	Phạm Hoa Anh', N'Female', CAST(N'1998-11-30' AS Date), N'0967890123', N'hoa.pham@example.com', N'15 Tran Phu, Hai Phong', N'5678901234', CAST(N'2023-09-01' AS Date))
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [Status], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (9, N'lethao', N'c4ca4238a0b923820dcc509a6f75849b', CAST(N'2025-06-13T20:00:00.000' AS DateTime), 3, N'1', CAST(N'2025-01-09T00:00:00.000' AS DateTime), NULL, N'Nguyễn Lê Thảo', N'Female', CAST(N'1997-04-18' AS Date), N'0945678901', N'thao.nguyen@example.com', N'88 Nguyen Van Cu, Can Tho', N'6789012345', CAST(N'2024-01-05' AS Date))
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [Status], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (17, N'anhkhoa', N'c4ca4238a0b923820dcc509a6f75849b', CAST(N'2025-06-15T10:40:00.000' AS DateTime), 2, N'1', CAST(N'2025-01-17T00:00:00.000' AS DateTime), NULL, N'Bùi Anh Khoa', N'Male', CAST(N'1992-06-10' AS Date), N'0923456789', N'khoa.bui@example.com', N'34 Tran Hung Dao, Nha Trang', N'7890123456', CAST(N'2021-08-15' AS Date))
INSERT [dbo].[Users] ([UserId], [UserName], [Password], [LastLogin], [RoleId], [Status], [CreationDate], [AvatarUrl], [FullName], [Gender], [DateOfBirth], [Phone], [Email], [Address], [IdentityNumber], [JoinDate]) VALUES (34, N'xuanbao', N'c4ca4238a0b923820dcc509a6f75849b', CAST(N'2025-06-16T07:55:00.000' AS DateTime), 3, N'1', CAST(N'2025-02-03T00:00:00.000' AS DateTime), NULL, N'Võ Xuân Bảo', N'Male', CAST(N'1999-05-25' AS Date), N'0956789012', N'bao.vo@example.com', N'17 Pham Ngu Lao, Hue', N'8901234567', CAST(N'2023-07-10' AS Date))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Vouchers] ON 

INSERT [dbo].[Vouchers] ([VoucherId], [Code], [Description], [DiscountPercent], [StartDate], [EndDate], [MinOrderAmount], [Quantity], [IsActive], [UserId]) VALUES (1, N'SALE10', N'10% off all orders', 10, CAST(N'2025-06-01' AS Date), CAST(N'2025-06-30' AS Date), CAST(200000.00 AS Decimal(10, 2)), 100, 1, N'1         ')
INSERT [dbo].[Vouchers] ([VoucherId], [Code], [Description], [DiscountPercent], [StartDate], [EndDate], [MinOrderAmount], [Quantity], [IsActive], [UserId]) VALUES (3, N'SUMMER15', N'Summer Promotion - 15% Off', 15, CAST(N'2025-06-10' AS Date), CAST(N'2025-07-31' AS Date), CAST(300000.00 AS Decimal(10, 2)), 150, 1, N'1         ')
INSERT [dbo].[Vouchers] ([VoucherId], [Code], [Description], [DiscountPercent], [StartDate], [EndDate], [MinOrderAmount], [Quantity], [IsActive], [UserId]) VALUES (5, N'VIP30', N'Weekend Offer', 30, CAST(N'2025-06-01' AS Date), CAST(N'2025-12-31' AS Date), CAST(500000.00 AS Decimal(10, 2)), 50, 1, N'1         ')
INSERT [dbo].[Vouchers] ([VoucherId], [Code], [Description], [DiscountPercent], [StartDate], [EndDate], [MinOrderAmount], [Quantity], [IsActive], [UserId]) VALUES (6, N'FLASH50', N'Flash Sale 20% off for 1 day', 20, CAST(N'2025-06-20' AS Date), CAST(N'2025-06-20' AS Date), CAST(100000.00 AS Decimal(10, 2)), 20, 0, N'1         ')
SET IDENTITY_INSERT [dbo].[Vouchers] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__C9F284564BDA72F0]    Script Date: 6/16/2025 10:42:56 PM ******/
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [UQ__Customer__C9F284564BDA72F0] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E44675469E]    Script Date: 6/16/2025 10:42:56 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ__Users__536C85E44675469E] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Vouchers__A25C5AA732356799]    Script Date: 6/16/2025 10:42:56 PM ******/
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
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__StatusId__4D5F7D71]  DEFAULT ((1)) FOR [Status]
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
ALTER TABLE [dbo].[RoomAmenities]  WITH CHECK ADD  CONSTRAINT [FK__RoomAmeni__Ameni__2CBDA3B5] FOREIGN KEY([AmenityId])
REFERENCES [dbo].[Amenities] ([AmenityId])
GO
ALTER TABLE [dbo].[RoomAmenities] CHECK CONSTRAINT [FK__RoomAmeni__Ameni__2CBDA3B5]
GO
ALTER TABLE [dbo].[RoomAmenities]  WITH CHECK ADD  CONSTRAINT [FK__RoomAmeni__RoomI__2BC97F7C] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[RoomAmenities] CHECK CONSTRAINT [FK__RoomAmeni__RoomI__2BC97F7C]
GO
ALTER TABLE [dbo].[RoomReviews]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[RoomReviews]  WITH CHECK ADD  CONSTRAINT [FK__RoomRevie__RoomI__1E6F845E] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[RoomReviews] CHECK CONSTRAINT [FK__RoomRevie__RoomI__1E6F845E]
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
ALTER TABLE [dbo].[ServiceOrders]  WITH CHECK ADD  CONSTRAINT [FK__ServiceOr__UserI__1209AD79] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ServiceOrders] CHECK CONSTRAINT [FK__ServiceOr__UserI__1209AD79]
GO
ALTER TABLE [dbo].[ServiceOrders]  WITH CHECK ADD  CONSTRAINT [FK_ServiceOrders_Rooms] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[ServiceOrders] CHECK CONSTRAINT [FK_ServiceOrders_Rooms]
GO
ALTER TABLE [dbo].[SupportMessages]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[SupportMessages]  WITH CHECK ADD  CONSTRAINT [FK__SupportMe__Staff__6F7F8B4B] FOREIGN KEY([StaffId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[SupportMessages] CHECK CONSTRAINT [FK__SupportMe__Staff__6F7F8B4B]
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
