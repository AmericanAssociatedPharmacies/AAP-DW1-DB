USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[StoreServerParameters]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[StoreServerParameters]
@ServerParametersID nvarchar(32),
@Path nvarchar(425),
@CurrentDate datetime,
@Timeout int,
@Expiration datetime,
@ParametersValues image,
@ParentParametersID nvarchar(32) = NULL
AS

DECLARE @ExistingServerParametersID as nvarchar(32)
SET @ExistingServerParametersID = (SELECT ServerParametersID from [dbo].[ServerParametersInstance] WHERE ServerParametersID = @ServerParametersID)
IF @ExistingServerParametersID IS NULL -- new row
BEGIN
  INSERT INTO [dbo].[ServerParametersInstance]
    (ServerParametersID, ParentID, Path, CreateDate, ModifiedDate, Timeout, Expiration, ParametersValues)
  VALUES
    (@ServerParametersID, @ParentParametersID, @Path, @CurrentDate, @CurrentDate, @Timeout, @Expiration, @ParametersValues)
END
ELSE
BEGIN
  UPDATE [dbo].[ServerParametersInstance]
  SET Timeout = @Timeout,
  Expiration = @Expiration,
  ParametersValues = @ParametersValues,
  ModifiedDate = @CurrentDate,
  Path = @Path,
  ParentID = @ParentParametersID
  WHERE ServerParametersID = @ServerParametersID
END
GO
