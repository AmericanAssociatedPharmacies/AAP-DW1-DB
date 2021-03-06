USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spCGUpdateEmployee]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spCGUpdateEmployee]
(
	@pmid int,
	@firstName varchar(15),
	@middleName varchar(15),
	@lastName varchar(15),
	@email varchar(45),
	@employeeNameType varchar(15),
	@employeeType varchar(15),
	@Id int
)
AS
BEGIN
	UPDATE CA_StoreEmployee 
		SET PMID = @pmid, FirstName = @firstName, MiddleName = @middleName, LastName = @lastName, Email = @email, EmployeeNameType = @employeeNameType, EmployeeType = @employeeType
		WHERE ID = @Id
END
GO
