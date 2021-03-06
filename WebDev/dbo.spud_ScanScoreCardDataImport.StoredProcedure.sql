USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spud_ScanScoreCardDataImport]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================================
-- Author:		Chandni Lyla
-- Create date: 10/7/2015
-- Description:	Load the Quarterly Scan Data to Webdev.[dbo].ScanScore2014Q4
-- ===========================================================================
CREATE PROCEDURE [dbo].[spud_ScanScoreCardDataImport] 
	
AS
BEGIN
	
SET NOCOUNT ON;

--Data Cleanup from Imported Scan table

delete from scan where [column 0]='NABP#'

update scan set 
[column 3] =  REPLACE([column 3], '||', ','),
[column 7] =  REPLACE([column 7],  '%', '') ,
[column 10] = REPLACE([column 10], '%', ''), 
[column 12] = REPLACE([column 12], '%', '') ,
[column 13] = REPLACE([column 13], '%', ''), 
[column 15] = REPLACE([column 15], '%', ''), 
[column 18] = REPLACE([column 18], '%', ''), 
[column 20] = REPLACE([column 20], '%', ''), 
[column 21] = REPLACE([column 21], '%', ''), 
[column 23] = REPLACE([column 23], '%', ''), 
[column 24] = REPLACE([column 24], '%', ''), 
[column 28] = REPLACE([column 28], '%', ''), 
[column 31] = REPLACE([column 31], '%', ''),
[column 32] = REPLACE([column 32], '%', ''), 
[column 36] = REPLACE([column 36], '%', ''), 
[column 39] = REPLACE([column 39], '%', ''), 
[column 40] = REPLACE([column 40], '%', ''), 
[column 44] = REPLACE([column 44], '%', ''), 
[column 11] = SUBSTRING([column 11], CHARINDEX('(', [column 11])+1,1),
[column 19] = SUBSTRING([column 19], CHARINDEX('(', [column 19])+1,1),
[column 29] = SUBSTRING([column 29], CHARINDEX('(', [column 29])+1,1),
[column 37] = SUBSTRING([column 37], CHARINDEX('(', [column 37])+1,1),
[column 45] = SUBSTRING([column 45], CHARINDEX('(', [column 45])+1,1)

    alter table scan alter column [Column 4] float
	alter table scan alter column [Column 5]float
	alter table scan alter column [Column 6] float
	alter table scan alter column [Column 7] float
	
    alter table scan alter column [Column 9] float
	alter table scan alter column [Column 10] float
	alter table scan alter column [Column 11] float
	alter table scan alter column [Column 12] float
	alter table scan alter column [Column 13] float
	alter table scan alter column [Column 14] float
	alter table scan alter column [Column 15] float

	alter table scan alter column [Column 17] float
	alter table scan alter column [Column 18] float
	alter table scan alter column [Column 19] float
	alter table scan alter column [Column 20] float
	alter table scan alter column [Column 21] float
	alter table scan alter column [Column 22] float
	alter table scan alter column [Column 23] float
	alter table scan alter column [Column 24] float
	
	alter table scan alter column [Column 26] float
	alter table scan alter column [Column 27] float
	alter table scan alter column [Column 28] float
	alter table scan alter column [Column 29] float
	alter table scan alter column [Column 30] float
	alter table scan alter column [Column 31] float
	alter table scan alter column [Column 32] float
	
	alter table scan alter column [Column 34] float
	alter table scan alter column [Column 35] float
	alter table scan alter column [Column 36] float
	alter table scan alter column [Column 37] float
	alter table scan alter column [Column 38] float
	alter table scan alter column [Column 39] float
	alter table scan alter column [Column 40] float
	
	alter table scan alter column [Column 42] float
	alter table scan alter column [Column 43] float
	alter table scan alter column [Column 44] float
	alter table scan alter column [Column 45] float


--Truncate QA table 
truncate table scantemp

insert into scantemp select
[Column 0],
[Column 1],                                                            
[Column 2],															
[Column 3],
[Column 4],
[Column 5],
[Column 6],
[Column 7],
[Column 8],
[Column 9],
[Column 10],
[Column 11],
[Column 12],
[Column 13],
[Column 14],
[Column 15],
[Column 16],
[Column 17],
[Column 18],
[Column 19],
[Column 20],
[Column 21],
[Column 22],
[Column 23],
[Column 24],
[Column 25],
[Column 26],
[Column 27],
[Column 28],
[Column 29],
[Column 30],
[Column 31],
[Column 32],
[Column 33],
[Column 34],
[Column 35],
[Column 36],
[Column 37],
[Column 38],
[Column 39],
[Column 40],
[Column 41],
[Column 42],
[Column 43],
[Column 44],
[Column 45],
getdate() 

from scan

insert into Webdev..ScanScore2014Q4 select * from scantemp

drop table scan
  
END
GO
