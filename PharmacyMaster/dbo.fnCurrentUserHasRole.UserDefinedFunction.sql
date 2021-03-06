USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[fnCurrentUserHasRole]    Script Date: 12/22/2020 7:35:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fnCurrentUserHasRole]
(
	@rolename varchar(30)	--e.g. db_datawriter
) returns int				--1 if true else 0
as
--B.Grant 1/2011 fn('db_datawriter') returns 1 if current user has that role
begin
declare @iretval int
declare @role varchar(30)
select @iretval = 0	--default
select @role = cast(r.name as varchar(30))
 from sys.database_principals u  
         left join (sys.database_role_members m join sys.database_principals r on m.role_principal_id = r.principal_id) on u.principal_id = m.member_principal_id  
         left join sys.server_principals l on u.sid = l.sid  
 where u.name = SYSTEM_USER and u.type <> 'R'  
and r.name = @rolename
if @@ERROR != 0 goto errHandler
select @iretval = case when @role is null then 0 else 1 end
return @iretval

errHandler:
	return -1
end

GO
