USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spMCenterTable]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spMCenterTable]
(
	@value varchar(255),
	@tablename varchar(255),
	@columnname varchar(255)
)
as
begin
declare @result nvarchar(255)
declare @buf nvarchar(255)
declare @parms nvarchar(255)
set @buf='select @resultOUT=cast(' + @columnname + ' as nvarchar(255)) from ' + @tablename + ' where ' + @columnname + '=@svalue'

set @parms=N'@svalue nvarchar(255),@resultOUT nvarchar(255) OUTPUT'
execute sp_executesql @buf,@parms,@svalue=@value,@resultOUT=@result OUTPUT;
select case when @result is null then 0 else 1 end as result

end
GO
