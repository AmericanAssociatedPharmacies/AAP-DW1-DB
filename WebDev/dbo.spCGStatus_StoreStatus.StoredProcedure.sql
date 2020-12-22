USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spCGStatus_StoreStatus]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spCGStatus_StoreStatus]
(
	@pmid int,
	@ncpdp varchar(15)
	
)
as
SELECT * FROM WebDev.dbo.v_CA_StoreStatus WHERE PMID=@pmid AND NCPDP=@ncpdp
GO
