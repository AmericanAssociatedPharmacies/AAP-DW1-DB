USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_updatePPEligibility]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	CHANDNI KL
-- Create date: 05/05/2015
-- Description:	UPDATES [dbo].PPELIGIBILITY
-- =============================================
CREATE PROCEDURE [dbo].[sp_updatePPEligibility] @col varchar(50)

AS
BEGIN
DECLARE @SQL varchar(2000)
SET @SQL = 'update WebDev..PPEligibility set ' + @col + ' =replace('+ @col + ',''--'','' '')'
exec(@SQL)
END
GO
