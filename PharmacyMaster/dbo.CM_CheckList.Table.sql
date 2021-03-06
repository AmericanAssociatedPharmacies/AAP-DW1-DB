USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[CM_CheckList]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CM_CheckList](
	[Id] [int] NOT NULL,
	[Group] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NOT NULL,
	[GroupTitle] [nvarchar](200) NULL,
	[IsHeaderGroup] [bit] NULL,
	[Select] [bit] NULL,
	[Query] [nvarchar](300) NULL,
	[Tags] [nvarchar](300) NULL,
	[ListOrder] [int] NULL,
	[DisableCheckLists] [nvarchar](300) NULL,
	[EnableDependCheckLists] [nvarchar](300) NULL,
	[ToolTip] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_com_CheckList] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
