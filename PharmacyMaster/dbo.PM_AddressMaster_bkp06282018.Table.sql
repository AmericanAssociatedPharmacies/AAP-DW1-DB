USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_AddressMaster_bkp06282018]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_AddressMaster_bkp06282018](
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
	[RowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PM_AddressMaster] PRIMARY KEY CLUSTERED 
(
	[PK_AddressMaster] ASC,
	[PMID] ASC,
	[Address_Type_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_AddressMaster_bkp06282018] ADD  CONSTRAINT [DF__PM_Addres__Creat__43E1002F]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_AddressMaster_bkp06282018] ADD  CONSTRAINT [DF__PM_Addres__Modif__44D52468]  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_AddressMaster_bkp06282018] ADD  CONSTRAINT [DF__PM_Addres__RowVe__45C948A1]  DEFAULT ((1)) FOR [RowVersion]
GO
