USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRLGL_isStateMAC]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRLGL_isStateMAC]
(
	@state varchar(8)
)
as
select count(State) as [count] from UPStateMAC where State = @state
GO
