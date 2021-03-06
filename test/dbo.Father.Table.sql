USE [test]
GO
/****** Object:  Table [dbo].[Father]    Script Date: 12/22/2020 8:07:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Father](
	[Father_id] [smallint] IDENTITY(1,1) NOT NULL,
	[Father_Name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Father_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
