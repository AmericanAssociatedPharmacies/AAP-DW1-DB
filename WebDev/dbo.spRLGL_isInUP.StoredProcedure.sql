USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRLGL_isInUP]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spRLGL_isInUP]
(
@ncpdp int
)
as
select case when @ncpdp in
(select PharmID from UPStatus where PharmID=@ncpdp)
then 1 else 0 end as ret
GO
