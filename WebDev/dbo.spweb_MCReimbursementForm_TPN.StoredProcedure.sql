USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_MCReimbursementForm_TPN]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spweb_MCReimbursementForm_TPN]
	(
/*
		x Add Med Part D with an option to select Yes  No just like the compound field.  Insert between Submitted Group # and Member Name.
         x Add AWP Amt of Product Dispensed-  insert between the Day Supply & Cost of Product Dispensed
        x Add Submitted Cost- insert between the day supply and cost of product dispensed.
        x  Add HDSmith to the Product Purchase From  dropdown menu
*/
		@BIN nvarchar(10),
		@PCN nvarchar(50),
		@Group nvarchar(10),
		@MedPartD bit,		--added 7/31/16
		@PatName nvarchar(100),
		@PatID nvarchar(50),
		@PatDOB smalldatetime,
		@Wholesaler nvarchar(100),
		@NDC nvarchar(11),
		@Filldate smalldatetime,
		@Quantity int,
		@RxNbr nvarchar(20),
		@DaySupply nvarchar(20),
		@AWPAmtDispensed nvarchar(20), --added 7/31/16
		@SubmittedCost float,	--added 7/31/16
		@TotalCost float,
		@TotalPaid float,
		@DispensingFee float,
		@Compound bit,
		@Maced bit,
		@NCPDP nvarchar(20),
		@ContactName nvarchar(100),
		@email nvarchar(100),
		@Phone nvarchar(20),
		@Fax nvarchar(20),		
		@username nvarchar(50),		
		@Notes text --last field
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @trackid int
	DECLARE @requestid int
	DECLARE @body nvarchar(500)	
	DECLARE @exist int

	set @exist=0
		
	INSERT INTO rform_claims_research_TPN (BIN,PCN,[Group],MedPartD,PatName,PatID,PatDOB,Wholesaler,NDC,
Filldate,Quantity,RxNbr,DaySupply,AWPAmtDispensed,SubmittedCost,TotalCost,TotalPaid,Maced,NCPDP,ContactName,email,
Phone,Fax,CreatedOn,CreatedBy,Notes,DispensingFee,Compound) 
	VALUES (@BIN,@PCN,@Group,@MedPartD,@PatName,@PatID,@PatDOB,
@Wholesaler,@NDC,@Filldate,@Quantity,@RxNbr,@DaySupply,@AWPAmtDispensed,@SubmittedCost,@TotalCost,
@TotalPaid,@Maced,@NCPDP,@ContactName,@email,@Phone,@Fax,getdate(),@username,@Notes,@DispensingFee,@Compound)



END
GO
