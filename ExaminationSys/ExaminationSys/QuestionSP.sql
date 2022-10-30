
-- SP to Add MCQuestion
go
create or alter proc proc_addMCQ 
	@qContent nvarchar(200), @qCorrectChoice char,
	@qFullDegree int, @Choice1 nvarchar(150),
	@Choice2 nvarchar(150), @Choice3 nvarchar(150),
	@CrsId int
as
begin

	insert into MCQuestion(McqContent, McqCorrectChoice , McqFullDegree ,Choice1,Choice2,Choice3,CrsId)
	values(@qContent,@qCorrectChoice,@qFullDegree, @Choice1, @Choice2, @Choice3, @CrsId)

end

/* test
exec proc_addMCQ @qContent = 'The ____ clause is used to list the attributes desired in the result of a query.',
				@qCorrectChoice = 2,
				@qFullDegree = 3,
				@Choice1 = '1) Where',
				@Choice2 = '2) Select',
				@Choice3 = '3) From',
				@CrsId = 2
				*/

go
-- SP to Update MCQuestion
create or alter proc proc_UpdateMCQ 
	@QId int,@qContent nvarchar(200), @qCorrectChoice char,
	@qFullDegree int, @Choice1 nvarchar(150),
	@Choice2 nvarchar(150), @Choice3 nvarchar(150),
	@CrsId int
as
begin

	Update  MCQuestion set 
	 McqContent = @qContent,
	 McqCorrectChoice = @qCorrectChoice,
	 McqFullDegree = @qFullDegree,
	 Choice1 = @Choice1,
	 Choice2 = @Choice2,
	 Choice3 = @Choice3,
	 CrsId = @CrsId
	 where McqId = @QId 

end

----------------------
go
-- SP to Delete MCQuestion
create or alter proc proc_DeleteMCQ @QId int
as
begin
	delete from MCQuestion where McqId = @QId

end

/* test
select * from MCQuestion
exec proc_DeleteMCQ @QId = 11
*/
------------------- T/F Qusetion -------
-- SP to Add TFQuestion
go
create or alter proc proc_addTFQ 
	@tfqContent nvarchar(200), @tfqCorrectAnswer nvarchar(5),
	@tfqFullDegree int,@CrsId int
as
begin

	insert into TFQuestion(TfqContent, TfqCorrectAnswer , TfqFullDegree,CrsId)
	values(@tfqContent,@tfqCorrectAnswer,@tfqFullDegree, @CrsId)

end

-- test 
--select * from TFQuestion

exec proc_addTFQ @tfqContent = 'The condition in a WHERE clause can refer to only one value.',
				@tfqCorrectAnswer = 'False',
				@tfqFullDegree = 10,
				@CrsId = 2
				

-- SP to Update TfQuestion
go
create or alter proc proc_UpdateTFQ 
	@QId int,@tfqContent nvarchar(200), @tfqCorrectAnswer nvarchar(5),
	@tfqFullDegree int,@CrsId int
as
begin

	Update  TFQuestion set 
	 TfqContent = @tfqContent,
	 TfqCorrectAnswer = @tfqCorrectAnswer,
	 TfqFullDegree = @tfqFullDegree,
	 CrsId = @CrsId
	 where TfqId = @QId 

end


-- SP to Delete TFQuestion
go
create or alter proc proc_DeleteTFQ @QId int
as
begin
	delete from TFQuestion where TfqId = @QId

end

--------------------------Text Question ------
-- SP to Add TxtQuestion
go
create or alter proc proc_addTxtQuestion 
	@txtContent nvarchar(200), @txtBestAnswer nvarchar(200),
	@txtFullDegree int,@CrsId int
as
begin

	insert into TxtQuestion(TxtContent, TxtBestAnswer , TxtFullDegree,CrsId)
	values(@txtContent,@txtBestAnswer,@txtFullDegree,@CrsId)

end

-- test
/*
exec proc_addTxtQuestion 
				@txtContent ='Write an SQL query to fetch the EmpId and FullName of all the employees working under Manager with Id – ‘986’.',
				@txtBestAnswer = 'SELECT EmpId, FullName FROM EmployeeDetails WHERE ManagerId = 986;',
				@txtFullDegree = 10,
				@CrsId = 2

				select * from TxtQuestion
				*/


-- SP to Update txtQuestion
go
create or alter proc proc_UpdateTxtQuestion 
	@QId int,@txtContent nvarchar(200), @txtBestAnswer nvarchar(200),
	@txtFullDegree int,@CrsId int
as
begin

	Update  TxtQuestion set 
	 TxtContent = @txtContent,
	 TxtBestAnswer = @txtBestAnswer,
	 TxtFullDegree = @txtFullDegree,
	 CrsId = @CrsId
	 where TxtId = @QId

end

select * from TxtQuestion

exec proc_UpdateTxtQuestion
			@QId = 2,
				@txtContent ='Write an SQL query to fetch the EmpId and FullName of all the employees working under Manager with Id – ‘986’.',
				@txtBestAnswer = 'SELECT Ettmp_Id, FullName FROM EmployeeDetails WHERE ManagerId = 986;',
				@txtFullDegree = 15,
				@CrsId = 2
				


-- SP to Delete TxtQuestion
go
create or alter proc proc_DeleteTxtQuestion @QId int
as
begin
	delete from TxtQuestion where TxtId = @QId

end