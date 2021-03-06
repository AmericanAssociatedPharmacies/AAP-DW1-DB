USE [MedispanImages]
GO
/****** Object:  View [Staging].[vw_IM2SUM_A]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vw_IM2SUM_A]

AS

SELECT Record_Type
	, CASE 
       WHEN Reserve_1 NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Reserve_1
       END AS Reserve_1
	, Sequence_Number
	, CASE 
       WHEN Reserve_2 NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Reserve_2
       END AS Reserve_2
	, CASE 
       WHEN Comment_Marker NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Comment_Marker
       END AS Comment_Marker
	, CASE 
       WHEN Data_or_Comment NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Data_or_Comment
       END AS Data_or_Comment
	FROM [MedispanImages_Staging].[dbo].[IM2SUM_A]
GO
