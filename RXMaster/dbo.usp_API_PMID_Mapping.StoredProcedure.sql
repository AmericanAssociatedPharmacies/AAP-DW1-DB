USE [RXMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_PMID_Mapping]    Script Date: 12/22/2020 7:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_API_PMID_Mapping]

AS


SET NOCOUNT ON;

BEGIN

	TRUNCATE TABLE Staging.API_PMID_Mapping;

	INSERT INTO Staging.API_PMID_Mapping(RN, APIAccountNo, PMID, APIEffectiveDate, APIQuitDate)
	SELECT RANK() OVER(PARTITION BY APIAccountNo ORDER BY APIAccountNo ASC, PMID ASC) AS RN
	, APIAccountNo
	, PMID
	, APIEffectiveDate
	, APIQuitDate
	FROM DynamicsODS.dbo.vwAPIAccount
	ORDER BY APIAccountNo ASC, PMID ASC

	--Update Non-Change of Ownership accounts
	UPDATE x
	SET APIEffectiveDate = ISNULL(APIEffectiveDate, '19000101')
	, APIQuitDate = ISNULL(APIQuitDate, '29991231')
	FROM Staging.API_PMID_Mapping AS x
	INNER JOIN(SELECT APIAccountNo
				,COUNT(*) AS C1
				FROM Staging.API_PMID_Mapping
				GROUP BY APIAccountNo
				HAVING COUNT(APIAccountNo) = 1 
				) AS dt ON x.APIAccountNo = dt.APIAccountNo


	--Update Change of Ownership where the older PMID has a valid APIQuitDate
	UPDATE x
	SET APIEffectiveDate = dt.APIEffectiveDate
	, APIQuitDate = dt.APIQuitDate
	FROM Staging.API_PMID_Mapping AS x
	INNER JOIN(SELECT p.RN
				, p.APIAccountNo
				, p.PMID
				, REPLACE(ISNULL(DATEADD(DAY, 1, LAG(APIQuitDate,1) OVER (ORDER BY p.APIAccountNo ASC, p.PMID ASC, p.RN ASC)), '19000101'), '3000-01-01', '1900-01-01') AS APIEffectiveDate
				, ISNULL(APIQuitDate, '29991231') AS APIQuitDate
				FROM Staging.API_PMID_Mapping AS p
				INNER JOIN(SELECT n1.APIAccountNo
							FROM Staging.API_PMID_Mapping AS n
							INNER JOIN Staging.API_PMID_Mapping AS n1 ON n.APIAccountNo = n1.APIAccountNo
																	AND n.PMID = n1.PMID
																	AND n1.RN = 1
																	AND n1.APIQuitDate IS NOT NULL	
							CROSS JOIN(SELECT APIAccountNo
										, RN
										FROM Staging.API_PMID_Mapping
										WHERE RN > 1
										) AS cj
							WHERE cj.APIAccountNo = n1.APIAccountNo	
						 ) AS dt ON p.APIAccountNo = dt.APIAccountNo
				) AS dt ON x.APIAccountNo = dt.APIAccountNo
							AND x.PMID = dt.PMID

	--Update Change of Ownership where the most recent PMID has a valid APIQuitDate, but where the older PMID is the Active PMID.
	UPDATE x
	SET APIEffectiveDate = dt.APIEffectiveDate
	, APIQuitDate = dt.APIQuitDate
	FROM Staging.API_PMID_Mapping AS x
	INNER JOIN(SELECT p.APIAccountNo
				, p.PMID
				, ISNULL(DATEADD(DAY, 1, LEAD(p.APIQuitDate,1) OVER (ORDER BY p.APIAccountNo ASC, p.PMID ASC, p.RN DESC)), '19000101') AS APIEffectiveDate
				, ISNULL(p.APIQuitDate, '29991231') AS APIQuitDate
				FROM Staging.API_PMID_Mapping AS p
				INNER JOIN(SELECT n1.APIAccountNo
							, MAX(n1.RN) AS RN
							FROM Staging.API_PMID_Mapping AS n1
							CROSS JOIN(SELECT APIAccountNo
										, RN
										FROM Staging.API_PMID_Mapping
										WHERE RN > 1
										) AS cj
							WHERE cj.APIAccountNo = n1.APIAccountNo	
							AND n1.APIQuitDate IS NOT NULL
							AND n1.APIEffectiveDate IS NULL
							GROUP BY n1.APIAccountNo
							) AS dt	ON p.APIAccountNo = dt.APIAccountNo		
			) AS dt ON x.APIAccountNo = dt.APIAccountNo
							AND x.PMID = dt.PMID

	--Update DateKey's
	UPDATE x
	SET  APIEffectiveDateKey = CAST(CONVERT(VARCHAR(20),APIEffectiveDate,112) as INT) 
	, APIQuitDateKey = CAST(CONVERT(VARCHAR(20),APIQuitDate,112) as INT) 
	FROM Staging.API_PMID_Mapping AS x


	--Update dbo.PharmacyDim
	UPDATE x
	SET [APIEffectiveDate] = s.[APIEffectiveDate]
	, [APIQuitDate] = s.[APIQuitDate]
	, [APIEffectiveDateKey] = s.[APIEffectiveDateKey]
	, [APIQuitDateKey] = s.[APIQuitDateKey]
	FROM [Staging].[PharmacyDim] AS x
	INNER JOIN [Staging].[API_PMID_Mapping] AS s (NOLOCK) ON x.PMID = s.PMID
	
END
GO
