USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_description]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[v_description]
as
select pmid,ncpdp,accountname,city,state,aapstatus,isMCorNPP,apistatus,computersoftware
,accountname + ',' + city + ',' + state as description
from v_test

GO
