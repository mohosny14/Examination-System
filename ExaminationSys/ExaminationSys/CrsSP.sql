create proc addCourseSP @title nvarchar(50), @desc nvarchar(200), @minDegree int, @maxDegree int, @insId int
as
begin
	insert into Course
	values (@title, @desc, @minDegree, @maxDegree, @insId)
end

go
exec addCourseSP 'python', 'used for web and artificial intelligence', 100, 200, 3

go
create proc updateCrsTitleSP @crsId int, @title nvarchar(50)
as
begin
	update Course
	set CrsTitle = @title
	where CrsId = @crsId;
end

go
exec updateCrsTitleSP 5, 'pythonUpdated';

go
create proc updateCrsDescSP @crsId int, @desc nvarchar(200)
as
begin
	update Course
	set CrsDesc = @desc
	where CrsId = @crsId;
end

go
create proc updateCrsMinMaxDegreeSP @crsId int, @minDegree int, @maxDegree int
as
begin
	update Course
	set CrsMaxDegree = @minDegree, CrsMinDegree = @maxDegree
	where CrsId = @crsId;
end

go
create proc updateCrsInsIdSP @crsId int, @insId int
as
begin
	update Course
	set InsId = @insId
	where CrsId = @crsId;
end

go
create proc deleteCourseSP @crsId int
as
begin
	delete from Course where CrsId = @crsId;
end

go
exec deleteCourseSP 4