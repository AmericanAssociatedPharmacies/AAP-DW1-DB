USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_MedicaidInformation_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_MedicaidInformation_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[MedicaidInformation] AS T
	USING (SELECT [NCPDPProviderID], [StateCode], [MedicaidID], [DeleteDate]
		   FROM [Staging].[vw_NCPDP_MedicaidInformation]) AS S
				([NCPDPProviderID], [StateCode], [MedicaidID],[DeleteDate])
		  ON T.NCPDPProviderID = S.NCPDPProviderID
		  AND T.[StateCode] = S.[StateCode]
		  AND T.[MedicaidID] = S.[MedicaidID]

WHEN MATCHED THEN

UPDATE SET deletedate = S.[DeleteDate]
	
		 

WHEN NOT MATCHED THEN
		INSERT ([NCPDPProviderID], [StateCode], [MedicaidID], [DeleteDate])
		VALUES (S.[NCPDPProviderID], S.[StateCode], S.[MedicaidID], S.[DeleteDate]);
END


GO
