USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spCGStoreEmployeeNameType]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spCGStoreEmployeeNameType]
AS
BEGIN
SELECT *
	FROM
		CA_EmployeeNameType
	ORDER BY
		EmployeeNameType ASC
END
GO
