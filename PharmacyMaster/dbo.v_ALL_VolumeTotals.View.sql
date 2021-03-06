USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_ALL_VolumeTotals]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ALL_VolumeTotals]
AS
SELECT DISTINCT date ,  
 sum(AAPNetSales) as AAPNetSales,
 sum(AAPBrand) as AAPBrand,
 sum(AAPGENTotal) as AAPGENTotal,
 sum(AAPGENTotalSrc) as AAPGENTotalSrc,
 sum(AAPGENExcl) as AAPGENExcl,
 sum(AAPOTC) as AAPOTC,
 sum(AAPOther) as AAPOther,
 sum(UDNetSales) as UDNetSales,
 sum(WHAPIBrand) as WHAPIBrand,
 sum(WHAPIBrandUnits) as WHAPIBrandUnits,
 sum(WHAPIGeneric) as WHAPIGeneric,
 sum(WHAPIGenericUnits) as WHAPIGenericUnits,
 sum(WHAPIOTC) as WHAPIOTC,
 sum(WHAPIOTCUnits) as WHAPIOTCUnits,
 sum(WHAPITotal) as WHAPITotal,
 sum(MLTotal) as MLTotal
from all_volume group by date

GO
