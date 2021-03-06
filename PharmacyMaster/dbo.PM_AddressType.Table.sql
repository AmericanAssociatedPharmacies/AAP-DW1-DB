USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_AddressType]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_AddressType](
	[address_type_id] [int] NOT NULL,
	[address_type_description] [varchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
	[address_type] [int] NULL
) ON [PRIMARY]
GO
