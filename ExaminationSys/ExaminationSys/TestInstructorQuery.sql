exec auth 
---------- Instructor----


-- create Exam
exec addExamSP '2022-10-11', '2022-10-12', 0, 1, 1, 0

-- examId = 8

-- examId -CrsId -
exec addQstRandomlySP 8, 2, 3, 3, 3, 5, 10, 15

-- examId - QstId - QstDegree - QstType - CrsId
exec addQstManuallySP 8, 2, 5, 'TXQ', 2

-- CrsId 
exec getStdsId 2

-- ExamId - StdId - InsId
exec addStdForExam 12, 1002, 2

-- ExamId - StdId - InsId
exec addStdForExam 8, 1002, 2

-- StdId -- ExamId
exec showTxtAnswerSP 1003,12

-- after review update
--ExamId - QstId - StdId - Degree
exec updateQstDegreeSP 12, 1, 1003, 10
exec updateQstDegreeSP 12, 3, 1003, 12

--- Questions Pool Operations

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

--------- another Exam ---
-- create Exam
exec addExamSP '2022-10-11', '2022-10-12', 0, 1, 1, 0

-- examId = 8

-- examId -CrsId -
exec addQstRandomlySP 12, 2, 3, 3, 3, 5, 10, 15

-- examId - QstId - QstDegree - QstType - CrsId
exec addQstManuallySP 8, 2, 5, 'TXQ', 2

-- ExamId - StdId - InsId
exec addStdForExam 12, 1003, 2


-- after review update
exec updateQstDegreeSP 3, 1, 2, 0

