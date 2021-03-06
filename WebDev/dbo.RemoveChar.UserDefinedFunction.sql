USE [WebDev]
GO
/****** Object:  UserDefinedFunction [dbo].[RemoveChar]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vrindha Nair
-- Create date: <7/15/2016>
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[RemoveChar]
(@FieldVal varchar(500))
 RETURNS varchar(500) AS

 BEGIN 
	DECLARE @Result varchar(500);
	
	SET @Result = REPLACE(@FieldVal,'$','');
    SET @Result = REPLACE(@Result,'-','');

  	RETURN @Result;

 END  
GO
