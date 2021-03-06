USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_audit2]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_audit2]
AS
SELECT     AuditDate AS [AUDIT DATE], SysUser AS SYSUSER, TableName, Operation AS [UPDATE OR INSERT], PrimaryKey AS PMID, 
                      ColumnName AS [COLUMN NAME], 
                      convert(varchar,OldValue) AS [ORIGINAL VALUE], convert(varchar,NewValue) AS [NEW VALUE]
FROM         dbo.Audit AS A

GO
