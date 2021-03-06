USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_GetScoreCardClient]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Deepa
-- Create date: 4/13/2016
-- Description:	Return Scorecard client name for a pharmacy to be displayed on website
-- =============================================
CREATE PROCEDURE  [dbo].[spQC_GetScoreCardClient]
	@NCPDP varchar(7)

--  exec spQC_GetScoreCardClient '4553029' --anthem
--  exec spQC_GetScoreCardClient '0519198' --scan
-- exec spQC_GetScoreCardClient '1835074' --none
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Declare @Client  varchar (500);
Declare @NABP varchar(7)
Set @NABP=@NCPDP;		--'4553029', '0519198';

--set @Client=(select CASE  
--when  exists(select top 1 nabp# from QC_ScorecardANTHEM 
--			where NABP#=@NABP order by File_Date desc) then 'ANTHEM'
--when  exists(select top 1 nabp# from QC_ScorecardSCAN 
--			where NABP#=@NABP order by File_Date desc) then  'SCAN'
--ELSE 'Pharmacy does not participate in ESI Scorecard' end)
--
--select @Client as 'ScoreCard_ClientName'

select NABP# as NCPDP, 'ANTHEM' as ScoreCard_ClientName from QC_ScorecardANTHEM where NABP#=@NCPDP
union
select NABP# as NCPDP, 'SCAN' as ScoreCard_ClientName from QC_ScorecardSCAN where NABP#=@NCPDP

END

GO
