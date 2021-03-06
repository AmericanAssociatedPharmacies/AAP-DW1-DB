USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitInToTable]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 6/6/2014
-- Description:	Split String into column
-- =============================================
CREATE function [dbo].[SplitInToTable](@string varchar(max), @separator varchar(10))
returns @splited table ( IdInt INT NULL)
with execute as caller
as
begin
	DECLARE @xml XML
    SET @XML = N'<root><r>' + REPLACE(@string, @separator, '</r><r>') + '</r></root>';

    INSERT INTO @splited(IdInt)
    SELECT DISTINCT r.value('.','int') as IdInt
    FROM @xml.nodes('//root//r') AS RECORDS(r)
    return;
end
GO
