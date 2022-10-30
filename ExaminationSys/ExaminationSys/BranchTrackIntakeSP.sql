create proc addBranchSP @name nvarchar(50)
as
begin
	insert into Branch
	values (@name)
end

go
create proc updateBranchNameSP @branchId int, @name nvarchar(50)
as
begin
	update Branch
	set BranchName = @name
	where BranchId = @branchId;
end

go
create proc addTrackSP @name nvarchar(50)
as
begin
	insert into Track
	values (@name)
end

go
create proc updateTrackNameSP @trackId int, @name nvarchar(50)
as
begin
	update Track
	set TrackName = @name
	where TrackId = @trackId;
end

go
create proc addIntakeSP @num int
as
begin
	insert into Intake
	values (@num)
end

go
create proc updateIntakeNumSP @intakeId int, @num int
as
begin
	update Intake
	set IntakeNumber = @num
	where IntakeId = @intakeId;
end