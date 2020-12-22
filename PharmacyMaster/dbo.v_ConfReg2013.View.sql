USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_ConfReg2013]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ConfReg2013]
AS
SELECT APIAccountNo,AAPAccountNo,p.PMID from pm_pharmacy p
join
(	
	SELECT * from pm_memberprograms where programid = '195' and enddate is null
) c
on p.pmid = c.pmid
GO
