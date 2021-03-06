USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spDC_SearchByName]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Patrick
-- Create date: 10/5/2015
-- Description:	Return NDCs  for an drug name from 'RxCare Select Patient Pay Lookup Tool' webpage
--               10/16/2015 DG result sorted by Drug Name and alphabetized
-- =============================================
CREATE proc [dbo].[spDC_SearchByName]
(
@namestring varchar(50)
)
as
select distinct [NDC]
	  ,[DrugName]
--      ,[Brand]
--      ,[Non-MAC Generic] 
		from v_DCAll
where drugname like '%' + @namestring + '%'
order by drugname
GO
