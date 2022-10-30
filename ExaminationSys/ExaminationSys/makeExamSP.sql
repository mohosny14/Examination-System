go
--Create Exam by Instructor
create or alter proc addExamSP @startTime date, @endTime date, @isCorrective bit, @calc bit = 0, @openBook bit = 0, @useNet bit = 0
as
begin
	insert into Exam
	values (@startTime, @endTime, @isCorrective)

	declare @examId int
	set @examId = (select max(ExamId) from Exam)

	insert into Allowance
	values (@calc, @openBook, @useNet, @examId)

	print 'Your Exam Id = '+cast(@examId as nvarchar(5))
end

exec addExamSP '2022-09-16', '2022-09-18', 0, 1, 1, 0
select * from BranchDetails
select * from Exam
select * from Allowance

select * from StudentExam

go
create or alter proc addQstRandomlySP @examId int, @CrsId int, @McqNum int, @TfqNum int,
@TxtNum int, @McqDeg int, @TfqDeg int, @TxtDeg int
as
begin
	declare @totalDegree int, @maxDegree int
	set @totalDegree = (@McqNum * @McqDeg) + (@TfqNum * @TfqDeg) + (@TxtNum * @TxtDeg) +
						(select SUM(QstDegree) from ExamQuestion  where ExamId = @examId)
	set @maxDegree = (select CrsMaxDegree from Course where CrsId = @CrsId)
	if (@totalDegree >= @maxDegree)
	begin
		print 'Cannot Insert, you exceed Max Degree';
	end
	else
	begin
		insert into ExamQuestion (McqId, ExamId, QstDegree, QstType, CrsId)  
		select top (@McqNum) McqId, @examId, @McqDeg, 'MCQ', @CrsId 
		from MCQuestion
		order by newid()

		insert into ExamQuestion (TfqId, ExamId, QstDegree, QstType, CrsId)  
		select top (@TfqNum) TfqId, @examId, @TfqDeg, 'TFQ', @CrsId 
		from TFQuestion
		order by newid()

		insert into ExamQuestion (TxtId, ExamId, QstDegree, QstType, CrsId)  
		select top (@TxtNum) TxtId, @examId, @TxtDeg, 'TXQ', @CrsId 
		from TxtQuestion
		order by newid()
	end
end

exec addQstRandomlySP 14, 2, 3, 3, 3, 5, 5, 5

select SUM(QstDegree) from ExamQuestion where ExamId = 3

go
create or alter proc addQstManuallySP @examId int, @qstId int, @qstDegree int, @qstType nvarchar(3), @CrsId int
as
begin
	declare @totalDegree int, @maxDegree int
	set @totalDegree = (select SUM(QstDegree) from ExamQuestion  where ExamId = @examId)
	set @maxDegree = (select CrsMaxDegree from Course where CrsId = @CrsId)
	if ((@totalDegree+@qstDegree) >= @maxDegree)
	begin
		print @totalDegree;
		print @qstDegree;
		print @maxDegree;
		print 'Cannot Insert, you exceed Max Degree';
	end
	else
	begin
		if (@qstType = 'TFQ')
		begin
			insert into ExamQuestion (ExamId, TfqId, QstDegree, QstType, CrsId)
			values (@examId , @qstId , @qstDegree , @qstType, @CrsId);
		end
		else
		begin
			if (@qstType = 'MCQ')
			begin
				insert into ExamQuestion (ExamId, McqId, QstDegree, QstType, CrsId)
				values (@examId , @qstId , @qstDegree , @qstType, @CrsId);
			end
			else
			begin
				if (@qstType = 'TXQ')
				begin
					insert into ExamQuestion (ExamId, TxtId, QstDegree, QstType, CrsId)
					values (@examId , @qstId , @qstDegree , @qstType, @CrsId);
				end
			end
		end
	end
end

exec addQstManuallySP 3, 2, 11, 'TXQ', 2

go
--allow std for doing Exam after validate that Std and Ins are at the same Crs(Student=>one by one)
create or alter proc addStdForExam @ExamId int, @StdId int, @InsId int
as
begin
	if exists(select StdId, InsId, B.CrsId from
	(select StdId, CrsId from BranchDetails where StdId = @StdId) B, (select InsId, CrsId from Course where InsId = @InsId) C, (select CrsId from ExamQuestion where ExamId = @ExamId) EQ
	where B.CrsId = C.CrsId and EQ.CrsId = B.CrsId)
	begin
		insert into StudentExam
		values (@StdId, @ExamId, -1)
	end
	else
	begin
		print 'Wrong Info'
	end
end

exec addStdForExam 14,1002,2

select * from StudentExam

select * from Course
select * from BranchDetails


-- 
go
create or alter proc getStdsId @CrsId int
as
begin
	select b.StdId 
	from  BranchDetails b , Course c
	where c.CrsId = b.CrsId and  c.CrsId = @CrsId
end