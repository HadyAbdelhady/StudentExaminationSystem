--Report that takes the instructor ID and returns the name of the courses that he teaches and the number of student per course
CREATE PROCEDURE GetInstructorCoursesAndStudentCount
    @InstructorID INT
AS
BEGIN
    BEGIN TRY
	
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID)
        BEGIN
            RAISERROR('Instructor with ID %d does not exist.', 16, 1, @InstructorID);
            RETURN;
        END

        SELECT 
            I.firstName + ' ' + I.lastName AS [Instructor Name], 
            C.Name AS [Course Name], 
            COUNT(CS.studentID) AS [Student Count]
        FROM 
            Instructor I
        INNER JOIN 
            Course_Instructor CI ON I.ID = CI.instructorID
        INNER JOIN 
            Course C ON CI.courseID = C.ID
        LEFT JOIN 
            Course_Student CS ON C.ID = CS.courseID
        WHERE 
            I.ID = @InstructorID
        GROUP BY 
            I.firstName + ' ' + I.lastName, C.Name;

    END TRY
 	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
		DECLARE @ErrorState INT = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END;


