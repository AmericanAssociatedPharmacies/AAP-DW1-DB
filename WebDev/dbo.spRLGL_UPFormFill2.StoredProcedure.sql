USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRLGL_UPFormFill2]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JOSHILA NARAYANAN
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spRLGL_UPFormFill2]
(
		@NCPDP int,
		@RxNbr nvarchar(50),
		--@filldate smalldatetime	
		@filldate nvarchar(50)
)

AS
BEGIN
	SET NOCOUNT ON;
	if (@filldate = '')
	BEGIN
		Select p.PlanName,[BIN Nbr],[Group Nbr],NDC,[Qty Dispensed],[Day Supply],[Cost Submitted]
		,[Total Price] as [Total Paid]
		FROM Webdev.dbo.Rx30Latest r left join claims_planbins p on p.bin=r.[bin nbr]
		WHERE [Pharm ID]=@NCPDP AND [Rx Nbr]=@RxNbr --AND [Rx Date] = @filldate
		order by [rx date] desc
	END
	else
	BEGIN	
		Select p.PlanName,[BIN Nbr],[Group Nbr],NDC,[Qty Dispensed],[Day Supply],[Cost Submitted]
		,[Total Price] as [Total Paid]
		FROM Webdev.dbo.Rx30Latest r left join claims_planbins p on p.bin=r.[bin nbr]
		WHERE [Pharm ID]=@NCPDP AND [Rx Nbr]=@RxNbr AND [Rx Date] = @filldate 
	END
END
GO
