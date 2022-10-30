-- Trigger for checking the StdAnswer and update StdAnswers Table with the degree of the Question.
create  trigger checkStdAnswer
on StdAnswers
after insert
as
begin
	declare @QstType char(3);
	set @QstType = (select QstType from inserted);
	
	declare @id int, @degree int, @result int
	if(@QstType = 'MCQ')
	begin
		
		set @id = (select top(1) QstId from inserted order by [time] desc);
		set @degree = (select top(1) QstDegree from ExamQuestion where McqId = @id and QstType = 'MCQ')
		
		set @result = (select top(1) IIF(MC.McqCorrectChoice = SA.StdAnswer, @degree, 0) 
						from MCQuestion MC, StdAnswers SA
						where MC.McqId = @id and SA.QstType = 'MCQ'
						order by [time] desc)
		--select @id, @degree, @MCDegree;
		update StdAnswers
		set StdDegree = @result
		where QstId = @id and QstType = 'MCQ'
	end
	else
	begin
		if(@QstType = 'TFQ')
		begin
			set @id = (select top(1) QstId from inserted order by [time] desc);
			set @degree = (select top(1) QstDegree from ExamQuestion where TfqId = @id and QstType = 'TFQ')

			set @result = (select top(1) IIF(TF.TfqCorrectAnswer = SA.StdAnswer, @degree, 0) 
							from TFQuestion TF, StdAnswers SA
							where TF.TfqId = @id and SA.QstType = 'TFQ'
							order by [time] desc)
			update StdAnswers
			set StdDegree = @result
			where QstId = @id and QstType = 'TFQ'
		end
		else
		begin
			set @id = (select top(1) QstId from inserted order by [time] desc);
			set @degree = (select top(1) QstDegree from ExamQuestion where TxtId = @id and QstType = 'TXQ')
		
			set @result = (select top(1) iif(dbo.CompareAnswer(TX.TxtBestAnswer, SA.StdAnswer) >= 80, @degree, 0)
							from TxtQuestion TX, StdAnswers SA
							where TX.TxtId = @id and SA.QstType = 'TXQ'
							order by [time] desc)
			update StdAnswers
			set StdDegree = @result
			where QstId = @id and QstType = 'TXQ'
		end
	end
end

go



/*
select count(MC.McqCorrectChoice)
from MCQuestion MC, StdAnswers SA
where MC.McqId = SA.QstId and MC.McqCorrectChoice = SA.StdAnswer

delete from StdAnswers

select * from StdAnswers
select * from ExamQuestion
select * from MCQuestion


select iif(TF.TfqCorrectAnswer = SA.StdAnswer, 1, 0)
from TFQuestion TF, StdAnswers SA
where TF.TfqId = SA.QstId and SA.QstType = 'TFQ'


update StdAnswers
set StdDegree = (select IIF(MC.McqCorrectChoice = SA.StdAnswer, 10, 0)
from MCQuestion MC join StdAnswers SA
on MC.McqId = SA.QstId and SA.QstType = 'MCQ')
where exists (select * from StdAnswers where QstType = 'MCQ')

update StdAnswers
set StdDegree = null
where QstId = 3

select top (10) TfqId
		from TFQuestion
		order by newid()
*/