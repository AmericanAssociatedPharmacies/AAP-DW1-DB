USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_WithDeleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_PM_WithDeleted]
AS

SELECT * from PM_Deleted
UNION 
SELECT *  from PM_Pharmacy 
GO
