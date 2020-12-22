USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[ChangeofOwnershipInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChangeofOwnershipInformation](
	[ChangeOfOwnershipKey] [int] IDENTITY(1,1) NOT NULL,
	[NCPDPProviderID] [varchar](7) NULL,
	[OldNCPDPProviderID] [varchar](7) NULL,
	[OldStoreCloseDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[ChangeofOwnershipEffectiveDate] [varchar](8) NULL,
 CONSTRAINT [CPK_ChangeofOwnershipInformation] PRIMARY KEY CLUSTERED 
(
	[ChangeOfOwnershipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChangeofOwnershipInformation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
