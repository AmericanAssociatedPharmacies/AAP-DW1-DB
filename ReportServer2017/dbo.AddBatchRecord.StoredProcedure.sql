USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[AddBatchRecord]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddBatchRecord]
@BatchID uniqueidentifier,
@UserName nvarchar(260),
@Action varchar(32),
@Item nvarchar(425) = NULL,
@Parent nvarchar(425) = NULL,
@Param nvarchar(425) = NULL,
@BoolParam bit = NULL,
@Content image = NULL,
@Properties ntext = NULL
AS

IF @Action='BatchStart' BEGIN
   INSERT
   INTO [Batch] (BatchID, AddedOn, [Action], Item, Parent, Param, BoolParam, Content, Properties)
   VALUES (@BatchID, GETUTCDATE(), @Action, @UserName, @Parent, @Param, @BoolParam, @Content, @Properties)
END ELSE BEGIN
   IF EXISTS (SELECT * FROM Batch WHERE BatchID = @BatchID AND [Action] = 'BatchStart' AND Item = @UserName) BEGIN
      INSERT
      INTO [Batch] (BatchID, AddedOn, [Action], Item, Parent, Param, BoolParam, Content, Properties)
      VALUES (@BatchID, GETUTCDATE(), @Action, @Item, @Parent, @Param, @BoolParam, @Content, @Properties)
   END ELSE BEGIN
      RAISERROR( 'Batch does not exist', 16, 1 )
   END
END
GO
