USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_TableSizeListing]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Joni Wilson
-- Create date: 11/29/2012
-- Description:	Table Size Listing
 
-- =============================================
CREATE PROCEDURE [dbo].[sppm_TableSizeListing] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
WITH table_space_usage ( schema_name, table_name, used, reserved, ind_rows, tbl_rows )
AS (SELECT 
s.Name
, o.Name
, p.used_page_count * 8
, p.reserved_page_count * 8
, p.row_count
, case when i.index_id in ( 0, 1 ) then p.row_count else 0 end
FROM sys.dm_db_partition_stats p
INNER JOIN sys.objects as o ON o.object_id = p.object_id
INNER JOIN sys.schemas as s ON s.schema_id = o.schema_id
LEFT OUTER JOIN sys.indexes as i on i.object_id = p.object_id and i.index_id = p.index_id
WHERE o.type_desc = 'USER_TABLE' and o.is_ms_shipped = 0)

SELECT --t.schema_name
  t.Table_Name
, sum(t.used)  as used_in_KB
, sum(t.used)/1000  as used_in_MB
, sum(t.reserved)  as reserved_in_KB
,sum(t.tbl_rows) as Rows

FROM table_space_usage as t

GROUP BY t.schema_name , t.table_name  

ORDER BY used_in_kb desc
END





GO
