USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[UpdatePolicy]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePolicy]
    @PolicyID as uniqueidentifier,
    @PrimarySecDesc as image,
    @SecondarySecDesc as ntext = NULL,
    @AuthType int
AS
    UPDATE SecData
    SET
        NtSecDescPrimary = @PrimarySecDesc,
        NtSecDescSecondary = @SecondarySecDesc,
        NtSecDescState = 0 -- Setting State back to Valid
    WHERE
        SecData.PolicyID = @PolicyID AND
        SecData.AuthType = @AuthType
GO
