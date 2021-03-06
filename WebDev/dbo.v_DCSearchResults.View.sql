USE [WebDev]
GO
/****** Object:  View [dbo].[v_DCSearchResults]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_DCSearchResults]
as
SELECT  [NDC]
      ,[Drugname]
      ,[Grp#]
      ,[Disp Fee]
      ,[Unit Ing.Cost]
      ,[Reimbursement Indictor]
      ,[Brand]
      ,[Non-MAC Generic]
      ,[MAC]
  FROM [WebDev].[dbo].[DCPriceWeb]
  
  UNION ALL
  
  SELECT null as NDC
	  ,null as drugname
	  ,[Grp#]
      ,[Disp Fee]
      ,null as [Unit Ing.Cost]
      ,[Reimbursement Indictor]
      ,[Brand]
      ,[Non-MAC Generic]
      ,[MAC]
  FROM [WebDev].[dbo].[DCGroupsWeb]
GO
