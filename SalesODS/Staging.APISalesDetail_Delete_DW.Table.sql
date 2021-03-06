USE [SalesODS]
GO
/****** Object:  Table [Staging].[APISalesDetail_Delete_DW]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[APISalesDetail_Delete_DW](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[WHAccountID] [varchar](100) NULL,
	[InvNumber] [varchar](250) NULL,
	[InvDate] [datetime] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Staging_APISalesDetail_Delete_D] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
