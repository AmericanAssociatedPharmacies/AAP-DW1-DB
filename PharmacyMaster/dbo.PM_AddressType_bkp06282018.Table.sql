USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_AddressType_bkp06282018]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_AddressType_bkp06282018](
	[address_type_id] [int] NOT NULL,
	[address_type_description] [varchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
	[address_type] [int] NULL,
 CONSTRAINT [PK_PM_AddressType] PRIMARY KEY CLUSTERED 
(
	[address_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_AddressType_bkp06282018] ADD  CONSTRAINT [DF__PM_Addres__Creat__6CE315C2]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_AddressType_bkp06282018] ADD  CONSTRAINT [DF__PM_Addres__Modif__6DD739FB]  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_AddressType_bkp06282018] ADD  CONSTRAINT [DF__PM_Addres__RowVe__6ECB5E34]  DEFAULT ((1)) FOR [RowVersion]
GO
