USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[UpdatePolicyStatus]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePolicyStatus]
    @PolicyID as uniqueidentifier,
    @AuthType int,
    @Status int
AS
    UPDATE SecData
    SET
        NtSecDescState = @Status
    WHERE
        SecData.PolicyID = @PolicyID AND SecData.AuthType = @AuthType
GO
