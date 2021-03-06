USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[csfn_stripPunctuationIRS]    Script Date: 12/22/2020 7:35:33 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[csfn_stripPunctuationIRS](@sHasPunc [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [ssfnPM].[UserDefinedFunctions].[csfn_stripPunctuationIRS]
GO
EXEC sys.sp_addextendedproperty @name=N'AutoDeployed', @value=N'yes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'csfn_stripPunctuationIRS'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFile', @value=N'csfn_stripPunctuationIRS.cs' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'csfn_stripPunctuationIRS'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFileLine', @value=10 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'csfn_stripPunctuationIRS'
GO
