USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_Rx30andMC]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spQC_Rx30andMC]
(
@ncpdp varchar(15)
)
as
select top 1 ncpdp from QC_tmp_Rx30list where ncpdp=@ncpdp
GO
