USE [test]
GO
/****** Object:  View [dbo].[Family]    Script Date: 12/22/2020 8:07:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Family] WITH SCHEMABINDING 
AS
/* Yes! You are right this is equal to the select example 😉 */
SELECT f.father_id, f.father_name, s.father_id as son_id, s.paternity
 from [dbo].[father] f
      INNER JOIN [dbo].[son] s 
		      on isnull(s.father_id, -255)=f.father_id
GO
