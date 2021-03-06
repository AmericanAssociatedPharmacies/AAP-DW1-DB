USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spCGStoreEmployeeGet]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spCGStoreEmployeeGet]
(
	@ncpdp varchar(15)
)
AS
BEGIN
SELECT 
	e.ID, e.NCPDP, e.PMID, e.FirstName, e.MiddleName, e.LastName, e.ModifiedDate, e.CreatedDate, e.IsActive, e.Email, e.InActiveDate, 
	ent.ID As entID, ent.EmployeeNameType As EmployeeNameType, 
	et.ID as etID, et.EmployeeType As EmployeeType 
        FROM 
            CA_StoreEmployee AS e 
	        	LEFT OUTER JOIN CA_EmployeeNameType AS ent ON e.EmployeeNameType = ent.ID  
	        	LEFT OUTER JOIN CA_EmployeeType AS et ON e.EmployeeType = et.ID 
        WHERE 
        	NCPDP=@ncpdp AND IsActive=1 ORDER BY ID DESC
END
GO
