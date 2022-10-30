--for enabling instructor to update specific QstDegree, then Update Exam Result
create or alter proc updateQstDegreeSP @ExamId int, @QstId int, @StdId int, @Degree int
as
begin
	update StdAnswers
	set StdDegree = @Degree
	where ExamId = @ExamId and QstId = @QstId and StdId = @StdId and QstType = 'TXQ'
	--call SP to update Exam Result
	exec SubmitExamSP @StdId, @ExamId
end

select * from StudentExam

select * from StdAnswers

exec updateQstDegree 3, 1, 2, 0

---
go
-- SP for submit one answer only for student in exam
create or alter proc AnswerThisQstSP @StdAnswer nvarchar(200), @QstId int, @QstType char(3), @StdId int, @ExamId int
as
begin
	if @QstType in ('MCQ', 'TFQ', 'TXQ')
	begin
		insert into StdAnswers
		values (@QstId, @QstType, @StdAnswer, @StdId, @ExamId, null, default)
	end
	else
		select 'you can only answer one of the following (MCQ or TFQ or TXQ)'
end

exec AnswerThisQstSP '3', 2, 'MCQ', 2, 3
exec AnswerThisQstSP '2', 1, 'ksl', 2, 3

go
-- SP to update exam result for student
create or alter proc SubmitExamSP @StdId int, @ExamId int
as
begin
	declare @result int
	set @result = dbo.FN_CalcExamResult(@StdId, @ExamId)

	update StudentExam
	set  Result = @result
	where StdId = @StdId and ExamId = @ExamId
end

exec SubmitExamSP 2, 3
delete from StudentExam
select * from StudentExam

go
-- Fn for calc final result of the exam for the student
Create or alter function FN_CalcExamResult (@StdId int, @ExamId int)
returns int
As
Begin 
	declare @result int
	set @result = (select SUM(StdDegree) from StdAnswers where StdId = @StdId and ExamId = @ExamId)
	return @result;
end

--- 
select dbo.FN_CalcExamResult (1003,12)

select * from StdAnswers
go
create  proc showTxtAnswerSP @StdId int , @ExamId int
as 
begin
	select * 
	from ForReviewTxtQstVE 
	where StdId = @StdId and ExamId = @ExamId
end

