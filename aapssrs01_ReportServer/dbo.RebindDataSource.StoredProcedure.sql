USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[RebindDataSource]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Republishing generates new DSID and stores those in the object model,
-- in order to resolve the data sources we need to rebind the old
-- data source definition to the current DSID
CREATE PROCEDURE [dbo].[RebindDataSource]
@ItemId		uniqueidentifier,
@Name		nvarchar(260),
@NewDSID	uniqueidentifier
AS
UPDATE DataSource
SET DSID = @NewDSID
WHERE ItemID = @ItemId AND [Name] = @Name
GO
