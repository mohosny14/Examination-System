go
create proc auth
as
begin
	SELECT name, type
	FROM dbo.sysobjects
	WHERE (type = 'P') and name not like 'sp_%'
end

exec auth

--Management for TManager
GRANT EXECUTE ON addBranchSP TO Tmanager;
GRANT EXECUTE ON updateBranchNameSP TO Tmanager;
GRANT EXECUTE ON addTrackSP TO Tmanager;
GRANT EXECUTE ON updateTrackNameSP TO Tmanager;
GRANT EXECUTE ON addIntakeSP TO Tmanager;
GRANT EXECUTE ON updateIntakeNumSP TO Tmanager;
--Course for TManager
GRANT EXECUTE ON addCourseSP TO Tmanager;
GRANT EXECUTE ON updateCrsTitleSP TO Tmanager;
GRANT EXECUTE ON updateCrsDescSP TO Tmanager;
GRANT EXECUTE ON updateCrsMinMaxDegreeSP TO Tmanager;
GRANT EXECUTE ON updateCrsInsIdSP TO Tmanager;
GRANT EXECUTE ON deleteCourseSP TO Tmanager;
--Instructor for TManager
GRANT EXECUTE ON addInstructorSP TO Tmanager;
GRANT EXECUTE ON updateInsNameSP TO Tmanager;
GRANT EXECUTE ON updateInsUserNameSP TO Tmanager;
GRANT EXECUTE ON updateInsPasswordSP TO Tmanager;
GRANT EXECUTE ON deleteInstructorSP TO Tmanager;
--Student for TManager
GRANT EXECUTE ON addStdPersonalInfoSP TO Tmanager;
GRANT EXECUTE ON addBranchDetailsSP TO Tmanager;
GRANT EXECUTE ON updateStdNameSP TO Tmanager;
GRANT EXECUTE ON updateStdEmailSP TO Tmanager;
GRANT EXECUTE ON updateStdUserNameSP TO Tmanager;
GRANT EXECUTE ON updateStdPasswordSP TO Tmanager;
--Search for TManager
GRANT EXECUTE ON SearchOnStdSP TO Tmanager;
GRANT EXECUTE ON SearchOnExamSP TO Tmanager;

--Creating Exam for Instructor
GRANT EXECUTE ON addExamSP TO instructor;
--building Exam for Instructor
GRANT EXECUTE ON addQstRandomlySP TO instructor;
GRANT EXECUTE ON addQstManuallySP TO instructor;
--Add Student to Exam for Instructor
GRANT EXECUTE ON addStdForExam TO instructor;
--Update Student Txt Question Degree for Instructor
GRANT EXECUTE ON updateQstDegreeSP TO instructor;
--Operations on 3 Questions for Instructor
GRANT EXECUTE ON proc_addMCQ TO instructor;
GRANT EXECUTE ON proc_UpdateMCQ TO instructor;
GRANT EXECUTE ON proc_DeleteMCQ TO instructor;
GRANT EXECUTE ON proc_addTFQ TO instructor;
GRANT EXECUTE ON proc_UpdateTFQ TO instructor;
GRANT EXECUTE ON proc_DeleteTFQ TO instructor;
GRANT EXECUTE ON proc_addTxtQuestion TO instructor;
GRANT EXECUTE ON proc_UpdateTxtQuestion TO instructor;
GRANT EXECUTE ON proc_DeleteTxtQuestion TO instructor;
GRANT EXECUTE ON showTxtAnswerSP TO instructor;
GRANT EXECUTE ON getStdsId TO instructor;




--Display Exam for Student
GRANT EXECUTE ON ShowExamSP TO student;
--Answer Question for Student
GRANT EXECUTE ON AnswerThisQstSP TO student;
--Submt the whole Exam for Student
GRANT EXECUTE ON SubmitExamSP TO student;


--to display its Stored Procedure For ALL
GRANT EXECUTE ON auth TO Tmanager;
GRANT EXECUTE ON auth TO instructor;
GRANT EXECUTE ON auth TO student;
