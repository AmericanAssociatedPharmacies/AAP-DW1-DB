USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spCGStoreEmployeeType]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spCGStoreEmployeeType]
AS
BEGIN
SELECT *
	FROM
		CA_EmployeeType
	ORDER BY
		EmployeeType ASC
END
GO
