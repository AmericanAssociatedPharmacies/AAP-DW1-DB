USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[CM_DistributionEmail]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CM_DistributionEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](150) NOT NULL,
	[DistributionEmails] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CM_DistributedEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
