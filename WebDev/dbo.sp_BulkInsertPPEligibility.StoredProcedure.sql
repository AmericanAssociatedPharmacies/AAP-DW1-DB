USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertPPEligibility]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	CHANDNI KL
-- Create date: 05/11/2015
-- Description:	BULK INSERT ON [dbo].PPELIGIBILITY
-- =============================================
CREATE PROCEDURE [dbo].[sp_BulkInsertPPEligibility] 

AS
BEGIN

DECLARE @SQL varchar(2000)
set @SQL = 'bulk insert PPEligibility from ''T:\Data\PriceProtection\targetcsv.csv'
set @SQL = @SQL + '''with (fieldterminator = '','', rowterminator = ''\n'', firstrow =2)'
exec(@SQL)

update PPEligibility set CustomerName=replace(CustomerName,'||',',')
alter table PPEligibility add PMID nvarchar(50) 
END
GO
