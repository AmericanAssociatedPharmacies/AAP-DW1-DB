USE [ReportsTest]
GO
/****** Object:  View [test].[vw_CAH]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [test].[vw_CAH]
AS 
SELECT 
       t1.[CUSTOMER_NAME]
      ,t1.[CUSTOMER_NO]
      ,t1.[ITEM_NO]
      ,t1.[PMID]
      ,t1.[STORE]
      ,t1.[NDC]
      ,t1.[ITEM_TYPE]
      ,t1.[ITEM_DESCR]
      ,t1.[GENERIC_NAME]
      ,t1.[TRADE_NAME]
      ,t1.[INV_DATE]
      ,t1.[INVOICE_NO]
      ,t1.[TYPE]
      ,t1.[ORDER_QTY]
      ,t1.[SHIP_QTY]
      ,t1.[UNIT_COST]
      ,t1.[EXT_COST]
      ,t1.[CORP_AWP]
      ,t1.[WAC]
      ,t1.[VENDOR_NAME]
      ,t1.[UPC]
      ,t1.[CONTRACT_FLAG]
      ,t1.[BRAND]
      ,t1.[GENERIC_CODE]
      ,t1.[STRENGTH]
      ,t1.[SHORT_CODE]
      ,t1.[ENCODING]
      ,t1.[ContractNo]
      ,t1.[ContractDesc]
      ,t1.[MM_DD_YY_LOAD]
FROM Purchases.dbo.CHPH_AAP AS t1
JOIN Medispan.dbo.DrugMaster AS t2 ON t1.NDC = t2.NDC
WHERE t2.GPI IN
(
 --GRP 1
'50250065007220', '44505050100330', '57200005100330', '27607050100330', '75100090100320', '33200022100310', '36994002500345', '68000010000310', '33300007000305', '62051025100310', '27250050007530', '49200020100305', '85158020100320', '90550085103720', '86309903324210', '86101070002005', '89100010003720', '24000035000310', '36994002450340', '62051025100320', '25990002950310', '03400010001930', '44505050100520', '90550085103710', '90154045003710'
    --GRP 2
, '27607050100340', '03400010000320', '67406025100340', '27607050100320', '59250015000350', '90051010102005', '33100040107030', '36202005100310', '36100020100315', '58180090100360', '27607050100330', '86802065102030', '36150080000310', '86802065102020', '59250015000340', '33100010000303', '04000020100310', '04000020100105', '04000020100110', '27200027000340', '27200027000320', '73203060100305', '37600040000303', '87100060002010', '36202005100320'
)
AND t1.INV_DATE > '20180101'
AND t1.EXT_COST > 0

GO
