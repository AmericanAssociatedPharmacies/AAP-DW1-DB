USE [Analysis]
GO
/****** Object:  View [dbo].[AllVolume]    Script Date: 12/22/2020 6:06:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AllVolume]
	AS SELECT * FROM [PharmacyMaster].dbo.ALL_Volume_New
GO
