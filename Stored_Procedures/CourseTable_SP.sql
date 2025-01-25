--Course Table 

--Inserting into Course Table
GO
CREATE OR ALTER PROCEDURE InsertCourse 
    @CourseName NVARCHAR(100)
WITH ENCRYPTION
AS 
BEGIN
    BEGIN TRY
        -- Check if the course already exists
        IF EXISTS (SELECT 1 FROM Course WHERE Name = @CourseName)
        BEGIN
            -- Check if the course is deleted
            IF EXISTS (SELECT 1 FROM Course WHERE Name = @CourseName AND isDeleted = 1)
            BEGIN
                -- Reactivate the course by setting isDeleted = 0
                UPDATE Course
                SET isDeleted = 0,
                    creationDate = GETDATE()  -- Optionally update the creation date
                WHERE Name = @CourseName;

                PRINT 'Course "' + @CourseName + '" was previously deleted and has been reactivated.';
            END
            ELSE
            BEGIN
                -- Course already exists and is not deleted
                RAISERROR('Course "%s" already exists and is active.', 16, 1, @CourseName);
                RETURN;
            END
        END
        ELSE
        BEGIN
            -- Insert new course
            INSERT INTO Course (Name, creationDate)
            VALUES (@CourseName, GETDATE());

            PRINT 'Course "' + @CourseName + '" created successfully.';
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

--Updating Course Table
GO
CREATE OR ALTER PROCEDURE UpdateCourse 
	@CourseID INT, 
	@CourseName NVARCHAR(100)
AS
BEGIN 
	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID AND isDeleted = 0)
		BEGIN
			RAISERROR('Course "%s" With ID "%d" is not found or deleted.', 16, 5, @CourseName, @CourseID)
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
CREATE OR ALTER PROCEDURE DeleteCourseByID 
	@CourseID INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID AND isDeleted = 0)
			BEGIN
				RAISERROR('Course with ID %d does not exist or already deleted.', 16, 1, @CourseID);
				RETURN;
			END;

		BEGIN TRANSACTION 

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
CREATE OR ALTER PROCEDURE GetCourse
AS
BEGIN
	SELECT * FROM Course where isDeleted = 0
END
