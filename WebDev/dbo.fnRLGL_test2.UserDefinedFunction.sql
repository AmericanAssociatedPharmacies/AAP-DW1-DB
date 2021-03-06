USE [WebDev]
GO
/****** Object:  UserDefinedFunction [dbo].[fnRLGL_test2]    Script Date: 12/22/2020 8:08:59 AM ******/
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
CREATE FUNCTION [dbo].[fnRLGL_test2]
--from spRLGL_Calculate3 updated 10/14 BG
	(
		@NCPDP varchar(7), --leading zeros
		@RxNbr nvarchar(50),
		@filldate datetime --smalldatetime	
	)
	RETURNS varchar(15)

AS
	BEGIN

		--SET NOCOUNT ON;
		DECLARE @sReturn varchar(15)

		DECLARE @totalpaid numeric(18,6)
		DECLARE @Qty int
		DECLARE @NDC nvarchar(11)
		DECLARE @Buf nvarchar(11)
		DECLARE @PMID int

		DECLARE @totalcost numeric(18,4)
		DECLARE @costperunit numeric(18,4)
		DECLARE @percent numeric(18,4)


		--Verify NCPDP in Claims data. 
		select top 1 @Buf = [Pharm ID]  FROM Webdev.dbo.Rx30Latest 
			WHERE [Pharm ID]=@NCPDP
		if (@Buf is null)
			BEGIN
				set @sReturn = 'NoNCPDPinRx30L'
				RETURN @sReturn
			END
			
		--Find the NDC,TotalPaid,Qty from Rx30 Claims
		Select @totalpaid = [Total Price],@Qty = [Qty Dispensed],@NDC = NDC FROM Webdev.dbo.Rx30Latest 
			WHERE [Pharm ID]=@NCPDP AND [Rx Nbr]=@RxNbr AND [Rx Date] = @filldate 
		if (@totalpaid is null)
			BEGIN
				set @sReturn = 'NoClaimInRx30L'
				RETURN @sReturn
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
						set @sReturn = 'GREEN'
						RETURN @sReturn
					END
				ELSE
					BEGIN
						set @sReturn = 'RED'
						RETURN @sReturn
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
						set @sReturn = 'NoPMID'
						RETURN @sReturn
					END				

				--Store Rebate for that month
				--Select @percent =  (1-(CHRebatePerc)) FROM Purchases.dbo.CHRebates WHERE PMID=@pmid AND [Month]= Month(@filldate) AND [Year] = Year(@filldate) ORDER BY Year ASC,Month ASC 
				--added top 1 to support orderby
				Select top 1  
					@percent =  isnull(CHRebatePerc,0) FROM Purchases.dbo.CHRebates WHERE PMID=@pmid 
					AND [Month]= Month(@filldate) AND [Year] = Year(@filldate) 
					AND CHRebatePerc is not null
					AND DATALENGTH(CHRebatePerc) > 0
					ORDER BY Year DESC,Month DESC 
				
				--if store rebate is null for the requested month get the latest rebate available
				if (@percent = 0) OR Datalength(@percent) IS NULL
				BEGIN
					Select top 1
					@percent =   CHRebatePerc FROM Purchases.dbo.CHRebates 
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
								set @sReturn = 'Green'
								RETURN @sReturn
							END 
						ELSE
							BEGIN
								set @sReturn = 'Red'
								RETURN @sReturn
							END
					END
				Else --if No Pricing found in CAH
					BEGIN
						set @sReturn = 'NoPriceForNDC'
						RETURN @sReturn
					END

			END
			RETURN @sReturn
END					

			
















GO
