USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[PMActiveProgramNames]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joni Wilson (adapted from Bruces ListAffiliates in AAP)
-- Create date: 1/12/10
-- Description:	return a delimited list of Program names
-- =============================================
CREATE FUNCTION [dbo].[PMActiveProgramNames]
(
	-- Add the parameters for the function here
	@pmid int
)
RETURNS varchar(255)
AS
BEGIN
		declare @result varchar(255)
	SELECT @result = COALESCE(@result + ', ', '') + 
	   cast(g.Description as varchar(255))
from 
		pharmacymaster.dbo.pm_pharmacy p
		left outer join 
		pharmacymaster.dbo.PM_MemberPrograms x on p.pmid=x.pmid
		left outer join 
		pharmacymaster.dbo.PM_Programs g on x.programid = g.programid
		where p.pmid= @pmid  and x.enddate is null
	RETURN isnull(@result,'')

END
GO
