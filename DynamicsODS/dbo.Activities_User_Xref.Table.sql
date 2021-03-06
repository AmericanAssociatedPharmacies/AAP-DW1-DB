USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[Activities_User_Xref]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activities_User_Xref](
	[ActivitiesKey] [int] NOT NULL,
	[UserKey] [int] NOT NULL,
 CONSTRAINT [CPK_Activities_User_Xref] PRIMARY KEY CLUSTERED 
(
	[ActivitiesKey] ASC,
	[UserKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
