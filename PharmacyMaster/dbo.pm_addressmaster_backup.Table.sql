USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[pm_addressmaster_backup]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pm_addressmaster_backup](
	[PK_AddressMaster] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[Address_Type_Id] [int] NOT NULL,
	[Address] [varchar](100) NULL,
	[Address2] [varchar](100) NULL,
	[City] [varchar](50) NULL,
	[County] [varchar](100) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](50) NULL,
	[ContactFullName] [varchar](255) NULL,
	[Fax] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[AlternatePhone] [varchar](12) NULL,
	[Email] [varchar](150) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
