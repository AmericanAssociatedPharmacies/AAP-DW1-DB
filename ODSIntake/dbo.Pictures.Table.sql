USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Pictures]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pictures](
	[pictureName] [nvarchar](40) NOT NULL,
	[picFileName] [nvarchar](100) NULL,
	[PictureData] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[pictureName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
