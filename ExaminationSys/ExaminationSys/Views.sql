create view CrsExamPerYearVE
as
select distinct E.ExamId, YEAR(E.StartTime) 'Exam Year', C.CrsId, C.CrsTitle, I.InsId, I.InsName
from Exam E, ExamQuestion EQ, Course C, Instructor I
where EQ.ExamId = E.ExamId and EQ.CrsId = C.CrsId and C.InsId = I.InsId
exec auth
go
--View for displaying StdtxtQst to enable instructor to review them and update marks manually
create or alter view ForReviewTxtQstVE
as
select SA.QstId, SA.ExamId, SA.StdId, IIF(SA.StdDegree <> 0, 'Valid', 'Not Valid') as 'Validity', TX.TxtContent, TX.TxtBestAnswer, SA.StdAnswer, SA.StdDegree
from TxtQuestion TX, StdAnswers SA
where TX.TxtId = SA.QstID and SA.QstType = 'TXQ'

select * from ForReviewTxtQstVE

go
--for displaying MCQ for specific Exam, called by ShowExamSP
create or alter view MCQExamContentVE
as
select EQ.ExamId, MC.McqId, MC.McqContent, MC.Choice1, MC.Choice2, MC.Choice3, EQ.QstType, EQ.QstDegree
from ExamQuestion EQ, MCQuestion MC
where EQ.McqId = MC.McqId

go
--for displaying TFQ for specific Exam, called by ShowExamSP
create or alter view TFQExamContentVE
as
select EQ.ExamId, TF.TfqId, TF.TfqContent, EQ.QstType, EQ.QstDegree
from ExamQuestion EQ, TFQuestion TF
where EQ.TfqId = TF.TfqId

go
--for displaying TXQ for specific Exam, called by ShowExamSP
create or alter view TXQExamContentVE
as
select EQ.ExamId, TX.TxtId, TX.TxtContent, EQ.QstType, EQ.QstDegree
from ExamQuestion EQ, TxtQuestion TX
where EQ.TxtId = TX.TxtId

go
select * from MCQExamContentVE
select * from TFQExamContentVE
select * from TXQExamContentVE

go
--called by SearchOnStdSP which used for searching
create or alter view StdInfoVE
as
select S.*, D.DeptName, I.IntakeNumber, B.BranchName, T.TrackName, C.CrsTitle, Ins.InsName
from Student S, BranchDetails BD, Department D, Intake I, Branch B, Track T, Course C, Instructor Ins
where S.StdId = BD.StdId
and D.DeptId = BD.DeptId
and I.IntakeId = BD.IntakeId
and B.BranchId = BD.BranchId
and T.TrackId = BD.TrackId
and C.CrsId = BD.CrsId
and C.InsId = Ins.InsId

go
--called by SearchOnStdSP which used for searching
create or alter view ExamQstInfoVE
as
select EQ.ExamId, sum(EQ.QstDegree) 'Total Degree', C.CrsTitle, E.StartTime, E.EndTime, IIF(E.IsCorrective = 0, 'Normal Exam', 'Corrective') 'Exam Status', A.Calculator, A.OpenBook, A.UseInternet
from ExamQuestion EQ, Course C, Exam E, Allowance A
where EQ.ExamId = E.ExamId
and C.CrsId = EQ.CrsId
and A.ExamId = EQ.ExamId
group by EQ.ExamId, C.CrsTitle, E.StartTime, E.EndTime, E.IsCorrective, A.Calculator, A.OpenBook, A.UseInternet

select * from ExamQstInfoVE