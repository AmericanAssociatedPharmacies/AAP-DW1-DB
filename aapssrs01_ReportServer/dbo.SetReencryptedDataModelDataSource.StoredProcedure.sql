USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[SetReencryptedDataModelDataSource]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetReencryptedDataModelDataSource]
    @DSID bigint,
    @ConnectionString varbinary(max) = null,
    @Username varbinary(max) = null,
    @Password varbinary(max) = null
AS

UPDATE [dbo].[DataModelDataSource]
SET
    [ConnectionString] = @ConnectionString,
    [Username] = @Username,
    [Password] = @Password
WHERE [DSID] = @DSID
GO
