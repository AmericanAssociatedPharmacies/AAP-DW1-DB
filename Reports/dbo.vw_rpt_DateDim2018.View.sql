USE [Reports]
GO
/****** Object:  View [dbo].[vw_rpt_DateDim2018]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_rpt_DateDim2018]
	AS SELECT *
	FROM [Rx30].dbo.DateDim AS t1
	WHERE t1.Year = '2018'
GO
