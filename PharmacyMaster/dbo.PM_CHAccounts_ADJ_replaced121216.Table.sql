USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_CHAccounts_ADJ_replaced121216]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_CHAccounts_ADJ_replaced121216](
	[PMID] [int] NOT NULL,
	[Marker] [bit] NULL,
	[Status] [varchar](32) NULL,
	[DEA] [varchar](50) NULL,
	[Name] [varchar](255) NULL,
	[AKA] [varchar](255) NULL,
	[APIAccountNo] [varchar](20) NULL,
	[AAPAccountNo] [varchar](20) NULL,
	[AAPParentNo] [varchar](20) NULL,
	[UDAccountNo] [varchar](20) NULL,
	[IsMCAOnFile] [bit] NULL,
	[BusCls] [varchar](25) NULL,
	[Affiliate] [varchar](125) NULL,
	[CHParentCode] [varchar](25) NULL,
	[Division] [varchar](25) NULL,
	[DC] [varchar](100) NULL,
	[CHAccountNoPrimary] [varchar](50) NULL,
	[CHAccountNo2] [varchar](50) NULL,
	[CHAccountNo3] [varchar](50) NULL,
	[POSAcct] [varchar](50) NULL,
	[ScanTossAcct] [varchar](50) NULL,
	[CSOSAcct] [varchar](50) NULL,
	[AAPContractDate] [datetime] NULL,
	[TerminationDate] [datetime] NULL,
	[IsMultipleStore] [bit] NULL,
	[MultipleStoreCode] [varchar](50) NULL,
	[GroupCode] [varchar](50) NULL,
	[CurrEstMoSales] [numeric](18, 2) NULL,
	[CurrGroupTotal] [numeric](18, 2) NULL,
	[EstVolAtLoad] [numeric](18, 2) NULL,
	[LastReviewDate] [datetime] NULL,
	[CurrAPICOG] [numeric](18, 4) NULL,
	[CurrCHCOG] [numeric](18, 4) NULL,
	[IsQPSStore] [bit] NULL,
	[PayTermsDesc] [varchar](255) NULL,
	[PayTermsCode] [varchar](50) NULL,
	[IsPendingChanges] [bit] NULL,
	[NotesCOGDifferences] [varchar](255) NULL,
	[Notes] [varchar](255) NULL,
	[Territory] [varchar](10) NULL,
	[IsExcptToMatrix] [bit] NULL,
	[IsOptionalPayTerms] [bit] NULL,
	[IsFrontLoadNoReb] [bit] NULL,
	[WAPD] [numeric](18, 2) NULL,
	[DSO] [numeric](18, 2) NULL,
	[LastUpdate] [datetime] NULL,
	[WAPD2ndAcct] [numeric](18, 2) NULL,
	[DSO2ndAcct] [numeric](18, 2) NULL,
	[IsSublogicChange] [bit] NULL,
	[NotesOnTerms] [varchar](255) NULL,
	[ChangePending] [varchar](255) NULL,
	[ContractedDSO] [numeric](18, 2) NULL,
	[SecondDivision] [varchar](50) NULL,
	[SecondPrimaryNumber] [varchar](50) NULL,
	[Second2nd] [varchar](50) NULL,
	[Second3rd] [varchar](50) NULL,
	[SecondPOS] [varchar](50) NULL,
	[SecondCSOS] [varchar](50) NULL,
	[SecondCST] [varchar](50) NULL,
	[ThirdDivision] [varchar](50) NULL,
	[ThirdPrimaryNumber] [varchar](50) NULL,
	[Third2nd] [varchar](50) NULL,
	[ThirdPOS] [varchar](50) NULL,
	[ThirdCSOS] [varchar](50) NULL,
	[ThirdCST] [varchar](50) NULL,
	[MatrixName] [varchar](255) NULL,
	[CAMasterNumber] [varchar](255) NULL,
 CONSTRAINT [PK_PMCHAccounts_PMID_11302016_101739] PRIMARY KEY CLUSTERED 
(
	[PMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
