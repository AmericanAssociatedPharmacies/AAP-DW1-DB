USE [WebDev]
GO
/****** Object:  Table [dbo].[test_RCRebate_2013]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test_RCRebate_2013](
	[TM] [varchar](20) NULL,
	[PMID] [int] NULL,
	[AAP#] [varchar](25) NULL,
	[Parent#] [varchar](25) NULL,
	[API#] [varchar](25) NULL,
	[AAP Eff] [varchar](25) NULL,
	[AAP Quit] [varchar](25) NULL,
	[Description] [varchar](100) NULL,
	[Affiliate] [varchar](100) NULL,
	[Account DBA Name] [varchar](100) NULL,
	[Account Corporate Name] [varchar](100) NULL,
	[Address] [varchar](250) NULL,
	[City] [varchar](100) NULL,
	[St] [varchar](100) NULL,
	[Contact] [varchar](150) NULL,
	[MC Network] [varchar](150) NULL,
	[PP Volume 2013Q1] [float] NULL,
	[PP Rebate 2013Q1] [float] NULL,
	[PP Volume 2013Q2] [float] NULL,
	[PP Rebate 2013Q2] [float] NULL,
	[PP Volume 2013Q3] [float] NULL,
	[PP Rebate 2013Q3] [float] NULL,
	[PP Volume 2013Q4] [float] NULL,
	[PP Rebate 2013Q4] [float] NULL,
	[Total PP Rebate 2013] [float] NULL,
	[Q1 API Whse Rebate] [float] NULL,
	[Q1 API Generic Rebate%] [float] NULL,
	[Q1 API Brand Credits Disbursed] [float] NULL,
	[Q1 API Accelerated Pay Discount] [float] NULL,
	[Q2 API Whse Rebate] [float] NULL,
	[Q2 API Generic Rebate%] [float] NULL,
	[Q2 API Brand Credits Disbursed] [float] NULL,
	[Q2 API Accelerated Pay Discount] [float] NULL,
	[Q3 API Whse Rebate] [float] NULL,
	[Q3 API Generic Rebate%] [float] NULL,
	[Q3 API Brand Credits Disbursed] [float] NULL,
	[Q3 API Accelerated Pay Discount] [float] NULL,
	[Q4 API Whse Rebate] [float] NULL,
	[Q4 API Generic Rebate%] [float] NULL,
	[Q4 API Brand Credits Disbursed] [float] NULL,
	[Q4 API Accelerated Pay Discount] [float] NULL,
	[Total API Whse Rebate 2013] [float] NULL,
	[Total API Brand Credits Disbursed 2013] [float] NULL,
	[Total API Accelerated Pay Discount 2013] [float] NULL,
	[HV Incentive 0113] [float] NULL,
	[HV COG Reduction 0113] [float] NULL,
	[HV Incentive 0213] [float] NULL,
	[HV COG Reduction 0213] [float] NULL,
	[HV Incentive 0313] [float] NULL,
	[HV COG Reduction 0313] [float] NULL,
	[HV Incentive 0413] [float] NULL,
	[HV COG Reduction 0413] [float] NULL,
	[HV Incentive 0513] [float] NULL,
	[HV COG Reduction 0513] [float] NULL,
	[HV Incentive 0613] [float] NULL,
	[HV COG Reduction 0613] [float] NULL,
	[HV Incentive 0713] [float] NULL,
	[HV COG Reduction 0713] [float] NULL,
	[HV Incentive 0813] [float] NULL,
	[HV COG Reduction 0813] [float] NULL,
	[HV Incentive 0913] [float] NULL,
	[HV COG Reduction 0913] [float] NULL,
	[HV Incentive 1013] [float] NULL,
	[HV COG Reduction 1013] [float] NULL,
	[HV Incentive 1113] [float] NULL,
	[HV COG Reduction 1113] [float] NULL,
	[HV Incentive 1213] [float] NULL,
	[HV COG Reduction 1213] [float] NULL,
	[Total HV Incentive 2013] [float] NULL,
	[Conf Volume 0413] [float] NULL,
	[Conf Rebate 0413] [float] NULL,
	[Conf Volume 0513] [float] NULL,
	[Conf Rebate 0513] [float] NULL,
	[Total Conf Volume 2013] [float] NULL,
	[Total Conf Rebate 2013] [float] NULL,
	[Cardinal Rebates 2013Q1] [float] NULL,
	[Cardinal Rebates 2013Q2] [float] NULL,
	[Cardinal Rebates 2013Q3] [float] NULL,
	[Cardinal Rebates 2013Q4] [float] NULL,
	[Total Cardinal Rebates 2013] [float] NULL,
	[01/13 Source Sales] [float] NULL,
	[01/13 AAP Gen Rebate] [float] NULL,
	[01/13 Avg%] [float] NULL,
	[01/13 HRTA%] [float] NULL,
	[01/13 PaymentMethod] [varchar](50) NULL,
	[02/13 Source Sales] [float] NULL,
	[02/13 AAP Gen Rebate] [float] NULL,
	[02/13 Avg%] [float] NULL,
	[02/13 HRTA%] [float] NULL,
	[02/13 PaymentMethod] [varchar](50) NULL,
	[03/13 Source Sales] [float] NULL,
	[03/13 AAP Gen Rebate] [float] NULL,
	[03/13 Avg%] [float] NULL,
	[03/13 HRTA%] [float] NULL,
	[03/13 PaymentMethod] [varchar](50) NULL,
	[04/13 Source Sales] [float] NULL,
	[04/13 AAP Gen Rebate] [float] NULL,
	[04/13 Avg%] [float] NULL,
	[04/13 HRTA%] [float] NULL,
	[04/13 PaymentMethod] [varchar](50) NULL,
	[05/13 Source Sales] [float] NULL,
	[05/13 AAP Gen Rebate] [float] NULL,
	[05/13 Avg%] [float] NULL,
	[05/13 HRTA%] [float] NULL,
	[05/13 PaymentMethod] [varchar](50) NULL,
	[06/13 Source Sales] [float] NULL,
	[06/13 AAP Gen Rebate] [float] NULL,
	[06/13 Avg%] [float] NULL,
	[06/13 HRTA%] [float] NULL,
	[06/13 PaymentMethod] [varchar](50) NULL,
	[07/13 Source Sales] [float] NULL,
	[07/13 AAP Gen Rebate] [float] NULL,
	[07/13 Avg%] [float] NULL,
	[07/13 HRTA%] [float] NULL,
	[07/13 PaymentMethod] [varchar](50) NULL,
	[08/13 Source Sales] [float] NULL,
	[08/13 AAP Gen Rebate] [float] NULL,
	[08/13 Avg%] [float] NULL,
	[08/13 HRTA%] [float] NULL,
	[08/13 PaymentMethod] [varchar](50) NULL,
	[09/13 Source Sales] [float] NULL,
	[09/13 AAP Gen Rebate] [float] NULL,
	[09/13 Avg%] [float] NULL,
	[09/13 HRTA%] [float] NULL,
	[09/13 PaymentMethod] [varchar](50) NULL,
	[10/13 Source Sales] [float] NULL,
	[10/13 AAP Gen Rebate] [float] NULL,
	[10/13 Avg%] [float] NULL,
	[10/13 HRTA%] [float] NULL,
	[10/13 PaymentMethod] [varchar](50) NULL,
	[11/13 Source Sales] [float] NULL,
	[11/13 AAP Gen Rebate] [float] NULL,
	[11/13 Avg%] [float] NULL,
	[11/13 HRTA%] [float] NULL,
	[11/13 PaymentMethod] [varchar](50) NULL,
	[12/13 Source Sales] [float] NULL,
	[12/13 AAP Gen Rebate] [float] NULL,
	[12/13 Avg%] [float] NULL,
	[12/13 HRTA%] [float] NULL,
	[12/13 PaymentMethod] [varchar](50) NULL,
	[Total CH AAP Gen Rebate 2013] [float] NULL,
	[Contract Performance Rebate 2013] [float] NULL,
	[Planogram Rebate 2013] [float] NULL,
	[API Generic Incentive 2013] [float] NULL,
	[AAP Patronage Dividend 2013] [float] NULL,
	[Total YTD All Rebates 2013] [float] NULL
) ON [PRIMARY]
GO
