USE [ClaimsDDS]
GO
/****** Object:  Table [Staging].[ClaimFactFDSIsPaidClaim]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ClaimFactFDSIsPaidClaim](
	[DateofServiceKey] [int] NOT NULL,
	[PharmacyKey] [int] NOT NULL,
	[DrugKey] [int] NOT NULL,
	[EventKey] [int] NOT NULL,
	[IsPaidClaim] [bit] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_ClaimFactFDS] PRIMARY KEY CLUSTERED 
(
	[DateofServiceKey] ASC,
	[PharmacyKey] ASC,
	[DrugKey] ASC,
	[EventKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psClaimsFact_RangeLeft]([DateofServiceKey])
) ON [psClaimsFact_RangeLeft]([DateofServiceKey])
GO
ALTER TABLE [Staging].[ClaimFactFDSIsPaidClaim] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
