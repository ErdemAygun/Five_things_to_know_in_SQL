/******************>> www.WalterShields.com <<************************
*                                                                    *
*CREATED BY: WALTER SHIELDS                                          *
*CREATED DATE: MM/DD/YYYY                                            *
*DESCRIPTION: THIS SCRIPT WILL CREATE YOUR DIGITAL EVIDENCE DATABASE *
*                                                                    *
******************>>  www.WalterShields.com <<************************/

USE [master]
GO
/****** Object:  Database [DigitalEvidence]    Script Date: 4/26/2022 4:36:56 PM ******/
CREATE DATABASE [DigitalEvidence]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DigitalEvidence', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DigitalEvidence.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DigitalEvidence_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DigitalEvidence_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DigitalEvidence] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DigitalEvidence].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DigitalEvidence] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DigitalEvidence] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DigitalEvidence] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DigitalEvidence] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DigitalEvidence] SET ARITHABORT OFF 
GO
ALTER DATABASE [DigitalEvidence] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DigitalEvidence] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DigitalEvidence] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DigitalEvidence] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DigitalEvidence] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DigitalEvidence] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DigitalEvidence] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DigitalEvidence] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DigitalEvidence] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DigitalEvidence] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DigitalEvidence] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DigitalEvidence] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DigitalEvidence] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DigitalEvidence] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DigitalEvidence] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DigitalEvidence] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DigitalEvidence] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DigitalEvidence] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DigitalEvidence] SET  MULTI_USER 
GO
ALTER DATABASE [DigitalEvidence] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DigitalEvidence] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DigitalEvidence] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DigitalEvidence] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DigitalEvidence] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DigitalEvidence] SET QUERY_STORE = OFF
GO
USE [DigitalEvidence]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToTitleCase]    Script Date: 4/26/2022 4:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ConvertToTitleCase](@Text as varchar(8000))
returns varchar(8000)
as
begin
  declare @Reset bit;
  declare @Ret varchar(8000);
  declare @index int;
  declare @c char(1);

  if @Text is null
    return null;

  select @Reset = 1, @index = 1, @Ret = '';

  while (@index <= len(@Text))
    select @c = substring(@Text, @index, 1),
      @Ret = @Ret + case when @Reset = 1 then UPPER(@c) else LOWER(@c) end,
      @Reset = case when @c like '[a-zA-Z]' then 0 else 1 end,
      @index = @index + 1
  return @Ret
end
GO
/****** Object:  UserDefinedFunction [dbo].[ProperCase]    Script Date: 4/26/2022 4:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ProperCase](@Text as varchar(8000))
returns varchar(8000)
as
begin
  declare @Reset bit;
  declare @Ret varchar(8000);
  declare @i int;
  declare @c char(1);

  if @Text is null
    return null;

  select @Reset = 1, @i = 1, @Ret = '';

  while (@i <= len(@Text))
    select @c = substring(@Text, @i, 1),
      @Ret = @Ret + case when @Reset = 1 then UPPER(@c) else LOWER(@c) end,
      @Reset = case when @c like '[a-zA-Z]' then 0 else 1 end,
      @i = @i + 1
  return @Ret
end
GO
/****** Object:  Table [dbo].[bank_accounts]    Script Date: 4/26/2022 4:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bank_accounts](
	[account_number_pk] [int] NOT NULL,
	[customer_id] [int] NULL,
	[city] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[account_number_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bank_transactions]    Script Date: 4/26/2022 4:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bank_transactions](
	[bank_transaction_pk] [int] NOT NULL,
	[account_number_fk] [int] NULL,
	[transdate] [datetime] NULL,
	[Transdescription] [nvarchar](255) NULL,
	[amount] [money] NULL,
	[Interest] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[bank_transaction_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cellphone_details]    Script Date: 4/26/2022 4:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cellphone_details](
	[id] [int] NOT NULL,
	[customer_id] [int] NULL,
	[phone_number] [int] NULL,
	[status] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer_details]    Script Date: 4/26/2022 4:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_details](
	[id] [int] NOT NULL,
	[firstName] [nvarchar](255) NULL,
	[city] [nvarchar](255) NULL,
	[age] [int] NULL,
	[LastName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[flight_details]    Script Date: 4/26/2022 4:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[flight_details](
	[id] [int] NOT NULL,
	[customer_id] [int] NULL,
	[start_city] [nvarchar](255) NULL,
	[dest_city] [nvarchar](255) NULL,
	[flightDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[text_messages]    Script Date: 4/26/2022 4:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_messages](
	[id] [int] NOT NULL,
	[sender_id] [int] NULL,
	[receiver_id] [int] NULL,
	[message] [nvarchar](255) NULL,
	[sent] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (25938, 152, N'Gainesville')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (82091, 235, N'Port-Vila')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (193488, 216, N'Biak')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (203987, 106, N'Karatsu')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (203993, 101, N'Dordrecht')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (343769, 20, N'Oum el Bouaghi')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (457201, 137, N'Hamm')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (475539, 207, N'Tarlac City')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (526551, 25, N'Shushtar')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (567428, 139, N'Pingzhen')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (616609, 203, N'Barra Mansa')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (680677, 143, N'Naga City')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (691829, 210, N'Lehigh Acres')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (761216, 17, N'Concordia')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (868072, 226, N'Patiala')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (952185, 8, N'Mungo')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (1102973, 12, N'Novomoskovsk')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (1113463, 223, N'Prague')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (1141611, 9, N'Flint')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (1188263, 19, N'Domodedovo')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (1458741, 209, N'Broken Arrow')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (1486378, 240, N'Juazeiro')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (1783543, 237, N'Kamina')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (1951959, 215, N'Amol')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (2306186, 145, N'San Martin')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (2319232, 208, N'Kahta')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (2594447, 2, N'Piracicaba')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (2655480, 214, N'Maraba')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (2688339, 149, N'Wenzhou')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (2948502, 228, N'Baia Farta')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (2949832, 232, N'Chattogram')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (2978006, 148, N'Zanzibar')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (3014868, 135, N'Emmen')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (3252981, 133, N'Mesquite')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (3340267, 155, N'Luxor')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (3461719, 157, N'Port Elizabeth')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (3575645, 224, N'Kingston upon Hull')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (3725563, 236, N'Veraval')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (3781180, 242, N'Duisburg')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (3818447, 131, N'Gorakhpur')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4234504, 246, N'Edison')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4320616, 15, N'Relizane')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4386567, 150, N'Langley')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4587016, 231, N'Santiago de Cuba')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4770149, 130, N'Townsville')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4776245, 4, N'Konya')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4802283, 220, N'Reykjavik')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4898687, 229, N'Gulou')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4901394, 211, N'Lucena')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (4999134, 6, N'Buraydah')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5143973, 222, N'Newport News')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5284765, 233, N'Gaobeidian')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5590832, 5, N'As Suwayhirah as Sahil')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5707812, 24, N'Higashiomi')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5778735, 217, N'Kashmar')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5828345, 213, N'Antwerp')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5869514, 218, N'Taito')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5894821, 238, N'Buenaventura')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (5988905, 136, N'Probolinggo')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6012119, 231, N'Santiago de Cuba')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6075710, 206, N'Elazig')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6214973, 7, N'Pocheon')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6234347, 245, N'Tema')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6395400, 13, N'Cabo Frio')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6419807, 16, N'Knoxville')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6481571, 14, N'Umtata')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6598391, 241, N'Anderlecht')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6632848, 141, N'Haldia')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6687259, 140, N'Wu''an')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6698709, 205, N'Welkom')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6876381, 153, N'Nice')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6928632, 132, N'Ulm')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (6979000, 230, N'Dakar')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7058971, 221, N'Diyarbakir')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7104020, 239, N'Vitsyebsk')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7226852, 244, N'Florencio Varela')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7260590, 219, N'Little Rock')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7282653, 21, N'Palma')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7286179, 234, N'Langsa')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7302845, 227, N'The Valley')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7311718, 138, N'Cotabato')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7319459, 202, N'Khak-e `Ali')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7705576, 201, N'Minglanilla')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7775472, 204, N'Zhangjiajie')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (7974023, 243, N'Naples')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8016646, 225, N'Uige')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8052678, 10, N'Sabzevar')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8361166, 18, N'Paniqui')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8587211, 146, N'Sirjan')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8618459, 3, N'Nyiregyhaza')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8756837, 11, N'Hanoi')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8798924, 134, N'Xinshi')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8962515, 144, N'Marg`ilon')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8963866, 23, N'Winnipeg')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (8967995, 154, N'Puebla')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (9040806, 147, N'Mbandaka')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (9100006, 142, N'Franco da Rocha')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (9107892, 212, N'Ellore')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (9759699, 156, N'Yakutsk')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (9867888, 26, N'Piranshahr')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (9933460, 151, N'Shiyan')
GO
INSERT [dbo].[bank_accounts] ([account_number_pk], [customer_id], [city]) VALUES (9995297, 1, N'Hanoi')
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (100, 203993, CAST(N'2021-10-21T16:41:00.000' AS DateTime), N'Shopping for Shoes', 39.9900, 40)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (110, 203993, CAST(N'2021-10-21T17:39:00.000' AS DateTime), N'ATM 1X9209', 100.0000, 100)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (122, 203993, CAST(N'2021-10-22T08:25:00.000' AS DateTime), N'Entrance Tour Eiffel', 15.0000, 15)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (133, 203993, CAST(N'2021-10-22T22:08:00.000' AS DateTime), N'ATM 1293YM ', 150.0000, 150)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (144, 203993, CAST(N'2021-10-23T12:22:00.000' AS DateTime), N'MM book store', 17.9900, 18)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (145, 203993, CAST(N'2021-10-24T13:00:00.000' AS DateTime), N'Artwork', 1000.0000, 10000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (146, 203993, CAST(N'2021-10-24T13:01:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (147, 203993, CAST(N'2021-10-24T13:02:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (148, 203993, CAST(N'2021-10-24T13:03:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (149, 203993, CAST(N'2021-10-24T13:04:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (150, 203993, CAST(N'2021-10-24T13:05:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (151, 203993, CAST(N'2021-10-24T13:06:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (152, 203993, CAST(N'2021-10-24T13:07:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (153, 203993, CAST(N'2021-10-24T13:08:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (154, 203993, CAST(N'2021-10-24T13:09:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (155, 203993, CAST(N'2021-10-24T14:00:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (156, 203993, CAST(N'2021-10-24T14:01:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (157, 203993, CAST(N'2021-10-24T14:02:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (158, 203993, CAST(N'2021-10-24T15:00:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (245, 203987, CAST(N'2021-10-24T13:00:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (246, 203987, CAST(N'2021-10-24T13:01:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (247, 203987, CAST(N'2021-10-24T13:02:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (248, 203987, CAST(N'2021-10-24T13:03:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (249, 203987, CAST(N'2021-10-24T13:04:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (250, 203987, CAST(N'2021-10-24T13:05:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (251, 203987, CAST(N'2021-10-24T13:06:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (252, 203987, CAST(N'2021-10-24T13:07:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (253, 203987, CAST(N'2021-10-24T13:08:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (254, 203987, CAST(N'2021-10-24T13:09:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (255, 203987, CAST(N'2021-10-24T14:00:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (256, 203987, CAST(N'2021-10-24T14:01:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (257, 203987, CAST(N'2021-10-24T14:02:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (258, 203987, CAST(N'2021-10-24T15:00:00.000' AS DateTime), N'Artwork', 1000.0000, 1000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (300, 6876381, CAST(N'2021-10-24T07:12:37.000' AS DateTime), N'Cash withdrawal', 968.9300, 951695521)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (301, 2978006, CAST(N'2021-10-10T07:29:33.000' AS DateTime), N'Cash withdrawal', 457.8800, 45877585)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (302, 1783543, CAST(N'2021-10-13T08:30:28.000' AS DateTime), N'Books Co.', 152.8500, 153956321)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (303, 5778735, CAST(N'2021-10-31T07:47:14.000' AS DateTime), N'Books Co.', 159.6500, 190000000)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (304, 1188263, CAST(N'2021-10-27T08:26:55.000' AS DateTime), N'Books Co.', 476.7900, 999999999)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (305, 8963866, CAST(N'2021-10-29T07:11:21.000' AS DateTime), N'Books Co.', 257.5700, 258)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (306, 475539, CAST(N'2021-10-24T07:02:58.000' AS DateTime), N'Cash withdrawal', 638.7100, 639)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (307, 952185, CAST(N'2021-10-22T08:07:23.000' AS DateTime), N'Books Co.', 289.5700, 290)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (308, 7311718, CAST(N'2021-10-29T07:33:51.000' AS DateTime), N'Cash withdrawal', 1.9300, 2)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (309, 457201, CAST(N'2021-10-17T07:29:37.000' AS DateTime), N'Cash withdrawal', 249.4300, 249)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (310, 3252981, CAST(N'2021-10-24T07:32:42.000' AS DateTime), N'Books Co.', 39.0700, 39)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (311, 4587016, CAST(N'2021-11-01T07:14:10.000' AS DateTime), N'Grocery Co.', 815.8400, 816)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (312, 4386567, CAST(N'2021-10-18T08:39:46.000' AS DateTime), N'Books Co.', 124.4600, 124)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (313, 567428, CAST(N'2021-10-22T08:28:02.000' AS DateTime), N'Grocery Co.', 387.1800, 387)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (314, 868072, CAST(N'2021-10-31T08:30:03.000' AS DateTime), N'Books Co.', 629.9200, 630)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (315, 1951959, CAST(N'2021-10-23T08:19:27.000' AS DateTime), N'Grocery Co.', 33.8700, 34)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (316, 5988905, CAST(N'2021-10-31T08:30:59.000' AS DateTime), N'Cash withdrawal', 143.9300, 144)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (317, 8618459, CAST(N'2021-10-13T07:20:09.000' AS DateTime), N'Books Co.', 726.1800, 726)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (318, 4898687, CAST(N'2021-10-15T07:31:08.000' AS DateTime), N'Cash withdrawal', 881.0600, 881)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (319, 5828345, CAST(N'2021-10-31T07:23:11.000' AS DateTime), N'Books Co.', 747.9000, 748)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (320, 2655480, CAST(N'2021-11-01T07:09:00.000' AS DateTime), N'Books Co.', 237.4900, 237)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (321, 5894821, CAST(N'2021-10-28T07:52:31.000' AS DateTime), N'Cash withdrawal', 639.3300, 639)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (322, 6598391, CAST(N'2021-10-19T08:02:17.000' AS DateTime), N'Books Co.', 590.4800, 590)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (323, 7311718, CAST(N'2021-10-26T07:53:47.000' AS DateTime), N'Books Co.', 643.4300, 643)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (324, 193488, CAST(N'2021-10-29T07:56:16.000' AS DateTime), N'Cash withdrawal', 616.4600, 616)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (325, 8798924, CAST(N'2021-10-14T07:26:26.000' AS DateTime), N'Grocery Co.', 441.9000, 442)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (326, 3252981, CAST(N'2021-10-30T07:08:57.000' AS DateTime), N'Cash withdrawal', 402.4000, 402)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (327, 9040806, NULL, N'Books Co.', 23.7400, 24)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (328, 567428, CAST(N'2021-10-27T08:38:57.000' AS DateTime), N'Grocery Co.', 89.1600, 89)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (329, 7974023, CAST(N'2021-10-20T07:01:35.000' AS DateTime), N'Books Co.', 27.5700, 28)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (330, 6632848, CAST(N'2021-10-29T08:32:26.000' AS DateTime), N'Cash withdrawal', 343.7700, 344)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (331, 4776245, CAST(N'2021-10-11T08:04:40.000' AS DateTime), N'Cash withdrawal', 71.9400, 72)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (332, 680677, CAST(N'2021-10-12T07:22:48.000' AS DateTime), N'Grocery Co.', 660.7900, 661)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (333, 3340267, CAST(N'2021-10-27T07:21:37.000' AS DateTime), N'Books Co.', 102.2800, 102)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (334, 9040806, CAST(N'2021-10-30T08:26:43.000' AS DateTime), N'Books Co.', 939.3900, 939)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (335, 6698709, CAST(N'2021-10-20T08:42:54.000' AS DateTime), N'Books Co.', 863.3800, 863)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (336, 6632848, CAST(N'2021-10-18T08:44:50.000' AS DateTime), N'Books Co.', 855.6600, 856)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (337, 1113463, CAST(N'2021-10-29T08:17:37.000' AS DateTime), N'Books Co.', 244.1200, 244)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (338, 4320616, CAST(N'2021-10-25T08:03:13.000' AS DateTime), N'Books Co.', 862.8200, 863)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (339, 2978006, CAST(N'2021-10-27T08:18:30.000' AS DateTime), N'Grocery Co.', 184.1300, 184)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (340, 680677, CAST(N'2021-10-10T07:36:07.000' AS DateTime), N'Grocery Co.', 252.8600, 253)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (341, 9040806, CAST(N'2021-10-22T07:35:37.000' AS DateTime), N'Grocery Co.', 260.0600, 260)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (342, 1458741, CAST(N'2021-10-21T07:54:50.000' AS DateTime), N'Cash withdrawal', 706.2100, 706)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (343, 7260590, CAST(N'2021-10-10T08:37:41.000' AS DateTime), N'Cash withdrawal', 683.7000, 684)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (344, 6481571, CAST(N'2021-10-10T08:17:27.000' AS DateTime), N'Cash withdrawal', 496.4200, 496)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (345, 6698709, CAST(N'2021-10-12T07:06:11.000' AS DateTime), N'Cash withdrawal', 658.5700, 659)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (346, 6632848, CAST(N'2021-10-17T07:46:55.000' AS DateTime), N'Books Co.', 331.4300, 331)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (347, 7319459, CAST(N'2021-10-28T08:19:22.000' AS DateTime), N'Grocery Co.', 988.0800, 988)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (348, 4898687, CAST(N'2021-10-13T08:09:19.000' AS DateTime), N'Grocery Co.', 181.4200, 181)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (349, 8962515, CAST(N'2021-10-24T08:03:00.000' AS DateTime), N'Cash withdrawal', 494.7400, 495)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (350, 3818447, CAST(N'2021-10-27T07:50:21.000' AS DateTime), N'Books Co.', 323.8000, 324)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (351, 868072, CAST(N'2021-10-19T07:33:36.000' AS DateTime), N'Books Co.', 949.1700, 949)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (352, 4901394, CAST(N'2021-10-15T07:07:09.000' AS DateTime), N'Cash withdrawal', 141.6700, 142)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (353, 5778735, CAST(N'2021-11-01T07:17:54.000' AS DateTime), N'Grocery Co.', 250.8300, 251)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (354, 4999134, CAST(N'2021-10-26T07:47:50.000' AS DateTime), N'Cash withdrawal', 5.1100, 5)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (355, 3340267, CAST(N'2021-10-21T07:40:40.000' AS DateTime), N'Books Co.', 135.6900, 136)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (356, 8967995, CAST(N'2021-10-18T07:53:48.000' AS DateTime), N'Books Co.', 31.3000, 31)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (357, 343769, CAST(N'2021-10-29T07:25:10.000' AS DateTime), N'Cash withdrawal', 254.7100, 255)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (358, 8361166, CAST(N'2021-10-29T07:22:15.000' AS DateTime), N'Books Co.', 825.2900, 825)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (359, 7282653, CAST(N'2021-10-30T07:58:33.000' AS DateTime), N'Cash withdrawal', 264.5800, 265)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (360, 6395400, CAST(N'2021-10-27T08:19:27.000' AS DateTime), N'Grocery Co.', 332.4200, 332)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (361, 6419807, CAST(N'2021-10-10T07:21:11.000' AS DateTime), N'Grocery Co.', 723.7600, 724)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (362, 2688339, CAST(N'2021-10-30T08:29:14.000' AS DateTime), N'Cash withdrawal', 368.6400, 369)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (363, 6632848, CAST(N'2021-10-22T08:23:09.000' AS DateTime), N'Books Co.', 523.9300, 524)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (364, 343769, CAST(N'2021-10-12T08:34:45.000' AS DateTime), N'Books Co.', 3.2700, 3)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (365, 7319459, CAST(N'2021-10-23T08:16:04.000' AS DateTime), N'Grocery Co.', 771.7300, 772)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (366, 5778735, CAST(N'2021-10-26T07:54:32.000' AS DateTime), N'Books Co.', 936.7900, 937)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (367, 8587211, CAST(N'2021-10-24T08:22:59.000' AS DateTime), N'Grocery Co.', 878.5300, 879)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (368, 6012119, CAST(N'2021-10-31T07:39:26.000' AS DateTime), N'Grocery Co.', 144.1200, 144)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (369, 2688339, NULL, N'Grocery Co.', 959.4400, 959)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (370, 6632848, CAST(N'2021-10-29T07:43:21.000' AS DateTime), N'Books Co.', 505.2300, 505)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (371, 6632848, CAST(N'2021-10-20T07:48:58.000' AS DateTime), N'Books Co.', 927.0000, 927)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (372, 9867888, CAST(N'2021-10-10T07:08:30.000' AS DateTime), N'Books Co.', 51.4000, 51)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (373, 8618459, CAST(N'2021-10-31T08:25:23.000' AS DateTime), N'Cash withdrawal', 378.7400, 379)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (374, 6698709, CAST(N'2021-10-15T08:38:59.000' AS DateTime), N'Grocery Co.', 353.1900, 353)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (375, 8016646, CAST(N'2021-10-17T08:10:10.000' AS DateTime), N'Books Co.', 84.5000, 85)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (376, 7775472, NULL, N'Cash withdrawal', 266.8500, 267)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (377, 6419807, CAST(N'2021-10-29T08:34:07.000' AS DateTime), N'Books Co.', 298.1300, 298)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (378, 4898687, CAST(N'2021-10-27T07:48:58.000' AS DateTime), N'Cash withdrawal', 224.0200, 224)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (379, 9867888, NULL, N'Grocery Co.', 239.2500, 239)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (380, 9933460, CAST(N'2021-10-26T07:50:15.000' AS DateTime), N'Books Co.', 411.9300, 412)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (381, 2948502, CAST(N'2021-10-29T07:10:20.000' AS DateTime), N'Books Co.', 611.0700, 611)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (382, 7260590, CAST(N'2021-10-29T08:07:44.000' AS DateTime), N'Books Co.', 580.7700, 581)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (383, 4802283, CAST(N'2021-10-29T07:13:22.000' AS DateTime), N'Grocery Co.', 194.9500, 195)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (384, 2949832, CAST(N'2021-10-27T07:31:00.000' AS DateTime), N'Books Co.', 200.6500, 201)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (385, 680677, NULL, N'Books Co.', 462.5500, 463)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (386, 4999134, CAST(N'2021-10-28T07:17:23.000' AS DateTime), N'Books Co.', 370.3800, 370)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (387, 6012119, CAST(N'2021-10-28T08:38:30.000' AS DateTime), N'Cash withdrawal', 591.0100, 591)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (388, 2978006, CAST(N'2021-10-21T08:16:31.000' AS DateTime), N'Grocery Co.', 485.6100, 486)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (389, 526551, NULL, N'Cash withdrawal', 149.8600, 150)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (390, 6928632, CAST(N'2021-10-28T08:32:53.000' AS DateTime), N'Grocery Co.', 462.0600, 462)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (391, 6481571, CAST(N'2021-10-29T08:25:49.000' AS DateTime), N'Cash withdrawal', 104.4700, 104)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (392, 680677, CAST(N'2021-10-15T07:26:12.000' AS DateTime), N'Cash withdrawal', 166.2500, 166)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (393, 6632848, CAST(N'2021-10-28T08:35:28.000' AS DateTime), N'Books Co.', 9.3200, 9)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (394, 4770149, CAST(N'2021-10-22T07:36:38.000' AS DateTime), N'Books Co.', 854.6800, 855)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (395, 3340267, CAST(N'2021-10-16T08:42:06.000' AS DateTime), N'Cash withdrawal', 672.1900, 672)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (396, 2655480, CAST(N'2021-10-12T07:51:38.000' AS DateTime), N'Books Co.', 919.7700, 920)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (397, 343769, CAST(N'2021-10-12T08:37:34.000' AS DateTime), N'Cash withdrawal', 993.5000, 994)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (398, 4802283, CAST(N'2021-10-30T07:08:05.000' AS DateTime), N'Grocery Co.', 116.9500, 117)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (399, 7260590, CAST(N'2021-10-24T07:32:15.000' AS DateTime), N'Cash withdrawal', 892.2600, 892)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (400, 9100006, NULL, N'Books Co.', 867.7500, 868)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (401, 7302845, CAST(N'2021-10-11T08:36:08.000' AS DateTime), N'Grocery Co.', 759.9600, 760)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (402, 9867888, CAST(N'2021-10-10T07:54:27.000' AS DateTime), N'Books Co.', 939.0800, 939)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (403, 7302845, CAST(N'2021-10-24T08:23:40.000' AS DateTime), N'Grocery Co.', 6.6500, 7)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (404, 193488, CAST(N'2021-10-29T07:52:40.000' AS DateTime), N'Cash withdrawal', 591.5700, 592)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (405, 8052678, CAST(N'2021-10-21T08:40:30.000' AS DateTime), N'Books Co.', 47.5800, 48)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (406, 5707812, CAST(N'2021-10-25T07:03:02.000' AS DateTime), N'Cash withdrawal', 388.7400, 389)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (407, 7974023, CAST(N'2021-10-20T08:35:59.000' AS DateTime), N'Books Co.', 562.9300, 563)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (408, 8756837, CAST(N'2021-10-18T07:47:20.000' AS DateTime), N'Books Co.', 662.5500, 663)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (409, 8962515, CAST(N'2021-10-24T07:03:54.000' AS DateTime), N'Grocery Co.', 929.6900, 930)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (410, 8016646, CAST(N'2021-10-25T08:31:52.000' AS DateTime), N'Cash withdrawal', 645.4300, 645)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (411, 1458741, CAST(N'2021-10-26T08:02:52.000' AS DateTime), N'Cash withdrawal', 826.8300, 827)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (412, 9040806, CAST(N'2021-10-21T08:11:24.000' AS DateTime), N'Books Co.', 777.7500, 778)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (413, 9933460, CAST(N'2021-10-12T07:26:31.000' AS DateTime), N'Cash withdrawal', 184.9000, 185)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (414, 6395400, CAST(N'2021-10-11T07:30:41.000' AS DateTime), N'Books Co.', 915.3900, 915)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (415, 952185, CAST(N'2021-10-13T07:03:16.000' AS DateTime), N'Books Co.', 367.2600, 367)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (416, 6075710, CAST(N'2021-11-01T07:37:59.000' AS DateTime), N'Books Co.', 530.7700, 531)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (417, 6481571, CAST(N'2021-10-29T08:30:07.000' AS DateTime), N'Books Co.', 746.0500, 746)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (418, 8963866, CAST(N'2021-10-13T08:44:52.000' AS DateTime), N'Books Co.', 174.1700, 174)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (419, 5828345, CAST(N'2021-10-30T08:27:43.000' AS DateTime), N'Books Co.', 167.7500, 168)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (420, 4386567, CAST(N'2021-10-26T08:15:30.000' AS DateTime), N'Grocery Co.', 675.8400, 676)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (421, 7775472, CAST(N'2021-10-25T07:53:44.000' AS DateTime), N'Books Co.', 660.1300, 660)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (422, 8756837, CAST(N'2021-10-12T07:28:59.000' AS DateTime), N'Cash withdrawal', 752.4900, 752)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (423, 3575645, NULL, N'Cash withdrawal', 942.1200, 942)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (424, 3340267, CAST(N'2021-10-29T07:47:42.000' AS DateTime), N'Books Co.', 337.2700, 337)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (425, 5590832, CAST(N'2021-10-31T07:45:58.000' AS DateTime), N'Books Co.', 535.5100, 536)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (426, 9107892, CAST(N'2021-10-17T07:21:01.000' AS DateTime), N'Books Co.', 636.7700, 637)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (427, 8361166, NULL, N'Books Co.', 763.1500, 763)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (428, 9040806, CAST(N'2021-10-27T07:51:40.000' AS DateTime), N'Cash withdrawal', 694.9900, 695)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (429, 5284765, CAST(N'2021-10-20T07:32:06.000' AS DateTime), N'Grocery Co.', 438.6400, 439)
GO
INSERT [dbo].[bank_transactions] ([bank_transaction_pk], [account_number_fk], [transdate], [Transdescription], [amount], [Interest]) VALUES (430, 2655480, NULL, N'Cash withdrawal', 443.1700, 443)
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (2, 155, 809480, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (3, 223, 554524, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (4, 132, 180323, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (5, 236, 828839, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (6, 242, 615588, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (7, 204, 991723, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (8, 154, 214497, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (9, 217, 995104, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (10, 139, 556617, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (11, 225, 468055, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (12, 241, 516402, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (13, 215, 590157, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (14, 222, 349009, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (15, 246, 995801, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (16, 133, 869651, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (17, 205, 991255, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (18, 3, 784015, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (19, 147, 809898, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (20, 206, 5687, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (21, 11, 419752, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (22, 10, 495047, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (23, 137, 670977, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (24, 143, 158882, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (25, 151, 798682, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (26, 18, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (27, 18, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (28, 17, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (29, 16, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (30, 15, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (31, 14, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (32, 13, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (33, 12, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (34, 11, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (35, 10, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (36, 19, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (37, 21, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (38, 22, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (39, 23, 676466, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (100, 100, 1034902, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (101, 101, 1203939, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (102, 102, 1723028, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (103, 103, 7020202, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (104, 104, 3020384, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (105, 105, 2304853, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (106, 106, 9302002, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (130, 210, 183499, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (131, 216, 759780, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (132, 240, 710178, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (133, 231, 733249, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (134, 233, 401344, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (135, 214, 808696, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (136, 157, 561657, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (137, 21, 328747, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (138, 138, 672721, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (139, 201, 341089, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (140, 9, 269971, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (141, 14, 464071, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (142, 144, 879856, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (143, 135, 49673, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (144, 245, 580347, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (145, 232, 798784, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (146, 227, 859403, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (147, 5, 17370, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (148, 218, 368965, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (149, 24, 655632, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (150, 209, 454159, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (151, 153, 582645, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (152, 203, 546797, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (153, 131, 785503, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (154, 202, 309880, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (155, 224, 610010, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (156, 26, 503196, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (157, 12, 409629, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (201, 230, 874272, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (202, 1, 584829, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (203, 22, 840955, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (204, 148, 122581, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (205, 207, 806729, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (206, 212, 420183, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (207, 156, 418508, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (208, 145, 557178, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (209, 219, 148640, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (210, 220, 543409, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (211, 6, 659081, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (212, 2, 399792, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (213, 4, 79160, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (214, 140, 126271, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (215, 17, 358159, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (216, 134, 327830, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (217, 235, 431851, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (218, 20, 470660, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (219, 152, 801443, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (220, 237, 803977, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (221, 238, 660668, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (222, 243, 654965, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (223, 229, 830894, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (224, 141, 593100, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (225, 146, 157497, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (226, 213, 760871, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (227, 228, 974478, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (228, 8, 675087, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (229, 136, 789232, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (230, 226, 84447, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (231, 244, 819511, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (232, 7, 991885, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (233, 211, 180127, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (234, 149, 740347, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (235, 16, 470873, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (236, 19, 320008, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (237, 221, 875618, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (238, 23, 947990, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (239, 142, 878910, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (240, 239, 126635, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (241, 208, 188687, N'active')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (242, 15, 220916, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (243, 150, 635506, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (244, 13, 884101, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (245, 25, 897713, N'inactive')
GO
INSERT [dbo].[cellphone_details] ([id], [customer_id], [phone_number], [status]) VALUES (246, 130, 46774, N'active')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (1, N'Jayden-John', N'Hanoi', 46, N'Smith')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (2, N'Meg', N'Piracicaba', 57, N'Johnson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (3, N'Delight', N'Nyiregyhaza', 14, N'Williams')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (4, N'Parmin', N'Konya', 57, N'Brown')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (5, N'Perry', N'As Suwayhirah as Sahil', 36, N'Jones')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (6, N'Zaynab', N'Buraydah', 56, N'Miller')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (7, N'Kora-Leigh', N'Pocheon', 84, N'Davis')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (8, N'Georgette', N'Mungo', 81, N'Garcia')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (9, N'Mahli', N'Flint', 30, N'Rodriguez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (10, N'Tanmay', N'Sabzevar', 17, N'Wilson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (11, N'Aoibhin', N'Hanoi', 16, N'Martinez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (12, N'Tereasa', N'Novomoskovsk', 45, N'Anderson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (13, N'Mirren', N'Cabo Frio', 96, N'Taylor')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (14, N'Lewis', N'Umtata', 30, N'Thomas')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (15, N'Elidh', N'Relizane', 95, N'Hernandez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (16, N'Ruari', N'Knoxville', 87, N'Moore')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (17, N'Mandie', N'Concordia', 58, N'Martin')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (18, N'Kiera', N'Paniqui', 19, N'Jackson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (19, N'Junya', N'Domodedovo', 87, N'Thompson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (20, N'Darryl', N'Oum el Bouaghi', 61, N'White')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (21, N'Natalie-Jane', N'Palma', 27, N'Lopez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (22, N'Charleigh', N'Santa Rita', 49, N'Lee')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (23, N'Lila', N'Winnipeg', 91, N'Gonzalez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (24, N'Medinah', N'Higashiomi', 37, N'Harris')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (25, N'Ruby', N'Shushtar', 96, N'Clark')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (26, N'Willow', N'Piranshahr', 44, N'Lewis')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (27, N'Ferne', N'Las Condes', 21, N'Robinson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (28, N'Liisa', N'Sarasota', 23, N'Walker')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (29, N'Ze', N'Sambalpur', 30, N'Perez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (30, N'Hajra', N'Kunp''o', 31, N'Hall')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (31, N'Denise', N'Malacatan', 32, N'Young')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (32, N'Barry', N'New York City', 35, N'Allen')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (33, N'Rosanne', N'Barranquilla', 36, N'Sanchez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (34, N'Layla', N'Latakia', 37, N'Wright')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (35, N'Shekhinah', N'Miskolc', 38, N'King')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (36, N'Emily-Marie', N'Jining', 40, N'Scott')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (37, N'Iqra', N'Dasoguz', 42, N'Green')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (38, N'Opra', N'New York City', 43, N'Baker')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (39, N'Dario', N'Yonago', 44, N'Adams')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (100, N'Bruce', N'Puerto Princesa', 42, N'Fisher')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (101, N'Pierre', N'Dordrecht', 75, N'Henderson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (102, N'Leonardo', N'Higuey', 21, N'Coleman')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (103, N'Justyn', N'Angono', 36, N'Simmons')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (104, N'Eden-Blue', N'Rosario', 37, N'Patterson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (105, N'Aleana', N'Machida', 19, N'Jordan')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (106, N'Brenda', N'Karatsu', 39, N'Reynolds')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (130, N'Sanaa', N'Townsville', 96, N'Kennedy')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (131, N'Clayre', N'Gorakhpur', 41, N'Wells')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (132, N'Debra', N'Ulm', 3, N'Alvarez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (133, N'Brooke', N'Mesquite', 11, N'Woods')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (134, N'Sloan', N'Xinshi', 59, N'Mendoza')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (135, N'Francois', N'Emmen', 32, N'Castillo')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (136, N'Christie', N'Probolinggo', 83, N'Olson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (137, N'Marva', N'Hamm', 17, N'Webb')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (138, N'Jayme', N'Cotabato', 28, N'Washington')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (139, N'Daho', N'Pingzhen', 6, N'Tucker')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (140, N'Eghe', N'Wu''an', 57, N'Freeman')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (141, N'Hajrah', N'Haldia', 73, N'Burns')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (142, N'Karen', N'Franco da Rocha', 91, N'Henry')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (143, N'Jatinder', N'Naga City', 17, N'Vasquez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (144, N'Anthony', N'Marg`ilon', 30, N'Snyder')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (145, N'Naseem', N'San Martin', 55, N'Simpson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (146, N'Leaha', N'Sirjan', 77, N'Crawford')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (147, N'Branimir', N'Mbandaka', 15, N'Jimenez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (148, N'Manasse', N'Zanzibar', 51, N'Porter')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (149, N'Meadow', N'Wenzhou', 85, N'Mason')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (150, N'Yu', N'Langley', 95, N'Shaw')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (151, N'Isobel', N'Shiyan', 17, N'Gordon')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (152, N'Elsie', N'Gainesville', 61, N'Wagner')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (153, N'Laiken', N'Nice', 38, N'Hunter')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (154, N'Nawaf', N'Puebla', 5, N'Romero')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (155, N'Essa', N'Luxor', 2, N'Hicks')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (156, N'Edmund', N'Yakutsk', 54, N'Dixon')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (157, N'Jacub', N'Port Elizabeth', 26, N'Hunt')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (201, N'Kayleigh-Ann', N'Minglanilla', 29, N'Carroll')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (202, N'Penelope', N'Khak-e `Ali', 42, N'Hudson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (203, N'Lita', N'Barra Mansa', 40, N'Duncan')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (204, N'Kendal', N'Zhangjiajie', 4, N'Armstrong')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (205, N'Emy', N'Welkom', 12, N'Berry')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (206, N'Joey', N'Elazig', 15, N'Andrews')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (207, N'Jaime', N'Tarlac City', 52, N'Johnston')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (208, N'Stefani', N'Kahta', 94, N'Ray')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (209, N'Anastasia', N'Broken Arrow', 37, N'Lane')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (210, N'Cali-May', N'Lehigh Acres', 20, N'Riley')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (211, N'Annishah', N'Lucena', 84, N'Carpenter')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (212, N'Nadja', N'Ellore', 52, N'Perkins')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (213, N'Farat', N'Antwerp', 79, N'Aguilar')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (214, N'Amrit', N'Maraba', 25, N'Silva')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (215, N'Cavan', N'Amol', 9, N'Richards')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (216, N'Gillon', N'Biak', 21, N'Willis')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (217, N'Pamelah', N'Kashmar', 5, N'Matthews')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (218, N'Darrell', N'Taito', 36, N'Chapman')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (219, N'Maximilian', N'Little Rock', 55, N'Lawrence')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (220, N'Tori-Brendin', N'Reykjavik', 55, N'Garza')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (221, N'Jaime', N'Diyarbakir', 89, N'Vargas')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (222, N'Finn', N'Newport News', 10, N'Watkins')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (223, N'Ricki', N'Prague', 2, N'Wheeler')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (224, N'Kassie', N'Kingston upon Hull', 42, N'Larson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (225, N'Charo', N'Uige', 8, N'Carlson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (226, N'Saunia', N'Patiala', 83, N'Harper')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (227, N'Robina', N'The Valley', 34, N'George')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (228, N'Jafar', N'Baia Farta', 80, N'Greene')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (229, N'Natalie', N'Gulou', 65, N'Burke')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (230, N'Bonny', N'Dakar', 45, N'Guzman')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (231, N'Lyam', N'Santiago de Cuba', 24, N'Morrison')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (232, N'Satvinder', N'Chattogram', 33, N'Munoz')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (233, N'Keighlee', N'Gaobeidian', 24, N'Jacobs')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (234, N'Chena', N'Langsa', 1, N'Obrien')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (235, N'Conin', N'Port-Vila', 59, N'Lawson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (236, N'Maree', N'Veraval', 3, N'Franklin')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (237, N'Harris', N'Kamina', 62, N'Lynch')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (238, N'Daisie', N'Buenaventura', 62, N'Bishop')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (239, N'Dhani', N'Vitsyebsk', 92, N'Carr')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (240, N'Kirstyann', N'Juazeiro', 21, N'Salazar')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (241, N'Llyam', N'Anderlecht', 8, N'Austin')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (242, N'Shasta', N'Duisburg', 3, N'Mendez')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (243, N'Johnathon', N'Naples', 62, N'Gilbert')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (244, N'Emilie', N'Florencio Varela', 83, N'Jensen')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (245, N'Miles', N'Tema', 32, N'Williamson')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (246, N'Ramzan', N'Edison', 10, N'Montgomery')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (1005, N'Roisin', N'Erfurt', 88, N'Bonner')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (1006, N'Jeevisha', N'Brasilia', 48, N'Cotton')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (1007, N'Carmen', N'Zalantun', 23, N'Merrill')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (1008, N'Maisey-Rose', N'Hyderabad', 35, N'Lindsay')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (1009, N'Selah', N'Calumpit', 32, N'Lancaster')
GO
INSERT [dbo].[customer_details] ([id], [firstName], [city], [age], [LastName]) VALUES (1010, N'Bradan', N'Makhachkala', 39, N'Mcgowan')
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (1, 132, N'Hangzhou', N'Warsaw', CAST(N'2021-07-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (2, 139, N'Ahmedabad', N'Beirut', CAST(N'2021-07-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (3, 133, N'Johannesburg', N'Minsk', CAST(N'2021-02-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (4, 3, N'Antananarivo', N'Minsk', CAST(N'2021-05-30T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (5, 147, N'Los Angeles', N'Saint Petersburg', CAST(N'2021-09-15T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (6, 11, N'Hefei', N'Mumbai', CAST(N'2021-06-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (7, 10, N'Xiamen', N'Changsha', CAST(N'2021-03-29T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (8, 137, N'Moscow', N'Yaoundé', CAST(N'2021-08-12T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (9, 143, N'Addis Ababa', N'Riyadh', CAST(N'2021-10-22T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (10, 18, N'Cairo', N'Bangalore', CAST(N'2021-10-21T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (11, 21, N'Riyadh', N'Lima', CAST(N'2021-06-09T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (12, 138, N'Shenzhen', N'Antananarivo', CAST(N'2021-01-27T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (13, 9, N'Yaoundé', N'Busan', CAST(N'2021-03-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (100, 100, N'Puerto Princesa', N'New York City', CAST(N'2021-10-20T08:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (101, 100, N'New York City', N'Puerto Princesa', CAST(N'2021-10-24T08:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (102, 105, N'Ouagadougou', N'New York City', CAST(N'2021-10-21T08:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (103, 105, N'New York City', N'Moskow', CAST(N'2021-10-25T08:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (104, 106, N'Karatsu', N'New York City', CAST(N'2021-10-21T08:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (105, 106, N'New York City', N'Karatsu', CAST(N'2021-10-24T08:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (150, 14, N'Harbin', N'Algiers', CAST(N'2021-06-10T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (151, 144, N'Lagos', N'Ahmedabad', CAST(N'2021-10-16T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (152, 135, N'Hanoi', N'Kampala', CAST(N'2021-05-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (153, 5, N'Kolkata', N'Beirut', CAST(N'2021-10-12T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (154, 24, N'Cape Town', N'New Taipei City', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (155, 131, N'Vienna', N'Budapest', CAST(N'2021-10-09T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (156, 26, N'Accra', N'Vienna', CAST(N'2021-09-22T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (157, 12, N'Doha', N'Baghdad', CAST(N'2021-10-18T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (158, 1, N'Tehran', N'Tokyo', CAST(N'2021-10-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (159, 22, N'Yangon', N'Santiago', CAST(N'2021-10-20T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (203, 148, N'Chongqing', N'Chennai', CAST(N'2021-09-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (204, 145, N'Jeddah', N'Singapore', CAST(N'2021-09-13T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (205, 6, N'Berlin', N'Wenzhou', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (206, 2, N'Warsaw', N'Alexandria', CAST(N'2021-09-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (207, 4, N'Suzhou', N'Manila', CAST(N'2021-10-13T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (208, 140, N'Hong Kong', N'Algiers', CAST(N'2021-09-27T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (209, 17, N'Giza', N'Abidjan', CAST(N'2021-09-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (210, 134, N'Mexico City', N'Manila', CAST(N'2021-10-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (343, 150, N'Paris', N'Chengdu', CAST(N'2021-09-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (344, 13, N'Bogotá', N'Nairobi', CAST(N'2021-10-04T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (345, 25, N'Quanzhou', N'Rabat', CAST(N'2021-09-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (346, 130, N'Caracas', N'Khartoum', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (492, 20, N'Wuhan', N'Jaipur', CAST(N'2021-09-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (493, 141, N'Quito', N'Paris', CAST(N'2021-10-27T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (494, 146, N'London', N'Shantou', CAST(N'2021-10-09T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (495, 8, N'Ekurhuleni', N'Shantou', CAST(N'2021-10-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (496, 136, N'Nanjing', N'Accra', CAST(N'2021-10-18T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (497, 7, N'Luanda', N'Foshan', CAST(N'2021-09-09T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (498, 149, N'Ankara', N'Abidjan', CAST(N'2021-10-21T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (499, 16, N'Saint Petersburg', N'Shenyang', CAST(N'2021-10-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (500, 19, N'Dhaka', N'Tianjin', CAST(N'2021-09-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (501, 23, N'Kinshasa', N'Kampala', CAST(N'2021-10-18T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (502, 142, N'Rabat', N'Doha', CAST(N'2021-09-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (503, 15, N'Beijing', N'Guangzhou', CAST(N'2021-09-12T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[flight_details] ([id], [customer_id], [start_city], [dest_city], [flightDate]) VALUES (504, 141, N'New York City', N'Tianjin', CAST(N'2021-10-31T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (1, 31, 28, N'Thereto prickd on by a most emulate pride', CAST(N'2021-10-26T08:24:33.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (2, 30, 28, N'So frownd he once, when, in an angry parle', CAST(N'2021-10-24T07:19:21.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (3, 30, 28, N'When he the ambitious Norway combated', CAST(N'2021-10-24T07:12:37.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (4, 38, 28, N'Bernardo?', CAST(N'2021-10-10T07:29:33.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (5, 38, 28, N'Give you good night.', CAST(N'2021-10-13T08:30:28.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (6, 32, 28, N'Ill cross it, though it blast me. Stay, illusion!', CAST(N'2021-10-31T07:47:14.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (7, 31, 28, N'And carriage of the article designd', CAST(N'2021-10-27T08:26:55.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (8, 31, 28, N'And terms compulsatory, those foresaid lands', CAST(N'2021-10-29T07:11:21.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (9, 30, 28, N'As thou art to thyself:', CAST(N'2021-10-24T07:02:58.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (10, 20, 28, N'Tis gone, and will not answer.', CAST(N'2021-10-22T08:07:23.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (11, 31, 28, N'Of this post-haste and romage in the land.', CAST(N'2021-10-29T07:33:51.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (12, 29, 28, N'Tush, tush, twill not appear.', CAST(N'2021-10-17T07:29:37.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (13, 30, 28, N'Tis strange.', CAST(N'2021-10-24T07:32:42.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (14, 32, 28, N'Which, happily, foreknowing may avoid, O, speak!', CAST(N'2021-11-01T07:14:10.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (15, 11, 28, N'When yond same star thats westward from the pole', CAST(N'2021-10-18T08:39:46.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (16, 30, 28, N'Before my God, I might not this believe', CAST(N'2021-10-22T08:28:02.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (17, 32, 28, N'That may to thee do ease and grace to me', CAST(N'2021-10-31T08:30:03.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (18, 20, 28, N'Is it not like the king?', CAST(N'2021-10-23T08:19:27.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (19, 32, 28, N'Speak to me:', CAST(N'2021-10-31T08:30:59.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (20, 18, 28, N'Who hath relieved you?', CAST(N'2021-10-13T07:20:09.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (21, 11, 28, N'I have seen nothing.', CAST(N'2021-10-15T07:31:08.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (22, 32, 28, N'Unto our climatures and countrymen.--', CAST(N'2021-10-31T07:23:11.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (55, 32, 28, N'If thou art privy to thy countrys fate', CAST(N'2021-11-01T07:09:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (56, 31, 28, N'Hath in the skirts of Norway here and there', CAST(N'2021-10-28T07:52:31.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (57, 11, 28, N'The bell then beating one,--', CAST(N'2021-10-19T08:02:17.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (58, 21, 28, N'Who ist that can inform me?', CAST(N'2021-10-26T07:53:47.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (59, 31, 28, N'A mote it is to trouble the minds eye.', CAST(N'2021-10-29T07:56:16.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (60, 11, 28, N'Say', CAST(N'2021-10-14T07:26:26.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (61, 32, 28, N'Was sick almost to doomsday with eclipse:', CAST(N'2021-10-30T07:08:57.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (62, 19, 28, N'He may approve our eyes and speak to it.', CAST(N'2021-10-17T07:27:42.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (63, 31, 28, N'His fell to Hamlet. Now, sir, young Fortinbras', CAST(N'2021-10-27T08:38:57.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (64, 20, 28, N'Peace, break thee off  look, where it comes again!', CAST(N'2021-10-20T07:01:35.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (65, 32, 28, N'As stars with trains of fire and dews of blood', CAST(N'2021-10-29T08:32:26.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (66, 38, 28, N'And I am sick at heart.', CAST(N'2021-10-11T08:04:40.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (67, 10, 28, N'Well, good night.', CAST(N'2021-10-12T07:22:48.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (68, 31, 28, N'For so this side of our known world esteemd him--', CAST(N'2021-10-27T07:21:37.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (69, 32, 28, N'As harbingers preceding still the fates', CAST(N'2021-10-30T08:26:43.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (70, 30, 28, N'Most like: it harrows me with fear and wonder.', CAST(N'2021-10-20T08:42:54.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (71, 11, 28, N'Had made his course to illume that part of heaven', CAST(N'2021-10-18T08:44:50.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (72, 31, 28, N'A little ere the mightiest Julius fell', CAST(N'2021-10-29T08:17:37.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (73, 21, 28, N'And why such daily cast of brazen cannon', CAST(N'2021-10-25T08:03:13.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (100, 100, 106, N'Hey, I just landed in at JFK', CAST(N'2021-10-20T09:00:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (101, 106, 100, N'great!', CAST(N'2021-10-21T10:10:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (102, 102, 105, N'Oh great! How was your flight? We could meet at 12 for lunch if you like', CAST(N'2021-10-21T09:10:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (103, 105, 102, N'Hi, I just arrived in NY.  Going to go to my hotel room.  Then I can come meet you.', CAST(N'2021-10-21T09:00:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (104, 100, 106, N'OK. cu', CAST(N'2021-10-21T09:40:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (105, 102, 105, N'Fine, 12 at c.p.?', CAST(N'2021-10-21T09:17:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (106, 106, 100, N'To you too! Have a safe flight back.', CAST(N'2021-10-24T09:12:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (107, 106, 100, N'Yep me too. Let''s meet later tonight, say 10pm at the museum and run through the plan again!', CAST(N'2021-10-21T09:01:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (108, 105, 102, N'Yeah, sounds great. Where should I meet you?  My hotel is close to museum of modern art.', CAST(N'2021-10-21T09:15:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (109, 105, 102, N' Cool, I''ll meet you there', CAST(N'2021-10-21T09:30:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (110, 100, 106, N'This was a coup! I I got to say, I would have loved to keep the art to myselfe lol. Safe trip back and great score!', CAST(N'2021-10-24T09:10:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (111, 100, 106, N'btw, I got great news.  I found a buyer. $1,000,000.  Can you say cha-ching!', CAST(N'2021-10-21T09:41:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (134, 31, 28, N'To the inheritance of Fortinbras', CAST(N'2021-10-27T08:18:30.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (135, 10, 28, N'He.', CAST(N'2021-10-10T07:36:07.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (136, 20, 28, N'It is offended.', CAST(N'2021-10-22T07:35:37.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (137, 30, 28, N'What art thou that usurpst this time of night', CAST(N'2021-10-21T07:54:50.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (138, 10, 28, N'Tis now struck twelve get thee to bed, Francisco.', CAST(N'2021-10-10T08:17:27.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (139, 38, 28, N'Not a mouse stirring.', CAST(N'2021-10-12T07:06:11.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (140, 11, 28, N'Sit down awhile', CAST(N'2021-10-17T07:46:55.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (141, 31, 28, N'Sharkd up a list of lawless resolutes', CAST(N'2021-10-28T08:19:22.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (142, 38, 28, N'Bernardo has my place.', CAST(N'2021-10-13T08:09:19.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (143, 20, 28, N'Thus twice before, and jump at this dead hour', CAST(N'2021-10-24T08:03:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (144, 31, 28, N'Which he stood seized of, to the conqueror:', CAST(N'2021-10-27T07:50:21.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (145, 11, 28, N'Where now it burns, Marcellus and myself', CAST(N'2021-10-19T07:33:36.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (146, 11, 28, N'Welcome, Horatio: welcome, good Marcellus.', CAST(N'2021-10-15T07:07:09.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (147, 32, 28, N'Or if thou hast uphoarded in thy life', CAST(N'2021-11-01T07:17:54.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (148, 21, 28, N'Does not divide the Sunday from the week', CAST(N'2021-10-26T07:47:50.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (149, 20, 28, N'Question it, Horatio.', CAST(N'2021-10-21T07:40:40.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (150, 29, 28, N'And let us hear Bernardo speak of this.', CAST(N'2021-10-18T07:53:48.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (151, 31, 28, N'The source of this our watch and the chief head', CAST(N'2021-10-29T07:25:10.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (152, 31, 28, N'Is the main motive of our preparations', CAST(N'2021-10-29T07:22:15.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (153, 32, 28, N'And even the like precurse of fierce events', CAST(N'2021-10-30T07:58:33.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (154, 31, 28, N'Had he been vanquisher  as, by the same covenant', CAST(N'2021-10-27T08:19:27.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (155, 10, 28, N'Long live the king!', CAST(N'2021-10-10T07:21:11.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (156, 32, 28, N'Have heaven and earth together demonstrated', CAST(N'2021-10-30T08:29:14.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (157, 12, 28, N'Is not this something more than fantasy?', CAST(N'2021-10-22T08:23:09.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (158, 18, 28, N'And liegemen to the Dane.', CAST(N'2021-10-12T08:34:45.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (159, 30, 28, N'Of mine own eyes.', CAST(N'2021-10-23T08:16:04.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (160, 31, 28, N'That can I', CAST(N'2021-10-26T07:54:32.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (161, 30, 28, N'In what particular thought to work I know not', CAST(N'2021-10-24T08:22:59.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (162, 32, 28, N'But soft, behold! lo, where it comes again!', CAST(N'2021-10-31T07:39:26.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (163, 19, 28, N'And will not let belief take hold of him', CAST(N'2021-10-15T08:34:46.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (164, 13, 28, N'Well may it sort that this portentous figure', CAST(N'2021-10-29T07:43:21.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (165, 20, 28, N'Thou art a scholar  speak to it, Horatio', CAST(N'2021-10-20T07:48:58.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (166, 38, 28, N'Nay, answer me: stand, and unfold yourself.', CAST(N'2021-10-10T07:08:30.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (167, 32, 28, N'If there be any good thing to be done', CAST(N'2021-10-31T08:25:23.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (168, 19, 28, N'Touching this dreaded sight, twice seen of us:', CAST(N'2021-10-15T08:38:59.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (198, 11, 28, N'And let us once again assail your ears', CAST(N'2021-10-17T08:10:10.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (199, 19, 28, N'With us to watch the minutes of this night', CAST(N'2021-10-17T07:02:24.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (200, 32, 28, N'Disasters in the sun', CAST(N'2021-10-29T08:34:07.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (201, 31, 28, N'Well ratified by law and heraldry', CAST(N'2021-10-27T07:48:58.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (202, 31, 28, N'Was gaged by our king', CAST(N'2021-10-27T07:52:44.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (203, 21, 28, N'Doth make the night joint-labourer with the day:', CAST(N'2021-10-26T07:50:15.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (204, 31, 28, N'But to recover of us, by strong hand', CAST(N'2021-10-29T07:10:20.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (205, 31, 28, N'In the most high and palmy state of Rome', CAST(N'2021-10-29T08:07:44.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (206, 31, 28, N'So by his father lost: and this, I take it', CAST(N'2021-10-29T07:13:22.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (207, 31, 28, N'Did slay this Fortinbras  who by a seald compact', CAST(N'2021-10-27T07:31:00.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (208, 20, 28, N'Good now, sit down, and tell me, he that knows', CAST(N'2021-10-25T07:06:48.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (209, 31, 28, N'Of unimproved mettle hot and full', CAST(N'2021-10-28T07:17:23.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (210, 31, 28, N'As it doth well appear unto our state--', CAST(N'2021-10-28T08:38:30.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (211, 30, 28, N'In which the majesty of buried Denmark', CAST(N'2021-10-21T08:16:31.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (212, 12, 28, N'How now, Horatio! you tremble and look pale:', CAST(N'2021-10-22T08:09:55.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (213, 31, 28, N'For food and diet, to some enterprise', CAST(N'2021-10-28T08:32:53.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (214, 31, 28, N'The graves stood tenantless and the sheeted dead', CAST(N'2021-10-29T08:25:49.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (215, 19, 28, N'What, has this thing appeard again to-night?', CAST(N'2021-10-15T07:26:12.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (216, 31, 28, N'That hath a stomach int', CAST(N'2021-10-28T08:35:28.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (217, 12, 28, N'See, it stalks away!', CAST(N'2021-10-22T07:36:38.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (218, 19, 28, N'Therefore I have entreated him along', CAST(N'2021-10-16T08:42:06.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (219, 38, 28, N'I think I hear them. Stand, ho! Whos there?', CAST(N'2021-10-12T07:51:38.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (220, 38, 28, N'Give you good night.', CAST(N'2021-10-12T08:37:34.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (221, 32, 28, N'Upon whose influence Neptunes empire stands', CAST(N'2021-10-30T07:08:05.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (222, 30, 28, N'He smote the sledded Polacks on the ice.', CAST(N'2021-10-24T07:32:15.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (223, 12, 28, N'What think you ont?', CAST(N'2021-10-22T08:27:14.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (224, 10, 28, N'Have you had quiet guard?', CAST(N'2021-10-11T08:36:08.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (225, 38, 28, N'You come most carefully upon your hour.', CAST(N'2021-10-10T07:54:27.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (226, 30, 28, N'But in the gross and scope of my opinion', CAST(N'2021-10-24T08:23:40.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (227, 13, 28, N'That was and is the question of these wars.', CAST(N'2021-10-29T07:52:40.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (228, 30, 28, N'Did sometimes march? by heaven I charge thee, speak!', CAST(N'2021-10-21T08:40:30.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (229, 30, 28, N'This bodes some strange eruption to our state.', CAST(N'2021-10-25T07:03:02.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (230, 12, 28, N'Looks it not like the king? mark it, Horatio.', CAST(N'2021-10-20T08:35:59.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (231, 29, 28, N'Well, sit we down', CAST(N'2021-10-18T07:47:20.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (232, 30, 28, N'Such was the very armour he had on', CAST(N'2021-10-24T07:03:54.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (233, 21, 28, N'And foreign mart for implements of war', CAST(N'2021-10-25T08:31:52.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (234, 31, 28, N'At least, the whisper goes so. Our last king', CAST(N'2021-10-26T08:02:52.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (235, 30, 28, N'Together with that fair and warlike form', CAST(N'2021-10-21T08:11:24.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (236, 10, 28, N'If you do meet Horatio and Marcellus', CAST(N'2021-10-12T07:26:31.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (237, 38, 28, N'For this relief much thanks: tis bitter cold', CAST(N'2021-10-11T07:30:41.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (238, 18, 28, N'O, farewell, honest soldier:', CAST(N'2021-10-13T07:03:16.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (239, 32, 28, N'Extorted treasure in the womb of earth', CAST(N'2021-11-01T07:37:59.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (240, 31, 28, N'Did squeak and gibber in the Roman streets:', CAST(N'2021-10-29T08:30:07.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (241, 19, 28, N'Holla! Bernardo!', CAST(N'2021-10-13T08:44:52.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (288, 32, 28, N'And prologue to the omen coming on', CAST(N'2021-10-30T08:27:43.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (289, 31, 28, N'Whose image even but now appeard to us', CAST(N'2021-10-26T08:15:30.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (290, 20, 28, N'So nightly toils the subject of the land', CAST(N'2021-10-25T07:53:44.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (291, 10, 28, N'The rivals of my watch, bid them make haste.', CAST(N'2021-10-12T07:28:59.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (292, 29, 28, N'What, is Horatio there?', CAST(N'2021-10-14T07:44:29.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (293, 13, 28, N'Comes armed through our watch', CAST(N'2021-10-29T07:47:42.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (294, 32, 28, N'', CAST(N'2021-10-31T07:45:58.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (295, 19, 28, N'That if again this apparition come', CAST(N'2021-10-17T07:21:01.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (296, 28, 28, N'Friends to this ground.', CAST(N'2021-10-12T08:07:44.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (297, 31, 28, N'Against the which, a moiety competent', CAST(N'2021-10-27T07:51:40.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (298, 12, 28, N'In the same figure, like the king thats dead.', CAST(N'2021-10-20T07:32:06.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (299, 30, 28, N'Stay! speak, speak! I charge thee, speak!', CAST(N'2021-10-22T07:48:21.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (300, 20, 28, N'Why this same strict and most observant watch', CAST(N'2021-10-25T07:15:57.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (301, 21, 28, N'Why such impress of shipwrights, whose sore task', CAST(N'2021-10-25T08:43:47.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (302, 12, 28, N'It would be spoke to.', CAST(N'2021-10-21T07:31:38.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (303, 19, 28, N'Horatio says tis but our fantasy', CAST(N'2021-10-15T07:35:30.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (304, 32, 28, N'Speak to me:', CAST(N'2021-10-31T08:01:24.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (305, 32, 28, N'If thou hast any sound, or use of voice', CAST(N'2021-10-31T07:58:11.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (306, 32, 28, N'For which, they say, you spirits oft walk in death', CAST(N'2021-11-01T07:56:26.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (307, 31, 28, N'Did forfeit, with his life, all those his lands', CAST(N'2021-10-27T07:49:27.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (308, 11, 28, N'What we have two nights seen.', CAST(N'2021-10-18T07:37:23.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (309, 11, 28, N'Last night of all', CAST(N'2021-10-18T07:57:19.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (310, 29, 28, N'A piece of him.', CAST(N'2021-10-14T07:54:19.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (311, 31, 28, N'Dared to the combat', CAST(N'2021-10-26T08:34:21.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (312, 13, 28, N'I think it be no other but een so:', CAST(N'2021-10-29T07:39:58.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (313, 21, 28, N'What might be toward, that this sweaty haste', CAST(N'2021-10-26T07:49:50.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (314, 11, 28, N'That are so fortified against our story', CAST(N'2021-10-18T07:26:50.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (315, 30, 28, N'Without the sensible and true avouch', CAST(N'2021-10-23T07:17:06.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (316, 20, 28, N'With martial stalk hath he gone by our watch.', CAST(N'2021-10-24T08:18:16.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (317, 31, 28, N'Was, as you know, by Fortinbras of Norway', CAST(N'2021-10-26T08:19:42.000' AS DateTime))
GO
INSERT [dbo].[text_messages] ([id], [sender_id], [receiver_id], [message], [sent]) VALUES (1001, 10, 28, N'Whos there?', CAST(N'2021-10-10T08:37:41.000' AS DateTime))
GO
ALTER TABLE [dbo].[bank_accounts]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer_details] ([id])
GO
ALTER TABLE [dbo].[bank_transactions]  WITH CHECK ADD FOREIGN KEY([account_number_fk])
REFERENCES [dbo].[bank_accounts] ([account_number_pk])
GO
ALTER TABLE [dbo].[cellphone_details]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer_details] ([id])
GO
ALTER TABLE [dbo].[flight_details]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer_details] ([id])
GO
ALTER TABLE [dbo].[text_messages]  WITH CHECK ADD FOREIGN KEY([receiver_id])
REFERENCES [dbo].[cellphone_details] ([id])
GO
ALTER TABLE [dbo].[text_messages]  WITH CHECK ADD FOREIGN KEY([sender_id])
REFERENCES [dbo].[cellphone_details] ([id])
GO
USE [master]
GO
ALTER DATABASE [DigitalEvidence] SET  READ_WRITE 
GO
