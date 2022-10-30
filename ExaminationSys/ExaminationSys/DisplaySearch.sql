--proc for displaying Exam for Std
create or alter proc ShowExamSP  @ExamId int, @StdId int
as
begin
	if exists(select * from StudentExam where ExamId = @ExamId and StdId = @StdId)
	begin
	declare @StDate Datetime, @endDate Datetime
	set @StDate = ( select StartTime  from Exam where ExamId = @ExamId)
	set @endDate = ( select EndTime  from Exam where ExamId = @ExamId)

		if GETDATE() between  @StDate  and @endDate 
		begin
			select * from MCQExamContentVE where ExamId = @ExamId
			select * from TFQExamContentVE where ExamId = @ExamId
			select * from TXQExamContentVE where ExamId = @ExamId
		end
		else
		begin
			Print 'Exam Not Allowed For Now'
		end
	end
	else
	begin
		print 'Auth Denied'
	end
end

exec ShowExamSP 14, 1003

select * from Exam


go
--for searching on Std with different options
create or alter proc SearchOnStdSP @StdId int = null, @StdUsername nvarchar(50) = null, @StdEmail nvarchar(50) = null
as 
begin 
	if @StdId is not null
	begin
		select * from StdInfoVE 
		where StdId = @StdId
	end
	else
	begin
		if @StdUsername is not null
		begin
			select * from StdInfoVE 
			where StdUserName = @StdUsername
		end
		else
		begin
			if @StdEmail is not null
			begin
				select * from StdInfoVE 
				where StdEmail = @StdEmail
			end
			else
			begin
				print 'you should search with one option at least'
			end
		end
	end
end

exec SearchOnStdSP 3 --id
exec SearchOnStdSP default, 'NadaUser' --username
exec SearchOnStdSP default, default, 'Nada@gmail.com' --email

go
--for searching on Exam with different options
create or alter proc SearchOnExamSP @ExamId int = null, @CrsTitle nvarchar(50) = null
as
begin
	if @ExamId is not null
	begin
		select * from ExamQstInfoVE 
		where ExamId = @ExamId
	end
	else
	begin
		if @CrsTitle is not null
		begin
			select * from ExamQstInfoVE 
			where CrsTitle = @CrsTitle
		end
		else
		begin
			print 'you should search with one option at least'
		end
	end
end

exec SearchOnExam 3 --ExamId
exec SearchOnExam default, 'XML' --CrsTilte