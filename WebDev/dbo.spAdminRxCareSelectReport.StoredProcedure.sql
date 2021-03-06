USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spAdminRxCareSelectReport]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spAdminRxCareSelectReport]
AS
SELECT --[id]
[date_registered]
      ,[Firstname]
      ,[Initial]
      ,[Lastname]
      ,[Gender]
      ,[Address1]
      ,[Address2]
      ,[City]
      ,[State]
      ,[Zip]
      ,[Email]
      ,[Pharmacy]
  FROM [WebDev].[dbo].[RxCareSelect]
order by [date_registered] desc
GO
