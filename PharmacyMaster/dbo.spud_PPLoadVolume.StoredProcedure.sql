USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PPLoadVolume]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spud_PPLoadVolume]

	(
		@filename nvarchar(100),
		@vendorid int,
		@startdate smalldatetime,
		@enddate smalldatetime,
		@Loadedby nvarchar(50)
		--@filetype int
		
	)

	
AS
BEGIN

	Begin Tran ppLoad
			

			DECLARE @SQL varchar(2000)
			DECLARE @count int
			DECLARE @tran int

			SET NOCOUNT ON;

			
			
			--Validate the file getting loaded
			Select @count=count(*) from v_VendorLoad Where VendorID=@vendorid and FileName=@filename and PaidDt IS NULL

			If @count = 0

			BEGIN

				--Create tmp_PPVolume table
				CREATE TABLE [dbo].[tmp_PPVolume](
				[UDNo] [varchar](50) NULL,
				[Volume] [varchar](50) NULL,
				[Rebate] [varchar](50) NULL,
				[StoreName] [varchar](200) NULL
				) ON [PRIMARY]

				If @@error <> 0 
						Begin												
							Print 'Error on Delete Update tmp_WSAPIPrice'
							Rollback Tran ppLoad
							Return
						End	
				
				--Bulk insert file into tmp_PPVolume
				set @SQL = 'bulk insert tmp_ppvolume from ''C:\Data\PP\' + @filename ; --@filename;
				set @SQL = @SQL + ''' with (fieldterminator=''\t'',firstrow=2 )';

					
				exec(@SQL);
				If @@error <> 0 
						Begin												
							Print 'Error on bulk insert'
							Rollback Tran ppLoad
							Return
						End	

				--Format Volume field
				Update tmp_ppvolume set Volume =  LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Volume, '$', ''),'"',''),',',''),'(','-'),')',''))),
				Rebate =  LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Rebate, '$', ''),'"',''),',',''),'(','-'),')',''))),
				StoreName = LTRIM(RTRIM(REPLACE(REPLACE(StoreName, '"', ''),',','')))
				
				If @@error <> 0 
							Begin												
								Print 'Error on bulk insert'
								Rollback Tran ppLoad
								Return
							End	

				ALTER Table tmp_ppvolume	ALTER COLUMN Volume  numeric(28,4)	
				ALTER Table tmp_ppvolume	ALTER COLUMN Rebate  numeric(28,4)
				If @@error <> 0 
							Begin												
								Print 'Error on bulk insert'
								Rollback Tran ppLoad
								Return
							End	
				
			
					--Add vendorID to VendorTransaction
					INSERT INTO VendorTransaction(VendorID) 
					VALUES (@VendorID) 
					If @@error <> 0 
								Begin												
									Print 'Error on VendorTransaction'
									Rollback Tran ppLoad
									Return
								End						
					

					 SELECT @tran= Max(TransactionID) FROM VendorTransaction
			

				--Save File Details
				INSERT INTO VendorLoad(TransactionID,FileName,LoadDate,LoadedBy) 
				VALUES (@tran,@filename, getdate(),@Loadedby) 

				If @@error <> 0 
							Begin												
								Print 'Error on VendorLoad'
								Rollback Tran ppLoad
								Return
							End	

				--Get File ID
				DECLARE @fileid int
				SELECT @fileid = Max(FileID) FROM VendorLoad

				--Insert Data into VendorVolumeRebate table
				INSERT INTO VendorVolumeRebate(VendorID,UDNo,VolumeAmt,RebateAmt,StoreName,FileID,AccruedStartdt,AccruedEnddt,TransactionID) 
				SELECT @VendorID,UDNo,Volume,Rebate,StoreName,@fileid, @startdate,@enddate,@tran FROM tmp_PPVolume

				If @@error <> 0 
							Begin												
								Print 'Error on VendorVolumeRebate'
								Rollback Tran ppLoad
								Return
							End	

				--Set default Eligibility if Store is retired
				update VendorVolumeRebate set VendorVolumeRebate.Eligibility = 0 FROM VendorVolumeRebate JOIN v_VendorVolumeEligibility ON VendorVolumeRebate.PMID =  v_VendorVolumeEligibility.PMID
				WHERE  VendorVolumeRebate.FileID = @fileid  AND VendorVolumeRebate.StorePaidDt IS NULL AND (v_VendorVolumeEligibility.AAPQuitDate IS NOT NULL OR v_VendorVolumeEligibility.AAPAccountNo IS NULL ) 

				--Set default Affiliate from Pharmacy Master
				update VendorVolumeRebate set VendorVolumeRebate.Affiliate = dbo.fnAffiliateDirectPay(v_PM_AllWithAffiliates.Affiliate,v_PM_AllWithAffiliates.AAPParentNo,v_PM_AllWithAffiliates.UDParentNo) 
				FROM VendorVolumeRebate JOIN v_PM_AllWithAffiliates ON VendorVolumeRebate.PMID =  v_PM_AllWithAffiliates.PMID
				WHERE VendorVolumeRebate.FileID = @fileid 

				--Delete unneeded rows
				Delete from VendorVolumeRebate WHERE VolumeAmt IS NULL and RebateAmt IS NULL
				
				DELETE FROM VendorVolumeRebate WHERE (VolumeAmt = 0.00) AND (RebateAmt = 0.00)

				
				--Populate null PMIDs
				update VendorVolumeRebate set VendorVolumeRebate.PMID=PM_Pharmacy.PMID FROM VendorVolumeRebate JOIN PM_Pharmacy ON RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), VendorVolumeRebate.UDNo), 8) = RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), PM_Pharmacy.UDAccountNo), 8)
				WHERE VendorVolumeRebate.PMID IS NULL AND VendorVolumeRebate.FileID =@fileid

				update VendorVolumeRebate set VendorVolumeRebate.PMID=PM_Pharmacy.PMID FROM VendorVolumeRebate JOIN PM_Pharmacy ON RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), VendorVolumeRebate.UDNo), 8) = RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), PM_Pharmacy.AAPAccountNo), 8)
				WHERE VendorVolumeRebate.PMID IS NULL AND VendorVolumeRebate.FileID =@fileid

				update VendorVolumeRebate set VendorVolumeRebate.PMID=PM_Deleted.PMID FROM VendorVolumeRebate JOIN PM_Deleted ON RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), VendorVolumeRebate.UDNo), 8) = RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), PM_Deleted.UDAccountNo), 8)
				WHERE VendorVolumeRebate.PMID IS NULL AND VendorVolumeRebate.FileID =@fileid					
				
				update VendorVolumeRebate set VendorVolumeRebate.PMID=PM_Pharmacy.PMID FROM VendorVolumeRebate JOIN PM_Pharmacy ON RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), VendorVolumeRebate.UDNo), 8) = RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), PM_Pharmacy.PMID), 8)
				WHERE VendorVolumeRebate.PMID IS NULL AND VendorVolumeRebate.FileID =@fileid

				update VendorVolumeRebate set VendorVolumeRebate.PMID=PM_Deleted.PMID FROM VendorVolumeRebate JOIN PM_Deleted ON RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), VendorVolumeRebate.UDNo), 8) = RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), PM_Deleted.PMID), 8)
				WHERE VendorVolumeRebate.PMID IS NULL AND VendorVolumeRebate.FileID =@fileid

				update VendorVolumeRebate set VendorVolumeRebate.PMID=UD_PMID.PMID FROM VendorVolumeRebate JOIN UD_PMID ON RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), VendorVolumeRebate.UDNo), 8) = RIGHT(REPLICATE('0', 8) + CONVERT(varchar(8), UD_PMID.WSAccount), 8) 
				WHERE VendorVolumeRebate.PMID IS NULL AND VendorVolumeRebate.FileID =@fileid				
			
				--Drop tmp_PPVolume
				DROP TABLE tmp_PPVolume
				If @@error <> 0 
							Begin												
								Print 'Error on bulk insert'
								Rollback Tran ppLoad
								Return
							End	
			END

			Select @count as rcount, @tran as tranid
			
		SET NOCOUNT OFF;

	COMMIT Tran
END





















GO
