exec auth 
---------- Instructor----
select * from Exam
select * from Student
delete from Intake

select * from Branch
select * from Track
select * from Exam
select * from Exam

exec addExamSP '2022-10-10', '2022-10-11', 0, 1, 1, 0

exec updateQstDegreeSP 3, 1, 2, 0

exec addQstManuallySP 3, 2, 11, 'TXQ', 2


exec addQstRandomlySP 3, 2, 3, 3, 3, 5, 10, 15

exec proc_addMCQ 'The ____ clause is used to list the attributes desired in the result of a query.',
			 2,3,'1) Where','2) Select','3) From', 2
go 
exec proc_UpdateMCQ 1,'The ____ clause is used to list the attributes','WHERE clause can refer ',150, '1) Asp.net','2) Have','3) From',1

exec proc_DeleteMCQ  11

exec proc_addTFQ 'The condition in a WHERE clause can refer to only one value.','False',10,1

exec proc_UpdateTFQ 1,'he condition in a HAVE clause can refer to check','True',15,1

exec proc_DeleteTFQ 1

exec proc_addTxtQuestion 'Write an SQL query to fetch the EmpId and FullName of all the employees working under Manager with Id – ‘986’.',
			 'SELECT EmpId, FullName FROM EmployeeDetails WHERE ManagerId = 986;',
				10, 2

exec proc_UpdateTxtQuestion 1,'The condition in a WHERE clause can refer to only one value.','Test SELECT EmpId, FullName FROM EmployeeDetail',10,1

exec proc_DeleteTxtQuestion 1


exec addStdForExam 3, 2, 2

------- Student ------

exec AnswerThisQstSP '3', 2, 'MCQ', 2, 3

exec SubmitExamSP 2, 3

exec ShowExamSP 3, 2

---------- Training Manager ------

exec updateInsUserNameSP 'oldUserName','NewName' -- , id

exec updateInsPasswordSP  'userName', 'password'

exec deleteInstructorSP 'userName'

exec updateStdNameSP 'userName','StdName'

exec updateStdEmailSP 'Std UserName','Std Email'

exec updateStdUserNameSP 'oldUserName','NewName' -- , id

exec updateStdPasswordSP 'userName', 'password'

exec updateInsNameSP 'UserName', 'Ins Name'
			
			select * from Student
-- Search On Exam -- ExamId , CrsId
exec SearchOnExamSP 2,3
-- can ( search by User Name , UserName , Email )
exec SearchOnStdSP 1003, 'Omaruser','Omar@gmail.com'
exec SearchOnStdSP 1002, 'Hosnyuser','Hosny@Hotmail.com'
exec SearchOnStdSP 1004, 'Aliuser','Ali@gmail.com'

exec addBranchSP 'Name'

exec updateBranchNameSP 'Branch Id','Name'

exec addTrackSP 'Name' 

exec updateTrackNameSP 'Track Id' , 'Name'

exec addIntakeSP 3

exec updateIntakeNumSP 3 ,33



exec updateCrsDescSP 2,'Advanced C and ASP.NET'

exec updateCrsMinMaxDegreeSP 2,80,150

exec updateCrsInsIdSP 2,2

exec addStdPersonalInfoSP 'Mustafa', 'mustafa@gmail.com','mustafauser','Pass'
exec addStdPersonalInfoSP 'Hosny','Hosny@Hotmail.com','Hosnyuser','Pass'
exec addStdPersonalInfoSP 'Omar','Omar@gmail.com','Omaruser','Pass'
exec addStdPersonalInfoSP 'Ali','Ali@gmail.com','Aliuser','Pass'


exec addBranchDetailsSP	1,2,1,1,2,1

exec addCourseSP 'CourseTitle','Desc which we will take',80,150,1
exec addCourseSP 'SQL','Full Course',50,100,1

exec deleteCourseSP 1

exec updateCrsTitleSP 1,'update title'

exec addInstructorSP 'Ali','AliUser','Pass' ,1