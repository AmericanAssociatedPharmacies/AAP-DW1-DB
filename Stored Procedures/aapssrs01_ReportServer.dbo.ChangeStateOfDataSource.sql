USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[ChangeStateOfDataSource] Script Date: 12/21/2020 8:30:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChangeStateOfDataSource]
@ItemID [uniqueidentifier],
@Enable bit
AS
IF @Enable != 0 BEGIN
   UPDATE [DataSource]
      SET
         [Flags] = [Flags] | 1
   WHERE [ItemID] = @ItemID
END
ELSE
BEGIN
   UPDATE [DataSource]
      SET
         [Flags] = [Flags] & 0x7FFFFFFE
   WHERE [ItemID] = @ItemID
END
