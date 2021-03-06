USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spArete_DIRFeesSummary]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Vrindha Nair
-- Create date: 07/15/2016
-- Description:	DIR Fees Summary
-- =============================================
CREATE PROCEDURE [dbo].[spArete_DIRFeesSummary] 
(
	@pbm NVARCHAR(200), @ncpdp NVARCHAR(7)
)
	
	
AS
BEGIN
	
	SET NOCOUNT ON;


	   if @pbm = 'Prime'
	BEGIN

			SELECT [Plan PBM],(SELECT COUNT(NCPDP) FROM dbo.DIRDetails_Prime WHERE NCPDP = @ncpdp ) AS [# of Claims], 
			(SELECT sum(CAST([Conc Fee] AS FLOAT)) FROM dbo.DIRDetails_Prime WHERE NCPDP = @ncpdp) AS [Total DIR], 
			[DIR or Fee],[Plans Included ], [Program Info  Link], [Collection Schedule], [DIR Fee Basis per Qtr] FROM [dbo].[DIRFeesSummary] WHERE [Plan PBM] = 'Prime Therapeutics'
	END

		if @pbm = 'Magellan'
	BEGIN
		  
			SELECT [Plan PBM],(SELECT COUNT(pharmacy_ncpdp) FROM dbo.DIRDetails_MagellanRx WHERE pharmacy_ncpdp = @ncpdp ) AS [# of Claims], 
			(SELECT (COUNT(pharmacy_ncpdp)*3.0) FROM dbo.DIRDetails_MagellanRx WHERE pharmacy_ncpdp = @ncpdp ) AS [Total DIR], 
			[DIR or Fee], [Plans Included ], [Program Info  Link], [Collection Schedule], [DIR Fee Basis per Qtr] FROM [dbo].[DIRFeesSummary] WHERE [Plan PBM] = 'MagellanRx'

	END

	
		if @pbm = 'Envision'
	BEGIN
		   SELECT ds.[Plan PBM], dd.[Net Claims Count] AS [# of Claims], dd.[DIR Fee Owed] AS [Total DIR],
		   ds.[DIR or Fee], ds.[Plans Included ], ds.[Program Info  Link], ds.[Collection Schedule], ds.[DIR Fee Basis per Qtr] 
			FROM WebDev.dbo.DIRDetails_Envision dd, WebDev.dbo.DIRFeesSummary ds WHERE ds.[Plan PBM] = 'Envision RxOptions'AND dd.[NCPDP #] = @ncpdp
	END


	if @pbm = 'Aetna'
	BEGIN
	       SELECT [Plan PBM],(SELECT COUNT(PharmacyNABP) FROM dbo.DIRDetails_Aetna WHERE PharmacyNABP = @ncpdp ) AS [# of Claims], 
		   (SELECT sum(CAST([DIRAmount] AS FLOAT)) FROM dbo.DIRDetails_Aetna WHERE PharmacyNABP = @ncpdp) AS [Total DIR], 
		   [DIR or Fee],[Plans Included ], [Program Info  Link], [Collection Schedule], [DIR Fee Basis per Qtr] FROM [dbo].[DIRFeesSummary] WHERE [Plan PBM] = 'Aetna (Caremark)'

	END

			 if @pbm = 'ESIPDP'
	BEGIN

			SELECT [Plan PBM],(SELECT sum(CAST([Total_Claims] AS FLOAT)) FROM dbo.DIRDetails_ESIMedicare WHERE [nabp_nbr] = @ncpdp ) AS [# of Claims], 
			(SELECT sum(CAST([DIR 1Q2016] AS FLOAT)) FROM dbo.DIRDetails_ESIMedicare WHERE [nabp_nbr] = @ncpdp) AS [Total DIR], 
			[DIR or Fee],[Plans Included ], [Program Info  Link], [Collection Schedule], [DIR Fee Basis per Qtr] FROM [dbo].[DIRFeesSummary] WHERE [Plan PBM] = 'ESI PDP'

	END

			 if @pbm = 'CVS'
	BEGIN

			SELECT ds.[Plan PBM], dd.[Total DIR fee per Trimester] AS [Total DIR],
			ds.[DIR or Fee], ds.[Plans Included ], ds.[Program Info  Link], ds.[Collection Schedule], ds.[DIR Fee Basis per Qtr] 
			FROM WebDev.dbo.DIRDetails_CVSCaremark dd, WebDev.dbo.DIRFeesSummary ds WHERE ds.[Plan PBM] = 'CVS/Caremark' AND dd.NCPDP = @ncpdp
	END
	 
	/* if @pbm = 'Anthem'
	BEGIN
		
			SELECT [Plan PBM],(SELECT COUNT(NABP) FROM dbo.DIRDetails_ESIAnthem WHERE NABP = @ncpdp ) AS [# of Claims], 
			(SELECT [TOTAL_FEE] FROM dbo.DIRDetails_ESIAnthem WHERE NABP = @ncpdp) AS [Total DIR], 
			[DIR or Fee],[Plans Included ], [Program Info  Link], [Collection Schedule], [DIR Fee Basis per Qtr] FROM [dbo].[DIRFeesSummary] WHERE [Plan PBM] = 'ESI (ANTHEM)'


	END

		if @pbm = 'Scan'
	BEGIN
		   SELECT ds.[Plan PBM], dd.TOTAL_CLAIMS AS [# of Claims], dd.TOTAL_FEE AS [Total DIR],
		   ds.[DIR or Fee], ds.[Plans Included ], ds.[Program Info  Link], ds.[Collection Schedule], ds.[DIR Fee Basis per Qtr] 
			FROM WebDev.dbo.DIRDetails_ESIScan dd, WebDev.dbo.DIRFeesSummary ds WHERE ds.[Plan PBM] = 'ESI (SCAN)'AND dd.NCPDP = @ncpdp
	END */


		 
	 --SELECT * FROM [dbo].[DIRFeesSummary]
			
END
GO
