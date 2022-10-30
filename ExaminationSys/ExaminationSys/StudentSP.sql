create or alter proc addStdPersonalInfoSP @name nvarchar(50), @email nvarchar(50), @username nvarchar(50), @password nvarchar(50)
as
begin
	insert into Student
	values (@name, @email, @username, @password)
end

go
exec addStdPersonalInfoSP 'omar', 'omarzareeef2400092@gmail.com', 'omarzareeef', 'omarpass'

go
create or alter proc addBranchDetailsSP @deptId int, @intakeId int, @branchId int, @trackId int, @crsId int, @stdId int
as
begin
	insert into BranchDetails
	values (@deptId, @intakeId, @branchId, @trackId, @crsId, @stdId)
end
select * from Course

exec addBranchDetailsSP 16,16,16,16,1014,1002
exec addBranchDetailsSP 17,17,17,17,1014,1003
exec addBranchDetailsSP 18,18,18,18,1014,1004

go
create or alter proc updateStdNameSP @username nvarchar(50), @name nvarchar(50)
as
begin
	update Student
	set StdName = @name
	where StdUserName = @username;
end

go
create or alter proc updateStdEmailSP @username nvarchar(50), @email nvarchar(50)
as
begin
	update Student
	set StdEmail = @email
	where StdUserName = @username;
end

go
create or alter proc updateStdUserNameSP @oldUsername nvarchar(50), @newUsername nvarchar(50)
as
begin
	update Student
	set StdUserName = @newUsername
	where StdUserName = @oldUsername;
end

go
create or alter proc updateStdPasswordSP @username nvarchar(50), @password nvarchar(50)
as
begin
	update Student
	set StdPassword = @password
	where StdUserName = @username;
end