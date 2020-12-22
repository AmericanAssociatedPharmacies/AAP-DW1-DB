USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spbg_delete]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spbg_delete]
as
begin
DECLARE @query varchar(max)
SELECT @query = 
'SELECT ' + SUBSTRING((SELECT ',' +'COUNT(DISTINCT(' + column_name + ')) 
         As ' + column_name + ' '  
         FROM information_schema.columns
         WHERE 
         table_name = 'pm_servicessurvey'
         for xml path('')),2,200000)  +  'FROM table_name'

exec @query
end
GO
