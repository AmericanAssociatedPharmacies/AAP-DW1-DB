USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRLGL_Calculate3_101414]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/* =============================================
-- Author:		JOSHILA NARAYANAN modified 10/15/13 BGrant
-- Create date: 10/01/2013
-- revised 5/14/14 BG to extend price checks to last 6 months
-- Description:	Red Light Green Light
-- todo: change case of RED GREEN to Red Green
-- ============================================= */
CREATE PROCEDURE [dbo].[spRLGL_Calculate3_101414]

	(
		--@NCPDP int,
		@NCPDP varchar(7), --leading zeros
		@RxNbr nvarchar(50),
		@filldate datetime --smalldatetime	
	)
	
AS
	BEGIN

		SET NOCOUNT ON;

		DECLARE @totalpaid numeric(18,6)
		DECLARE @Qty int
		DECLARE @NDC nvarchar(11)
		DECLARE @PMID int

		DECLARE @totalcost numeric(18,4)
		DECLARE @costperunit numeric(18,4)
		DECLARE @percent numeric(18,4)


		--Verify NCPDP in Claims data. Note @NDC used as buffer here
		select top 1 @NDC = [Pharm ID]  FROM Webdev.dbo.Rx30Latest 
			WHERE [Pharm ID]=@NCPDP
		if (@NDC is null)
			BEGIN
				Select 'NoNCPDP' as result,NULL as unitcost
				RETURN 0
			END
			
		--Find the NDC,TotalPaid,Qty from Rx30 Claims
		Select @totalpaid = [Total Price],@Qty = [Qty Dispensed],@NDC = NDC FROM Webdev.dbo.Rx30Latest 
			WHERE [Pharm ID]=@NCPDP AND [Rx Nbr]=@RxNbr AND [Rx Date] = @filldate 
		if (@totalpaid is null)
			BEGIN
				Select 'NoClaim' as result,NULL as unitcost
				RETURN 0
			END
		
		--API CHECK
		--Select @costperunit = ISNULL(NetPerUnit,0) from Purchases.dbo.v_APIRebates WHERE NDC=@ndc AND Mnth = Month(@filldate) AND Yr = Year(@filldate)
		Select top 1 @costperunit = ISNULL(NetPerUnit,0) from Purchases.dbo.v_APIRebatesWeekly WHERE NDC=@ndc 
			AND Mnth >= dbo.fnRLGL_Pricedate(Month(@filldate),Year(@filldate),0)
			AND Yr >= dbo.fnRLGL_Pricedate(Month(@filldate),Year(@filldate),1)			
			Order by Yr desc,Mnth desc, WeekNo desc
		if (@costperunit != 0 )
			--USE API
			BEGIN				
				if @totalpaid > (@costperunit * @Qty) 
					BEGIN
						Select 'GREEN' as result,@costperunit as unitcost
					END
				ELSE
					BEGIN
						Select 'RED' as result,@costperunit as unitcost
					END
			END
		Else
		--CARDINAL CHECK
			BEGIN
				--set @costperunit = 0
			Select top 1 
				@PMID=PMID FROM PharmacyMaster.dbo.v_PM_AllWithAffiliates WHERE NCPDP=@NCPDP 
				--AND (PharmacyMaster.dbo.v_PM_AllWithAffiliates.AAPQuitDate IS NULL) AND 
				--		  (PharmacyMaster.dbo.v_PM_AllWithAffiliates.AAPAccountNo IS NOT NULL)
				order by PMID desc
				if (@PMID is null)
					BEGIN
						Select 'NoPMID' as result,NULL as unitcost
						RETURN 0
					END				

				--Store Rebate for that month
				--Select @percent =  (1-(CHRebatePerc)) FROM Purchases.dbo.CHRebates WHERE PMID=@pmid AND [Month]= Month(@filldate) AND [Year] = Year(@filldate) ORDER BY Year ASC,Month ASC 
				--added top 1 to support orderby
				Select top 1  
					@percent =  isnull(CHRebatePerc,0) 
					FROM Purchases.dbo.CHRebates WHERE PMID=@pmid 
					AND [Month]= Month(@filldate) AND [Year] = Year(@filldate) 
					AND CHRebatePerc is not null
					AND DATALENGTH(CHRebatePerc) > 0
					ORDER BY Year DESC,Month DESC 
				
				--if store rebate is null for the requested month get the latest rebate available
				if (@percent = 0) OR Datalength(@percent) IS NULL
				BEGIN
					Select top 1
					@percent =  isnull(CHRebatePerc,0) 
					FROM Purchases.dbo.CHRebates 
					WHERE PMID=@pmid 
					and CHRebatePerc is not null
					AND DATALENGTH(CHRebatePerc) > 0
					ORDER BY Year DESC,Month DESC
				END

				--CAH Price
				Select top 1  @costperunit = isnull(PricePerUnit,0) FROM Purchases.dbo.v_CHAllWeek
					WHERE NDC=@ndc 
					AND [Month] >= dbo.fnRLGL_Pricedate(Month(@filldate),Year(@filldate),0)
					AND [Year] >= dbo.fnRLGL_Pricedate(Month(@filldate),Year(@filldate),1)
					Order by [Year] desc,[Month] desc,WeekNo desc
								
				if (@costperunit != 0 )
					BEGIN
						--print 'CAH2'
						if @totalpaid > ((@costperunit * @Qty)  * (1.0 - @percent)) 
							BEGIN
								Select 'Green' as result,@costperunit  as unitcost
							END 
						ELSE
							BEGIN
								Select 'Red' as result,@costperunit as unitcost
							END
					END
				Else --if No Pricing found in CAH
					BEGIN
						Select 'NoPrice' as result,NULL as unitcost
					END

			END
			RETURN 1
END					

			
















GO
