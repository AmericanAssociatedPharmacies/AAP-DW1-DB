USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_Units]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAH_Units]
AS
     SET NOCOUNT ON;
    BEGIN
        BEGIN TRY
            BEGIN TRAN;
            TRUNCATE TABLE SSRS.dbo.CAHUnits;
            INSERT INTO SSRS.dbo.CAHUnits
            (PMID, 
             Month, 
             Year, 
             Units
            )
                   SELECT a.PMID, 
                          a.Month, 
                          a.Year, 
                          a.Units
                   FROM SSRS.dbo.vw_GXUnits__CAH AS a;
            COMMIT TRAN;
        END TRY
        BEGIN CATCH
            ROLLBACK TRAN;
        END CATCH;
    END;
GO
