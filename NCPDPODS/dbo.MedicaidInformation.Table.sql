USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[MedicaidInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicaidInformation](
	[MedicaidKey] [int] IDENTITY(1,1) NOT NULL,
	[NCPDPProviderID] [varchar](7) NULL,
	[StateCode] [varchar](2) NULL,
	[MedicaidID] [varchar](20) NULL,
	[DeleteDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_MedicaidInformation] PRIMARY KEY CLUSTERED 
(
	[MedicaidKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MedicaidInformation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
