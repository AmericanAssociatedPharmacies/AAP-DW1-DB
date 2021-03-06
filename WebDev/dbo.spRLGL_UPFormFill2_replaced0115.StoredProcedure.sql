USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRLGL_UPFormFill2_replaced0115]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRLGL_UPFormFill2_replaced0115]
(
		@NCPDP int,
		@RxNbr nvarchar(50),
		@filldate smalldatetime	
)

AS
BEGIN
	SET NOCOUNT ON;
	Select p.PlanName,[BIN Nbr],[Group Nbr],NDC,[Qty Dispensed],[Day Supply],[Cost Submitted]
	,[Total Price] as [Total Paid]
	FROM Webdev.dbo.Rx30Latest r left join claims_planbins p on p.bin=r.[bin nbr]
	WHERE [Pharm ID]=@NCPDP AND [Rx Nbr]=@RxNbr AND [Rx Date] = @filldate 
END
GO
