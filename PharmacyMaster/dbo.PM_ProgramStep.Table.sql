USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_ProgramStep]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_ProgramStep](
	[ProgramStepID] [int] IDENTITY(1,1) NOT NULL,
	[ProgramID] [int] NULL,
	[StepSeq] [int] NULL,
	[StepName] [nvarchar](100) NULL,
 CONSTRAINT [PK_PM_ProgramStep] PRIMARY KEY CLUSTERED 
(
	[ProgramStepID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
