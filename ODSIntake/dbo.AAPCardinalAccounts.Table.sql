USE [ODSIntake]
GO
/****** Object:  Table [dbo].[AAPCardinalAccounts]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AAPCardinalAccounts](
	[PMID] [varchar](500) NULL,
	[Status] [varchar](500) NULL,
	[DEA#] [varchar](500) NULL,
	[Customer Name] [varchar](500) NULL,
	[AKA] [varchar](500) NULL,
	[API acct] [varchar](500) NULL,
	[AAP Number] [varchar](500) NULL,
	[AAP Parent#] [varchar](500) NULL,
	[MCA on File] [varchar](500) NULL,
	[Bs Class] [varchar](500) NULL,
	[AAP Affiliate] [varchar](500) NULL,
	[CA Master Number] [varchar](500) NULL,
	[CAH Multi Store Code] [varchar](500) NULL,
	[Cardinal Division#] [varchar](500) NULL,
	[Cardinal DC] [varchar](500) NULL,
	[Primary CA Acct#] [varchar](500) NULL,
	[2nd Cardinal cust] [varchar](500) NULL,
	[3rd Cardinal cust] [varchar](500) NULL,
	[POS Acct] [varchar](500) NULL,
	[Scan-Toss Acct] [varchar](500) NULL,
	[CSOS Acct] [varchar](500) NULL,
	[AAP Contract Date] [varchar](500) NULL,
	[Termination Date] [varchar](500) NULL,
	[Multiple Store] [varchar](500) NULL,
	[Multiple Store Code] [varchar](500) NULL,
	[Group Code] [varchar](500) NULL,
	[Current Est Mo Sales] [varchar](500) NULL,
	[Current Grp Total] [varchar](500) NULL,
	[Est Volume at Load] [varchar](500) NULL,
	[Last Review Date] [varchar](500) NULL,
	[Current API COG] [varchar](500) NULL,
	[Current CA COG] [varchar](500) NULL,
	[Clawback bps] [varchar](500) NULL,
	[Delivery bps] [varchar](500) NULL,
	[Payment Terms description] [varchar](500) NULL,
	[Payment Terms Code] [varchar](500) NULL,
	[CAH terms Code Desc] [varchar](500) NULL,
	[Pending Changes] [varchar](500) NULL,
	[Change Pending] [varchar](500) NULL,
	[Notes COG Differences] [varchar](500) NULL,
	[Notes] [varchar](500) NULL,
	[AAP Rep] [varchar](500) NULL,
	[Excpt to Matrix] [varchar](500) NULL,
	[Excpt Code] [varchar](500) NULL,
	[Optional Pay Terms] [varchar](500) NULL,
	[Notes on Terms] [varchar](500) NULL,
	[Contracted DSO] [varchar](500) NULL,
	[Sublogic Change] [varchar](500) NULL,
	[High Volume Rebate] [varchar](500) NULL,
	[Est Annual Vol on comn own] [varchar](500) NULL,
	[Matrix Name] [varchar](500) NULL,
	[Avg Mo Gen Compliance] [varchar](500) NULL,
	[MCR Mo Volume for COG] [varchar](500) NULL,
	[MCR Month] [varchar](500) NULL,
	[MCR Percentage] [varchar](500) NULL,
	[Date Rcvd New MC] [varchar](500) NULL,
	[Effective Date New Agmt] [varchar](500) NULL,
	[New Agmt Type] [varchar](500) NULL,
	[MC AMQP] [varchar](500) NULL,
	[MC AMGC%] [varchar](500) NULL,
	[MC COG] [varchar](500) NULL,
	[MC Terms] [varchar](500) NULL
) ON [PRIMARY]
GO
