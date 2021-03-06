USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRLGL_UPStatus_v1]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JOSHILA NARAYANAN
-- return all tracked claims for the ncpdp if rxnum=0, else return the tracking info for that rxnum+filldate
-- =============================================
CREATE PROCEDURE [dbo].[spRLGL_UPStatus_v1]
(
		@NCPDP nvarchar(10),
		@RxNbr nvarchar(50),  --was 11
		@filldate datetime	
)
--deprecated 10/14 bg
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (ISNULL(@RxNbr,0) = 0 OR DATALENGTH(@RxNbr) = 0 )
		BEGIN
			Select  BIN, PlanName as [Plan], NDC, RxNbr, 
			convert(varchar(12),RxDate,1) as RxDate, 
			DrugName, Result, Status, Source,
			convert(varchar(12),CreatedOn ,1) as Created 
			from UPStatus WHERE (PharmID = @NCPDP) ORDER BY Status DESC,PlanName ASC,RxNbr ASC
		END
	ELSE
		BEGIN
			Select  BIN, PlanName as [Plan], NDC, RxNbr, 
			convert(varchar(12),RxDate,1) as RxDate, 
			DrugName, Result, Status, Source,
			convert(varchar(12),CreatedOn ,1) as Created 
  			from WebDev.dbo.UPStatus WHERE (PharmID = @NCPDP) AND RxNbr = @RxNbr AND RxDate = @FillDate
		END
		
END
GO
