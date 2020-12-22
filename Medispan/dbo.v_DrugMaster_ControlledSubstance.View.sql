USE [Medispan]
GO
/****** Object:  View [dbo].[v_DrugMaster_ControlledSubstance]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_DrugMaster_ControlledSubstance]
AS
SELECT     dbo.M25_A.NDC_UPC_HRI AS NDC, dbo.M25_L.Package_Size AS PS,dbo.M25_J.Product_Description_Abbreviat AS DrugName, 
CASE DEA_Class_Code WHEN 'C-I' THEN 1 WHEN 'C-II' THEN 2 WHEN 'C-III' THEN 3 WHEN 'C-IV' THEN 4 WHEN 'C-V' THEN 5 ELSE 0 END AS DEA
FROM         dbo.M25_A LEFT OUTER JOIN
						dbo.M25_J ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_J.NDC_UPC_HRI LEFT OUTER JOIN
                        dbo.M25_L ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_L.NDC_UPC_HRI
GO
