USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_GetScoreCard]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Deepa
-- Create date: 4/6/2016
-- Description:	Return Scorecard data for a pharmacy to be displayed on website
-- =============================================
CREATE PROCEDURE  [dbo].[spQC_GetScoreCard]
	@NCPDP varchar(7)

--  exec spQC_GetScoreCard '4553029'
--  exec spQC_GetScoreCard '0519198'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Declare @Client  varchar (500);
Declare @NABP varchar(7)
Set @NABP=@NCPDP;		--'4553029', '0519198';

set @Client=(select CASE  
when  exists(select top 1 nabp# from QC_ScorecardANTHEM 
			where NABP#=@NABP order by File_Date desc) then 'ANTHEM'
when  exists(select top 1 nabp# from QC_ScorecardSCAN 
			where NABP#=@NABP order by File_Date desc) then  'SCAN'
ELSE 'Pharmacy does not participate in ESI Scorecard' end)

--print @Client;
--drop table #ScoreCard_View

	select  sh.Id, GroupDisplaySeq, GroupTitle, SubGroupDisplaySeq, SubGroupTitle, DataColumn, Client, CONVERT(varchar(500),null) as Score, CONVERT(varchar(500),null) as ColorCode
	into #ScoreCard_View
	from ScoreCard_Header sh
	where client=@Client and isactive=1
	order by GroupDisplaySeq,SubGroupDisplaySeq

	--select * from #ScoreCard_View

--drop table #tempScoreCard
IF @Client='ANTHEM'
BEGIN
		select  *
		into #tempScoreCard
		from QC_ScorecardANTHEM
		where NABP#=@NABP and file_Date  = 
				(select top 1 file_Date as fd 
				from QC_ScorecardANTHEM where NABP#=@NABP order by File_Date desc)

		--select  *
		--from #tempScoreCard

		--round % off to 2 decimal places
		update #tempScoreCard set 
			[EQuIPP Raw Score_(% of Patients)]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)]),
			[EQuIPP Raw Score from Previous Quarter_(% of Patients)]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)]),
			[EQuIPP Raw Score_(% of Patients)1]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)1]),
			[EQuIPP Raw Score from Previous Quarter_(% of Patients)1]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)1]),
			[EQuIPP Raw Score_(% of Patients)2]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)2]),
			[EQuIPP Raw Score from Previous Quarter_(% of Patients)2]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)2]),
			[EQuIPP Raw Score_(% of Patients)3]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)3]),
			[EQuIPP Raw Score from Previous Quarter_(% of Patients)3]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)3]),
			[EQuIPP Raw Score_(% of Patients)4]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)4]),
			[EQuIPP Raw Score from Previous Quarter_(% of Patients)4]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)4])

		update #ScoreCard_View Set Score= (select NABP# from #tempScoreCard ) where DataColumn ='NABP#'
		update #ScoreCard_View Set Score= (select [Corporate Name] from #tempScoreCard ) where DataColumn ='[Corporate Name]'
		update #ScoreCard_View Set Score= (select [Pharmacy Name#] from #tempScoreCard ) where DataColumn ='[Pharmacy Name#]'
		update #ScoreCard_View Set Score= (select City from #tempScoreCard ) where DataColumn ='City'
		update #ScoreCard_View Set Score= (select State from #tempScoreCard ) where DataColumn ='State'

		update #ScoreCard_View Set Score= (select [Current: Mean Score] from #tempScoreCard ) where DataColumn ='[Current: Mean Score]'
		update #ScoreCard_View Set Score= (select [Previous: Mean Score] from #tempScoreCard ) where DataColumn ='[Previous: Mean Score]'
		update #ScoreCard_View Set Score= (select [Baseline: Mean Score] from #tempScoreCard ) where DataColumn ='[Baseline: Mean Score]'

		--high risk medication
		update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)] from #tempScoreCard ) where DataColumn ='[Total # of Patients_(Sample Size, N)]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)]'
		update #ScoreCard_View 
			Set Score= (select [Current Plan Star  Equivalent] from #tempScoreCard ),
			ColorCode= 	(select (CASE [Current Plan Star  Equivalent] 
				WHEN '<=3% (5)' THEN 'Green' 
				WHEN '<=5% (4)' THEN 'Blue'
				WHEN '<=8% (3)' Then 'Yellow'
				WHEN '<=10% (2)' Then 'Orange'
				WHEN '>=10% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
			where DataColumn ='[Current Plan Star  Equivalent]'
		update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars] from #tempScoreCard ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars]'
		update #ScoreCard_View Set Score= (select convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)]'
		--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent] from #tempScoreCard ) where DataColumn ='[Previous Quarter Plan Star Equivalent]'
		update #ScoreCard_View 
			Set Score= (select [Previous Quarter Plan Star Equivalent]  from #tempScoreCard ),
			ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent] 
				WHEN '<=3% (5)' THEN 'Green' 
				WHEN '<=5% (4)' THEN 'Blue'
				WHEN '<=8% (3)' Then 'Yellow'
				WHEN '<=10% (2)' Then 'Orange'
				WHEN '>=10% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
			where DataColumn ='[Previous Quarter Plan Star Equivalent]'

		--statin use in diabetes
		update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)1] from #tempScoreCard ) where DataColumn ='[Total # of Patients_(Sample Size, N)1]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)1]*100)+ '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)1]'
		update #ScoreCard_View 
			Set Score= (select [Current Plan Star  Equivalent1] from #tempScoreCard ),
			ColorCode= 	(select (CASE [Current Plan Star  Equivalent1] 
				WHEN '>=80% (5)' THEN 'Green' 
				WHEN '>=77% (4)' THEN 'Blue'
				WHEN '>=75% (3)' Then 'Yellow'
				WHEN '>=70% (2)' Then 'Orange'
				WHEN '<70% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
		where DataColumn ='[Current Plan Star  Equivalent1]'
		update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars1] from #tempScoreCard ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars1]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)1]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)1]'
		--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent1] from #tempScoreCard ) where DataColumn ='[Previous Quarter Plan Star Equivalent1]'
		update #ScoreCard_View 
			Set Score= (select [Previous Quarter Plan Star Equivalent1]  from #tempScoreCard ),
			ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent1] 
				WHEN '>=80% (5)' THEN 'Green' 
				WHEN '>=77% (4)' THEN 'Blue'
				WHEN '>=75% (3)' Then 'Yellow'
				WHEN '>=70% (2)' Then 'Orange'
				WHEN '<70% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
			where DataColumn ='[Previous Quarter Plan Star Equivalent1]'

		--Adherence for Diabetes medication
		update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)2] from #tempScoreCard ) where DataColumn ='[Total # of Patients_(Sample Size, N)2]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)2]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)2]'
		update #ScoreCard_View 
			Set Score= (select [Current Plan Star  Equivalent2] from #tempScoreCard ),
			ColorCode= 	(select (CASE [Current Plan Star  Equivalent2] 
				WHEN '>=86% (5)' THEN 'Green' 
				WHEN '>=78% (4)' THEN 'Blue'
				WHEN '>=71% (3)' Then 'Yellow'
				WHEN '>=62% (2)' Then 'Orange'
				WHEN '<62% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
		where DataColumn ='[Current Plan Star  Equivalent2]'
		update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars2] from #tempScoreCard ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars2]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)2]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)2]'
		--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent2] from #tempScoreCard ) where DataColumn ='[Previous Quarter Plan Star Equivalent2]'
		update #ScoreCard_View 
			Set Score= (select [Previous Quarter Plan Star Equivalent2]  from #tempScoreCard ),
			ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent2] 
				WHEN '>=86% (5)' THEN 'Green' 
				WHEN '>=78% (4)' THEN 'Blue'
				WHEN '>=71% (3)' Then 'Yellow'
				WHEN '>=62% (2)' Then 'Orange'
				WHEN '<62% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
			where DataColumn ='[Previous Quarter Plan Star Equivalent2]'

		--Adherence for Hypertension
		update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)3] from #tempScoreCard ) where DataColumn ='[Total # of Patients_(Sample Size, N)3]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)3]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)3]'
		update #ScoreCard_View 
			Set Score= (select [Current Plan Star  Equivalent3] from #tempScoreCard ),
			ColorCode= 	(select (CASE [Current Plan Star  Equivalent3] 
				WHEN '>=87% (5)' THEN 'Green' 
				WHEN '>=83% (4)' THEN 'Blue'
				WHEN '>=77% (3)' Then 'Yellow'
				WHEN '>=62% (2)' Then 'Orange'
				WHEN '<62% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
			where DataColumn ='[Current Plan Star  Equivalent3]'
		update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars3] from #tempScoreCard ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars3]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)3]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)3]'
		--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent3] from #tempScoreCard ) where DataColumn ='[Previous Quarter Plan Star Equivalent3]'
		update #ScoreCard_View 
			Set Score= (select [Previous Quarter Plan Star Equivalent3]  from #tempScoreCard ),
			ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent3] 
				WHEN '>=87% (5)' THEN 'Green' 
				WHEN '>=83% (4)' THEN 'Blue'
				WHEN '>=77% (3)' Then 'Yellow'
				WHEN '>=62% (2)' Then 'Orange'
				WHEN '<62% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
			where DataColumn ='[Previous Quarter Plan Star Equivalent3]'

		--Adherence for Cholesterol
		update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)4] from #tempScoreCard ) where DataColumn ='[Total # of Patients_(Sample Size, N)4]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)4]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)4]'
		update #ScoreCard_View 
			Set Score= (select [Current Plan Star  Equivalent4] from #tempScoreCard ),
			ColorCode= 	(select (CASE [Current Plan Star  Equivalent4] 
				WHEN '>=87% (5)' THEN 'Green' 
				WHEN '>=78% (4)' THEN 'Blue'
				WHEN '>=61% (3)' Then 'Yellow'
				WHEN '>=48% (2)' Then 'Orange'
				WHEN '<48% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
			where DataColumn ='[Current Plan Star  Equivalent4]'
		update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars4] from #tempScoreCard ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars4]'
		update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)4]*100) + '%' from #tempScoreCard ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)4]'
		--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent4] from #tempScoreCard ) where DataColumn ='[Previous Quarter Plan Star Equivalent4]'
		update #ScoreCard_View 
			Set Score= (select [Previous Quarter Plan Star Equivalent4]  from #tempScoreCard ),
			ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent4] 
				WHEN '>=87% (5)' THEN 'Green' 
				WHEN '>=78% (4)' THEN 'Blue'
				WHEN '>=61% (3)' Then 'Yellow'
				WHEN '>=48% (2)' Then 'Orange'
				WHEN '<48% (1)' Then 'Red' ELSE NULL END) ColorCode 
				from #tempScoreCard ) 
			where DataColumn ='[Previous Quarter Plan Star Equivalent4]'

		update #ScoreCard_View Set Score= (select [Improvement Value] from #tempScoreCard ) where DataColumn ='[Improvement Value]'

		select 	GroupTitle, SubGroupTitle, Score, ColorCode
			 from #ScoreCard_View
		order by [id] asc

		--select *
		--from QC_ScorecardANTHEM 
		--where nabp#=@nabp
END --IF @Client='ANTHEM'

ELSE IF @Client='SCAN'
BEGIN

		select  *
		into #tempScoreCard2
		from QC_ScorecardSCAN
		where NABP#=@NABP and file_Date  = 
				(select top 1 file_Date as fd 
				from QC_ScorecardSCAN where NABP#=@NABP order by File_Date desc);

--select  *
--from  #tempScoreCard2

--round % off to 2 decimal places
update #tempScoreCard2 set 
	[EQuIPP Raw Score_(% of Patients)]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)]),
	[EQuIPP Raw Score from Previous Quarter_(% of Patients)]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)]),
	[EQuIPP Raw Score_(% of Patients)1]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)1]),
	[EQuIPP Raw Score from Previous Quarter_(% of Patients)1]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)1]),
	[EQuIPP Raw Score_(% of Patients)2]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)2]),
	[EQuIPP Raw Score from Previous Quarter_(% of Patients)2]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)2]),
	[EQuIPP Raw Score_(% of Patients)3]=convert(decimal(5, 4), [EQuIPP Raw Score_(% of Patients)3]),
	[EQuIPP Raw Score from Previous Quarter_(% of Patients)3]=convert(decimal(5, 4), [EQuIPP Raw Score from Previous Quarter_(% of Patients)3])

update #ScoreCard_View Set Score= (select NABP# from #tempScoreCard2 ) where DataColumn ='NABP#'
update #ScoreCard_View Set Score= (select [Corporate Name] from #tempScoreCard2 ) where DataColumn ='[Corporate Name]'
update #ScoreCard_View Set Score= (select [Pharmacy Name#] from #tempScoreCard2 ) where DataColumn ='[Pharmacy Name#]'
update #ScoreCard_View Set Score= (select City from #tempScoreCard2 ) where DataColumn ='City'
update #ScoreCard_View Set Score= (select State from #tempScoreCard2 ) where DataColumn ='State'

update #ScoreCard_View Set Score= (select [Current: Mean Score] from #tempScoreCard2 ) where DataColumn ='[Current: Mean Score]'
update #ScoreCard_View Set Score= (select [Previous: Mean Score] from #tempScoreCard2 ) where DataColumn ='[Previous: Mean Score]'
update #ScoreCard_View Set Score= (select [Baseline: Mean Score] from #tempScoreCard2 ) where DataColumn ='[Baseline: Mean Score]'

--diabetes
update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)] from #tempScoreCard2 ) where DataColumn ='[Total # of Patients_(Sample Size, N)]'
update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)]*100) + '%' from #tempScoreCard2 ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)]'
update #ScoreCard_View 
	Set Score= (select [Current Plan Star  Equivalent] from #tempScoreCard2 ),
	ColorCode= 	(select (CASE [Current Plan Star  Equivalent] 
		WHEN '>=93% (5)' THEN 'Green' 
		WHEN '>=84% (4)' THEN 'Blue'
		WHEN '>=70% (3)' Then 'Yellow'
		WHEN '>=58% (2)' Then 'Orange'
		WHEN '<58% (1)' Then 'Red' ELSE NULL END) ColorCode 
		from #tempScoreCard2 ) 
	where DataColumn ='[Current Plan Star  Equivalent]'
update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars] from #tempScoreCard2 ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars]'
update #ScoreCard_View Set Score= (select convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)]*100) + '%' from #tempScoreCard2 ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)]'
--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent] from #tempScoreCard2 ) where DataColumn ='[Previous Quarter Plan Star Equivalent]'
update #ScoreCard_View 
	Set Score= (select [Previous Quarter Plan Star Equivalent]  from #tempScoreCard2 ),
	ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent] 
		WHEN '>=93% (5)' THEN 'Green' 
		WHEN '>=84% (4)' THEN 'Blue'
		WHEN '>=70% (3)' Then 'Yellow'
		WHEN '>=58% (2)' Then 'Orange'
		WHEN '<58% (1)' Then 'Red' ELSE NULL END) ColorCode 
		from #tempScoreCard2 ) 
	where DataColumn ='[Previous Quarter Plan Star Equivalent]'

--Adherence for diabetes medication
update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)1] from #tempScoreCard2 ) where DataColumn ='[Total # of Patients_(Sample Size, N)1]'
update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)1]*100)+ '%' from #tempScoreCard2 ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)1]'
update #ScoreCard_View 
	Set Score= (select [Current Plan Star  Equivalent1] from #tempScoreCard2 ),
	ColorCode= 	(select (CASE [Current Plan Star  Equivalent1] 
		WHEN '>=83% (5)' THEN 'Green' 
		WHEN '>=77% (4)' THEN 'Blue'
		WHEN '>=73% (3)' Then 'Yellow'
		WHEN '>=69% (2)' Then 'Orange'
		WHEN '<69% (1)' Then 'Red' ELSE NULL END) ColorCode 
		from #tempScoreCard2 ) 
where DataColumn ='[Current Plan Star  Equivalent1]'
update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars1] from #tempScoreCard2 ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars1]'
update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)1]*100) + '%' from #tempScoreCard2 ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)1]'
--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent1] from #tempScoreCard2 ) where DataColumn ='[Previous Quarter Plan Star Equivalent1]'
update #ScoreCard_View 
	Set Score= (select [Previous Quarter Plan Star Equivalent1]  from #tempScoreCard2 ),
	ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent1] 
		WHEN '>=83% (5)' THEN 'Green' 
		WHEN '>=77% (4)' THEN 'Blue'
		WHEN '>=73% (3)' Then 'Yellow'
		WHEN '>=69% (2)' Then 'Orange'
		WHEN '<69% (1)' Then 'Red' ELSE NULL END) ColorCode 
		from #tempScoreCard2 ) 
	where DataColumn ='[Previous Quarter Plan Star Equivalent1]'

--Adherence for Hypertension
update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)2] from #tempScoreCard2 ) where DataColumn ='[Total # of Patients_(Sample Size, N)2]'
update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)2]*100) + '%' from #tempScoreCard2 ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)2]'
update #ScoreCard_View 
	Set Score= (select [Current Plan Star  Equivalent2] from #tempScoreCard2 ),
	ColorCode= 	(select (CASE [Current Plan Star  Equivalent2] 
		WHEN '>=85% (5)' THEN 'Green' 
		WHEN '>=81% (4)' THEN 'Blue'
		WHEN '>=76% (3)' Then 'Yellow'
		WHEN '>=72% (2)' Then 'Orange'
		WHEN '<72% (1)' Then 'Red' ELSE NULL END) ColorCode 
		from #tempScoreCard2 ) 
where DataColumn ='[Current Plan Star  Equivalent2]'
update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars2] from #tempScoreCard2 ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars2]'
update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)2]*100) + '%' from #tempScoreCard2 ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)2]'
--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent2] from #tempScoreCard2 ) where DataColumn ='[Previous Quarter Plan Star Equivalent2]'
update #ScoreCard_View 
	Set Score= (select [Previous Quarter Plan Star Equivalent2]  from #tempScoreCard2 ),
	ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent2]
		WHEN '>=85% (5)' THEN 'Green' 
		WHEN '>=81% (4)' THEN 'Blue'
		WHEN '>=76% (3)' Then 'Yellow'
		WHEN '>=72% (2)' Then 'Orange'
		WHEN '<72% (1)' Then 'Red' ELSE NULL END) ColorCode 
		from #tempScoreCard2 ) 
	where DataColumn ='[Previous Quarter Plan Star Equivalent2]'

--Adherence for Cholesterol
update #ScoreCard_View Set Score= (select [Total # of Patients_(Sample Size, N)3] from #tempScoreCard2 ) where DataColumn ='[Total # of Patients_(Sample Size, N)3]'
update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score_(% of Patients)3]*100) + '%' from #tempScoreCard2 ) where DataColumn ='[EQuIPP Raw Score_(% of Patients)3]'
update #ScoreCard_View 
	Set Score= (select [Current Plan Star  Equivalent3] from #tempScoreCard2 ),
	ColorCode= 	(select (CASE [Current Plan Star  Equivalent3] 
		WHEN '>=83% (5)' THEN 'Green' 
		WHEN '>=76% (4)' THEN 'Blue'
		WHEN '>=68% (3)' Then 'Yellow'
		WHEN '>=59% (2)' Then 'Orange'
		WHEN '<59% (1)' Then 'Red' ELSE NULL END) ColorCode 
		from #tempScoreCard2 ) 
	where DataColumn ='[Current Plan Star  Equivalent3]'
update #ScoreCard_View Set Score= (select [# of Patients for Intervention to Reach 5 Stars3] from #tempScoreCard2 ) where DataColumn ='[# of Patients for Intervention to Reach 5 Stars3]'
update #ScoreCard_View Set Score= (select Convert(varchar,[EQuIPP Raw Score from Previous Quarter_(% of Patients)3]*100) + '%' from #tempScoreCard2 ) where DataColumn ='[EQuIPP Raw Score from Previous Quarter_(% of Patients)3]'
--update #ScoreCard_View Set Score= (select [Previous Quarter Plan Star Equivalent3] from #tempScoreCard2 ) where DataColumn ='[Previous Quarter Plan Star Equivalent3]'
update #ScoreCard_View 
	Set Score= (select [Previous Quarter Plan Star Equivalent3]  from #tempScoreCard2 ),
	ColorCode= 	(select (CASE [Previous Quarter Plan Star Equivalent3]
		WHEN '>=83% (5)' THEN 'Green' 
		WHEN '>=76% (4)' THEN 'Blue'
		WHEN '>=68% (3)' Then 'Yellow'
		WHEN '>=59% (2)' Then 'Orange'
		WHEN '<59% (1)' Then 'Red' ELSE NULL END) ColorCode 
		from #tempScoreCard2 ) 
	where DataColumn ='[Previous Quarter Plan Star Equivalent3]'

update #ScoreCard_View Set Score= (select [Improvement Value] from #tempScoreCard2 ) where DataColumn ='[Improvement Value]'

		select 	GroupTitle, SubGroupTitle, Score, ColorCode
			 from #ScoreCard_View
		order by [id] asc

-- select * from #tempScoreCard2
END --IF @Client='SCAN'

ELSE 
select 	NULL as GroupTitle, NULL as SubGroupTitle, NULL as Score, NULL as ColorCode --Pharmacy does not participate in ESI Scorecard
 
--  exec spQC_GetScoreCard '4553029'
--  exec spQC_GetScoreCard '0519198'
-- exec spQC_GetScoreCard '1835074'
END --end SP
GO
