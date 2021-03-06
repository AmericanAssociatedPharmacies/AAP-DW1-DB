USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PartnerDetails]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerDetails](
	[vendor_id] [smallint] IDENTITY(1,1) NOT NULL,
	[PPFeeNote] [nvarchar](24) NULL,
	[VENDOR] [nvarchar](56) NULL,
	[Website Program Description] [nvarchar](586) NULL,
	[MemberDeal] [nvarchar](863) NULL,
	[PurchaseIncentive] [nvarchar](34) NULL,
	[PPContract Billed] [nvarchar](12) NULL,
	[PPContract Pd] [ntext] NULL,
	[Contract Pricing Start Date] [datetime] NULL,
	[Contract Pricing End Date] [datetime] NULL,
	[Corporate Rebate] [nvarchar](251) NULL,
	[Pat Rebate] [nvarchar](3) NULL,
	[Rebate To FPN] [nvarchar](173) NULL,
	[Rebate From FPN to United] [nvarchar](177) NULL,
	[CustomerServicePhone] [nvarchar](17) NULL,
	[Customer Service Toll Free] [nvarchar](26) NULL,
	[Customer Service Fax] [nvarchar](27) NULL,
	[CustomerServiceE-mail] [nvarchar](66) NULL,
	[WEBSITE] [nvarchar](75) NULL,
	[CorpAddr1] [nvarchar](39) NULL,
	[CorpAddr2] [nvarchar](15) NULL,
	[CorpCity] [nvarchar](16) NULL,
	[CorpSt] [nvarchar](2) NULL,
	[CorpZip] [nvarchar](10) NULL,
	[CORP800] [nvarchar](28) NULL,
	[CorpPhone] [nvarchar](20) NULL,
	[CorpFax] [nvarchar](27) NULL,
	[Last Modified] [datetime] NULL,
	[Why Modified] [nvarchar](255) NULL,
	[PPContract  Effective] [datetime] NULL,
	[PPContract  Expiration] [datetime] NULL,
	[Marketing Package] [nvarchar](9) NULL,
	[Tier] [nvarchar](27) NULL,
	[PreferedPartnerSince] [smallint] NULL,
	[Contract Term Date] [datetime] NULL,
	[Active] [nvarchar](3) NULL,
	[PIPCo Program] [nvarchar](3) NULL,
	[United PIPCoUses] [nvarchar](3) NULL,
	[NotesPPPStatus] [nvarchar](648) NULL,
	[Vendor Type] [nvarchar](42) NULL,
	[Annual Renewal LetterSent] [nvarchar](3) NULL,
	[Welcome E-mail Infor Form] [nvarchar](1) NULL,
	[InfoFormReturned] [nvarchar](1) NULL,
	[WelcomeLetterMarketingCalendar] [nvarchar](1) NULL,
	[MKt BannerStart Date] [datetime] NULL,
	[Mkt BannerEnd Date] [datetime] NULL,
	[SSI] [nvarchar](3) NULL,
	[Spin Reports United] [nvarchar](1) NULL,
	[Spin Reports Partner] [nvarchar](1) NULL,
	[Spin Report Notes] [nvarchar](521) NULL,
	[Spin Reports N A] [nvarchar](1) NULL,
	[Spin Reports FPN] [nvarchar](1) NULL,
	[DirectorySent] [nvarchar](1) NULL,
	[LinkedURL] [nvarchar](213) NULL,
	[Phone Website] [nvarchar](42) NULL,
	[RFP] [nvarchar](1) NULL,
	[Purchase From] [nvarchar](46) NULL,
 CONSTRAINT [PK_PartnerDetails] PRIMARY KEY CLUSTERED 
(
	[vendor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
