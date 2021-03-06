USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_CA_StoreEmployeeAdd]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rajesh Kalaskar
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spweb_CA_StoreEmployeeAdd]
	(
		@NCPDP nvarchar(7),
		@PMID int,
		@FirstName nvarchar(64),
		@MiddleName nvarchar(64),
		@LastName nvarchar(64),
		@Email nvarchar(128),
		@EmployeeNameType int,
		@EmployeeType int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @IdentityOutput table ( ID int )

	--insert record
	INSERT INTO [WebDev].[dbo].[CA_StoreEmployee] ([NCPDP],[PMID],[FirstName],[MiddleName],[LastName],[Email],[EmployeeNameType],[EmployeeType])
	OUTPUT inserted.ID into @IdentityOutput
	VALUES (@NCPDP,@PMID,@FirstName,@MiddleName,@LastName,@Email,@EmployeeNameType,@EmployeeType)
	
	-- Get request ID
	DECLARE @id int
	select @id = (select ID from @IdentityOutput)

	UPDATE [WebDev].[dbo].[CA_StoreEmployee] SET Username = substring(rtrim(ltrim(lower([dbo].[RemoveNonAlphaCharacters](FirstName + MiddleName + LastName)))), 0, 4) + CAST(ID AS nvarchar) WHERE ID = @id
END
GO
