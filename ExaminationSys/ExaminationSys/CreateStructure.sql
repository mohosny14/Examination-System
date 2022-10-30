-- Create DB 
create database ExaminationSys
on
(
		 Name=ExamSystem, 
		 FileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ExaminationSys.mdf',
		 size=10, 
		 MaxSize=50,
		 FileGrowth=10
)
Log On
(
		Name = ExamSystemLog,
		FileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ExaminationSys.ldf',
		Size=5, 
		MaxSize= 40,
		FileGrowth= 10
		
)

go
create table Class
(
	ClassId int primary key Identity(1,1),
	ClassNumber varchar(5),	
)

go
--insert into Class values('C001'),('C002'),('C003') 

create table Instructor
(
	InsId int primary key Identity(1,1),
	InsName nvarchar(50),
	InsUserName nvarchar(50) unique,
	InsPassword nvarchar(50),
	SuperId int default 0,
	FOREIGN KEY (SuperId) REFERENCES Instructor(InsId)	
)


insert into Instructor values('Hossam','HossamUser','HossamPass',null)
insert into Instructor values ('Osama','OsamaUser','OsamaPass',1),
							 ('Omar','OmarUser','OmarPass',1) 
go 
create table Course
(
	CrsId int primary key Identity(1,1),
	CrsTitle nvarchar(50),
	CrsDesc nvarchar(200),
	CrsMinDegree int not null,
	CrsMaxDegree int not null,
	InsId int default 0,
	FOREIGN KEY(InsId) REFERENCES Instructor(InsId)
)

create nonclustered index IX_Course_CrsTitle
on Course(CrsTitle)

insert into Course values('English','Full Coursefor English',50,200,1),
							('Germany','GermanyDescription',60,150,2),
							('Arabic','arabicDesc',50,300,3)
							
drop table CrsInsPerYear

create table CrsInsPerYear
( 
    ID int primary key Identity(1,1),
	ClassId int not null default 0,
	CrsId int not null default 0 ,
	InsId int not null default 0 ,
	[year] int,
	FOREIGN KEY (ClassId) REFERENCES Class(ClassId)  ON UPDATE CASCADE,
    FOREIGN KEY(CrsId) REFERENCES Course(CrsId) ON UPDATE CASCADE,
    FOREIGN KEY(InsId) REFERENCES Instructor(InsId) ON UPDATE CASCADE,
)



create table Student
(
	StdId int primary key Identity(1,1),
	StdName nvarchar(50),
	StdEmail nvarchar(50),
	StdUserName nvarchar(50) unique,
	StdPassword nvarchar(50),
)

create nonclustered index IX_Student_StdEmail
on Student(StdEmail)

create nonclustered index IX_Student_StdUserName
on Student(StdUserName)

insert into Student values ('Hosny','Hosny@Hotmail.com','Hosnyuser','Pass'),
							('Omar','Omar@gmail.com','Omaruser','Pass'),
							('Ali','Ali@gmail.com','Aliuser','Pass')


create table MCQuestion
(
	McqId int primary key Identity(1,1),
	McqContent nvarchar(200),
	McqCorrectChoice char,
	McqFullDegree int,
	Choice1 nvarchar(150),
	Choice2 nvarchar(150),
	Choice3 nvarchar(150),
	CrsId int not null default 0,
	FOREIGN KEY (CrsId) REFERENCES Course(CrsId)
)
go

insert into MCQuestion values('The ____ Statmnt is used to list the attributes desired in the result of a query.',1,3,'1) Where','2) Select
','3) From',1);
insert into MCQuestion values('Which of the following statements contains an error?',3,3,'1) Select * from emp where empId = 10003;
','2) Select empId from emp;
','3) Select empId where empId = 1009 and lastname = ‘test’;
View Answer',2);
insert into MCQuestion values('The shows allows us to select only those rows in the result relation of the clause that satisfy a specified predicate.'
,1,4,'1) Where, from','2) From, select','3) Select, from',2);

go
create table Department
(
	DeptId int primary key Identity(1,1),
	DeptName nvarchar(50),

)
GO
insert into Department values('DotNet Develop'),('System Analysis'),('Emmbeded');

go
create table Track
(
	TrackId int primary key Identity(1,1),
	TrackName nvarchar(50) ,
)
GO
insert into Track values('Mearn'),('IOS'),('SoftwareEngineering');

create table Intake
(
	IntakeId int primary key Identity(1,1),
	IntakeNumber int,
)
GO
insert into Intake values(1),(2),(3);

create table Branch
(
	BranchId int primary key Identity(1,1),
	BranchName nvarchar(50),
)
GO
insert into Branch values('Qena'),('Alex'),('Minia');

create table BranchDetails
(
	Id int primary key Identity(1,1),
	DeptId int not null,
	IntakeId int not null,
	BranchId int not null,
	TrackId int not null,
	CrsId int not null,
	StdId int not null,
	FOREIGN KEY (DeptId)REFERENCES Department(DeptId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (IntakeId)REFERENCES Intake(IntakeId)ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (BranchId)REFERENCES Branch(BranchId)ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (TrackId)REFERENCES Track(TrackId)ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (CrsId)REFERENCES Course(CrsId)ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (StdId)REFERENCES Student(StdId)ON DELETE CASCADE ON UPDATE CASCADE
)
select * from Student
go
insert into BranchDetails values(1,1,1,1,1011,1002),(2,2,2,2,1012,1002),(3,3,3,3,1013,1002);
insert into BranchDetails values(1,1,1,1,1011,1003),(2,2,2,2,1012,1003),(3,3,3,3,1013,1003);
insert into BranchDetails values(1,1,1,1,1011,1004),(2,2,2,2,1012,1004),(3,3,3,3,1013,1004);


create table Exam 
(
  ExamId int primary key Identity(1,1),
  StartTime   datetime not null,
  EndTime   datetime not null,
  IsCorrective bit not null default 0, -- 0 = False = type Exam
)

go
insert into Exam values(getDate(),dateAdd(hour,1,getDate()),1,0);
insert into Exam values(getDate(),dateAdd(hour,1,getDate()),1,0);
insert into Exam values(getDate(),dateAdd(hour,1,getDate()),1,0);

go
create table StudentExam
( 
  ID int primary key Identity(1,1),
  StdId int not null default 0,
  ExamId int not null default 0,
  Result int not null  default -1,
  FOREIGN KEY (StdId) REFERENCES Student(StdId)ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ExamId) REFERENCES Exam(ExamId)ON DELETE CASCADE ON UPDATE CASCADE,
)

create clustered index IX_StudentExam_StdExamId
on StudentExam(ExamId, StdId)

/*
go
insert into StudentExamResult values(1,1,100);
insert into StudentExamResult values(2,3,70);
insert into StudentExamResult values(3,3,90);
*/
go
create table Allowance 
(  
  Calculator bit not null default 0,
  OpenBook bit not null default 0 ,
  UseInternet bit not null default 0,
  ExamId int not null default 0,
  FOREIGN KEY (ExamId) REFERENCES Exam(ExamId) ON DELETE CASCADE ON UPDATE CASCADE,
)

create clustered index IX_Allowance_ExamId
on Allowance(ExamId)

/*
go

insert into Allowance values(1,1,0,1);
insert into Allowance values(1,0,1,2);
insert into Allowance values(0,1,0,3);
*/
go
create table TFQuestion 
(
  TfqId int primary key Identity(1,1),
  TfqContent nvarchar(200),
  TfqCorrectAnswer nvarchar(5),
  TfqFullDegree int,
  CrsId int not null default 0 ,
  FOREIGN KEY (CrsId) REFERENCES course(CrsId)
)

go
insert into TFQuestion values('What are the important categories of software?','False',10,1);
insert into TFQuestion values('What is the main difference between a computer program as a result of a query','False',10,1);
insert into TFQuestion values(' What is software re-engineering?','True',10,1);

go
create table TxtQuestion 
(
  TxtId int primary key Identity(1,1),
  TxtContent nvarchar(200),
  TxtBestAnswer nvarchar(200),
  TxtFullDegree int,
  CrsId int not null default 0,
  FOREIGN KEY (CrsId) REFERENCES course(CrsId)
)

go
insert into TxtQuestion values('What is software re-engineering?’.','f software development which is done to improve the maintainability',10,1);
insert into TxtQuestion values('The software development is a life,' ,'cycle is composed of the following;',10,1);
insert into TxtQuestion values('Requirement analysis oa life cycle is composed of ','the following WHERE Project = ‘P1’ ;',10,1);


--drop table ExamQuestion;
/*
alter table ExamQuestion
drop column StdAnswer, StdQstDegree
*/
create table ExamQuestion 
(
  ID int primary key Identity(1,1),
  ExamId int not null default 0,
  McqId int ,
  TfqId int ,
  TxtId int ,
  QstDegree int not null,
  QstType char(3), -- MCQ , TFQ , TXQ 
  CrsId int not null default 0,
  FOREIGN KEY (ExamId) REFERENCES Exam(ExamId)ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (TfqId) REFERENCES TFQuestion(TfqId)ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (TxtId) REFERENCES TxtQuestion(TxtId)ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (McqId) REFERENCES MCQuestion(McqId)ON DELETE CASCADE ON UPDATE CASCADE,
  foreign key (CrsId)  references Course(CrsId) ON DELETE CASCADE ON UPDATE CASCADE,
)

create clustered index IX_ExamQeustion_ExamId
on ExamQuestion(ExamId)

select * from ExamQuestion

go
insert into ExamQuestion values(1,null,null,'1',10,'MCQ',1); 

drop table StdAnswers

create table StdAnswers
(
	QstId int not null,
	QstType char(3) not null,
	StdAnswer nvarchar(200),
	StdId int not null,
	ExamId int not null,
	StdDegree int,
	[time] datetime default getdate()
	PRIMARY KEY (StdId, QstId,QstType)
)




create nonclustered index IX_StdAnswers_StdQstId
on StdAnswers(StdId, QstID)

select * from StdAnswers

ALTER TABLE StdAnswers
ALTER COLUMN StdAnswer nvarchar(200);

insert into StdAnswers
values (2, 'MCQ', '3', 2, 3, null, default)

insert into StdAnswers
values (6, 'MCQ', '1', 2, 3, null, default)
	   
insert into StdAnswers
values (1, 'MCQ', '2', 2, 3, null, default)

insert into StdAnswers
values (4, 'TFQ', 'False', 2, 3, null, default)
	   
insert into StdAnswers
values (1, 'TFQ', 'False', 2, 3, null, default)
	   
insert into StdAnswers
values (2, 'TFQ', 'True', 2, 3, null, default)

insert into StdAnswers
values (2, 'TXQ', 'SELECT DISTINCT(Project) FROM EmployeeSalary;', 2, 3, null, default)

insert into StdAnswers
values (3, 'TXQ', 'SELECT COUNT(*) FROM EmployeeSalary WHERE Project = ‘P1’ ;', 2, 3, null, default)

insert into StdAnswers
values (1, 'TXQ', 'Mo Hosny', 2, 3, null, default)
	   
select * from StdAnswers

select TxtBestAnswer from TxtQuestion

select * from ExamQuestion where ExamId=3

-----------------------------------------------------------
------------Moving each table for its filegroup------------
-----------------------------------------------------------


Create unique Clustered index [PK__MCQuesti__E7577600620B861A] ON MCQuestion (McqId)  WITH (DROP_EXISTING=ON) ON Question
Create unique Clustered index [PK__TFQuesti__F63546542F0518CA] ON TFQuestion (TfqId)  WITH (DROP_EXISTING=ON) ON Question
Create unique Clustered index [PK__TxtQuest__C837CD68DD05CACA] ON TxtQuestion (TxtId)  WITH (DROP_EXISTING=ON) ON Question

Create unique Clustered index [PK__Exam__297521C7B618064A] ON Exam (ExamId)  WITH (DROP_EXISTING=ON) ON TestDetails

Create unique Clustered index [PK__Branch__A1682FC57C713EBC] ON Branch (BranchId)  WITH (DROP_EXISTING=ON) ON Management
Create unique Clustered index [PK__Intake__7E1E28358B82033B] ON Intake (IntakeId)  WITH (DROP_EXISTING=ON) ON Management
Create unique Clustered index [PK__Departme__014881AEF2EFD809] ON Department (DeptId)  WITH (DROP_EXISTING=ON) ON Management
Create unique Clustered index [PK__Track__7A74F8E0637C0B70] ON Track (TrackId)  WITH (DROP_EXISTING=ON) ON Management

Create unique Clustered index [PK__Student__55DCAE1F657FBE23] ON Student (StdId)  WITH (DROP_EXISTING=ON) ON Person
Create unique nonClustered index [UQ__Student__DCD1C8803EF34AAE] ON Student (StdUserName)  WITH (DROP_EXISTING=ON) ON Person

Create unique Clustered index [PK__Instruct__9D104DEF2637BC59] ON Instructor (InsId)  WITH (DROP_EXISTING=ON) ON Person
Create unique nonClustered index [UQ__Instruct__7010021E5D584006] ON Instructor (InsUserName)  WITH (DROP_EXISTING=ON) ON Person







-- exec sp_help 'Namee'

-- select * from sys.filegroups