USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetScanScore]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Chandni Lyla
-- Create date: 06/1/2015
-- Description:Select scan Score Record of the Store based on NCPDP
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetScanScore] 	
@NABP# nvarchar(255)

AS
BEGIN

select * from WebDev..ScanScore2014Q4 where NABP#=@NABP#  and file_date in (select max(file_date)from WebDev..ScanScore2014Q4)

END
GO
