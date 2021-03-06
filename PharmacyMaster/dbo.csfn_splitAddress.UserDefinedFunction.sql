USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[csfn_splitAddress]    Script Date: 12/22/2020 7:35:33 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[csfn_splitAddress](@sAddress1 [nvarchar](4000), @sAddress2 [nvarchar](4000), @iFieldNo [int])
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [ssfnPM].[UserDefinedFunctions].[csfn_splitAddress]
GO
EXEC sys.sp_addextendedproperty @name=N'AutoDeployed', @value=N'yes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'csfn_splitAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFile', @value=N'csfn_splitAddress.cs' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'csfn_splitAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFileLine', @value=10 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'csfn_splitAddress'
GO
