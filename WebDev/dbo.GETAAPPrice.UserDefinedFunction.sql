USE [WebDev]
GO
/****** Object:  UserDefinedFunction [dbo].[GETAAPPrice]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vrindha Nair
-- Create date: <7/15/2016>
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[GETAAPPrice]
(@NDC nvarchar(11),
-- @Year nvarchar (5),
 @Month nvarchar (4)

)
 RETURNS varchar(500) AS

 BEGIN 
	DECLARE @Result varchar(500);
	
	SET  @Result =  (SELECT min(Price) as MinPrice
			from 
			(select NDC, Month, Year, Price, 'Cardinal' WH FROM Purchases..v_CHPriceMonth WHERE Year = '2015' and NDC = @NDC and Month = @Month
			UNION
			SELECT  NDC, Mnth, Yr, PricePerUnit, 'API' WH FROM Purchases..v_APIRebatesWeekly where Yr = '2015' and NDC = @NDC and Mnth = @Month
			) as minprice )

  	RETURN @Result;

 END  
GO
