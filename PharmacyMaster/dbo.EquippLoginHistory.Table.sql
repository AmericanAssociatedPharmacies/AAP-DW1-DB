USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[EquippLoginHistory]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquippLoginHistory](
	[NPI] [nvarchar](50) NULL,
	[Group Name] [nvarchar](50) NULL,
	[Participant Name] [nvarchar](50) NULL,
	[Action] [nvarchar](50) NULL,
	[Action Time] [nvarchar](50) NULL
) ON [PRIMARY]
GO
