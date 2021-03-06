USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyControlEntityCert]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyControlEntityCert](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ControlEntityId] [int] NULL,
	[CertName] [nvarchar](150) NULL,
	[CertType] [nvarchar](150) NULL,
	[CertProfession] [nvarchar](150) NULL,
	[CertNumber] [nvarchar](150) NULL,
	[IssuedDate] [smalldatetime] NULL,
	[ExpiredDate] [smalldatetime] NULL,
	[StateIssued] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsSubmitted] [bit] NULL,
 CONSTRAINT [PK_SurveyControlEntityCert] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SurveyControlEntityCert] ADD  CONSTRAINT [DF_SurveyControlEntityCert_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SurveyControlEntityCert] ADD  CONSTRAINT [DF_SurveyControlEntityCert_IsSubmitted]  DEFAULT ((0)) FOR [IsSubmitted]
GO
