USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_SCANESIMonthly_Filedate]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spQC_SCANESIMonthly_Filedate]
as
select top 1 convert(varchar,filedate,101) as file_date from qc_SCANESIMonthly order by filedate desc
GO
