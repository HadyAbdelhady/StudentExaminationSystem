--Course Table 

--Inserting into Course Table
GO
CREATE PROCEDURE InsertCourse 
	@CourseName NVARCHAR(100)
AS 
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM Course WHERE Name = @CourseName)
		BEGIN
			RAISERROR('Course "%s" already exists', 16, 5, @CourseName)  --5 means Course table
			RETURN
		END

	INSERT INTO Course(Name)
		VALUES (@CourseName)

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
		DECLARE @ErrorState INT = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END

--Updating Course Table
GO
CREATE PROCEDURE UpdateCourse 
	@CourseID INT, 
	@CourseName NVARCHAR(100)
AS
BEGIN 
	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID)
		BEGIN
			RAISERROR('Course "%s" With ID "%d" is not found.', 16, 5, @CourseName, @CourseID)
			RETURN
		END

		UPDATE Course 
		SET Name = @CourseName 
		WHERE ID = @CourseID

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
		DECLARE @ErrorState INT = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH	
END

--Deleting From Course
-- USING ID
GO
CREATE PROCEDURE DeleteCourseByID 
	@CourseID INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT 1 FROM Course_Field WHERE CourseID = @CourseID)
		BEGIN
			RAISERROR('Course with ID %d does not exist in Course_Field table', 16, 50, @CourseID);
            RETURN;
		END

		IF NOT EXISTS (SELECT 1 FROM Course_Topic WHERE CourseID = @CourseID)
		BEGIN
			RAISERROR('Course with ID %d does not exist in Course_Topic table', 16, 51, @CourseID);
            RETURN;
		END

		BEGIN TRANSACTION 

		-- DELETE FROM Course_Field WHERE courseID = @CourseID
		-- DELETE FROM Course_Topic WHERE courseID = @CourseID

		-- DELETE FROM Course WHERE ID = @CourseID
		UPDATE Course 
		SET isDeleted = 1
		WHERE ID = @CourseID;

		COMMIT TRANSACTION 
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
	
END
GO
--USING NAME   ---!!MAYBE WE CAN DO WITHOUT IT AS NAMES ARE NOT UNIQUE 
--MALHASH LAZMA
--CREATE PROCEDURE deleteFromCourseByName @name NVARCHAR(100)
--AS
--BEGIN
	--DELETE FROM Course 
		--WHERE Name = @name
--END

--Getting All Courses
CREATE PROCEDURE GetCourse
AS
BEGIN
	SELECT * FROM Course
END
