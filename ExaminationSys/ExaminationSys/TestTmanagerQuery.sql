exec auth 
---------- Training Manager ------

exec updateInsUserNameSP 'oldUserName','NewName' -- , id

exec updateInsPasswordSP  'userName', 'password'

exec deleteInstructorSP 'userName'

exec updateStdNameSP 'userName','StdName'

exec updateStdEmailSP 'Std UserName','Std Email'

exec updateStdUserNameSP 'oldUserName','NewName' -- , id

exec updateStdPasswordSP 'userName', 'password'

exec updateInsNameSP 'UserName', 'Ins Name'
				
			  -- ExamId , CrsId
exec SearchOnExamSP 2,3

exec addBranchSP 'Name'

exec updateBranchNameSP 'Branch Id','Name'

exec addTrackSP 'Name' 

exec updateTrackNameSP 'Track Id' , 'Name'

exec addIntakeSP 3

exec updateIntakeNumSP 3 ,33

exec SearchOnStdSP 2, 'Std UserName','StdEmail'

exec updateCrsDescSP 2,'Advanced C and ASP.NET'

exec updateCrsMinMaxDegreeSP 2,80,150

exec updateCrsInsIdSP 2,2

exec addStdPersonalInfoSP 'Mustafa', 'mustafa@gmail.com','mustafauser','Pass'
exec addStdPersonalInfoSP 'Hosny','Hosny@Hotmail.com','Hosnyuser','Pass'
exec addStdPersonalInfoSP 'Omar','Omar@gmail.com','Omaruser','Pass'
exec addStdPersonalInfoSP 'Ali','Ali@gmail.com','Aliuser','Pass'

-- deptId, IntakeId,BranchId,TrackId,CrsId, StdId
exec addBranchDetailsSP 16,16,16,16,1014,1002
exec addBranchDetailsSP 17,17,17,17,1014,1003
exec addBranchDetailsSP 18,18,18,18,1014,1004
exec addBranchDetailsSP	1,2,1,1,2,1
exec addBranchDetailsSP 16,16,16,16,1009,1003

exec addCourseSP 'CourseTitle','Desc which we will take',80,150,1
exec addCourseSP 'SQL','Full Course',50,100,1

exec deleteCourseSP 1

exec updateCrsTitleSP 1,'update title'

exec addInstructorSP 'Ali','AliUser','Pass' ,1