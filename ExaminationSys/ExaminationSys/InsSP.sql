create or alter proc addInstructorSP @name nvarchar(50), @username nvarchar(50), @password nvarchar(50), @superId int
as
begin
	insert into Instructor
	values (@name , @username , @password , @superId)
end

go
create or alter proc updateInsNameSP @username nvarchar(50), @name nvarchar(50)
as
begin
	update Instructor
	set InsName = @name
	where InsUserName = @username;
end

go
create or alter proc updateInsUserNameSP @oldUsername nvarchar(50), @newUsername nvarchar(50)
as
begin
	update Instructor
	set InsUserName = @newUsername
	where InsUserName = @oldUsername;
end

go
create or alter proc updateInsPasswordSP @username nvarchar(50), @password nvarchar(50)
as
begin
	update Instructor
	set InsPassword = @password
	where InsUserName = @username;
end

go
create or alter proc deleteInstructorSP @username nvarchar(50)
as
begin
	delete from Instructor where InsUserName = @username;
end