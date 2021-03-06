USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRLGL_UPStatus_Export]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		JOSHILA NARAYANAN
-- return all tracked claims for the ncpdp if rxnum=0, 
--   else return the tracking info for that rxnum+filldate, or rxnum only if filldate=0
-- modified 10/3/14 BGrant modified 1/2015? to include state mac
-- spRLGL_UPStatus_Export same as spRLGL_UPStatus except calls fnUPStatusResult_Export to omit html tags bg 4/23/15
-- =============================================
CREATE PROCEDURE [dbo].[spRLGL_UPStatus_Export]
(
		@NCPDP nvarchar(10),
		@RxNbr nvarchar(50),  --if blank return all
		@filldatearg nvarchar(15), --use varchar to allow blank
		@includeStateMACif1 int --0 or 1
)

AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @RxDate datetime;

	if (ISNULL(@RxNbr,0) = 0 OR DATALENGTH(@RxNbr) = 0 ) --return all
		BEGIN
			Select  
			--BIN, 
			case when PlanName is null then 'BIN:' + BIN else PlanName end as [Plan]
			,RxNbr 
			,convert(varchar(12),RxDate,1) as RxDate
			,Status
			,convert(varchar(12),UpdatedOn,1) as Updated
			--Result
			,case when @includeStateMACif1 = 1 then
			dbo.fnUPStatusResult_Export(Result,APIPriceStatus,CAHPriceStatus,Notes) 
			else
			dbo.fnUPStatusResult_Export(Result,APIPriceStatus,CAHPriceStatus,null) 
			end as Result
			,left(Source,1) + ' ' + convert(varchar(12),CreatedOn ,1) as Source
			--,convert(varchar(12),CreatedOn ,1) as Created 
			--,NDC
			,DrugName
			from UPStatus WHERE (PharmID = @NCPDP) 
			--ORDER BY Status DESC,PlanName ASC,RxNbr ASC
			ORDER BY UpdatedOn DESC,RxNbr ASC
		END
	ELSE
		BEGIN
			if (ISNULL(@RxDate,0) = 0 OR DATALENGTH(@RxDate) = 0 ) --return all dates for rxnum
			BEGIN
				Select  
				--BIN, 
				case when PlanName is null then 'BIN:' + BIN else PlanName end as [Plan]
				,RxNbr 
				,convert(varchar(12),RxDate,1) as RxDate
				,Status
				,convert(varchar(12),UpdatedOn,1) as Updated
				,case when @includeStateMACif1 = 1 then
				dbo.fnUPStatusResult_Export(Result,APIPriceStatus,CAHPriceStatus,Notes) 
				else
				dbo.fnUPStatusResult_Export(Result,APIPriceStatus,CAHPriceStatus,null) 
				end as Result
				,left(Source,1) + ' ' + convert(varchar(12),CreatedOn ,1) as Source
				--,convert(varchar(12),CreatedOn ,1) as Created 
				--,NDC
				,DrugName	
  				from WebDev.dbo.UPStatus WHERE (PharmID = @NCPDP) 
  				AND (RxNbr = @RxNbr or SUBSTRING(RxNbr, PATINDEX('%[^0]%', RxNbr+'.'), LEN(RxNbr)) = @RxNbr) --leading zeros
  				--AND RxDate = @FillDate
  			END
			ELSE  --return rxnum+rxdate match
			BEGIN
				set @RxDate = convert(datetime,@filldatearg)
				Select  
				--BIN, 
				case when PlanName is null then 'BIN:' + BIN else PlanName end as [Plan]
				,RxNbr 
				,convert(varchar(12),RxDate,1) as RxDate
				,Status
				,convert(varchar(12),UpdatedOn,1) as Updated
				,case when @includeStateMACif1 = 1 then
				dbo.fnUPStatusResult_Export(Result,APIPriceStatus,CAHPriceStatus,Notes) 
				else
				dbo.fnUPStatusResult_Export(Result,APIPriceStatus,CAHPriceStatus,null) 
				end as Result
				,left(Source,1) + ' ' + convert(varchar(12),CreatedOn ,1) as Source
				--,convert(varchar(12),CreatedOn ,1) as Created 
				--,NDC
				,DrugName	
  				from WebDev.dbo.UPStatus WHERE (PharmID = @NCPDP) 
  				AND (RxNbr = @RxNbr or SUBSTRING(RxNbr, PATINDEX('%[^0]%', RxNbr+'.'), LEN(RxNbr)) = @RxNbr) --leading zeros
  				AND RxDate = @RxDate
  			END
		END
		
END


GO
