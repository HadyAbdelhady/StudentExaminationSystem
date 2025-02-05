--Course_Field Table 
GO

--Inserting into Course_Field Table
CREATE OR ALTER PROCEDURE InsertCourseField
    @CourseID INT,
    @field NVARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @CourseID);
            RETURN;
        END;

        -- Check if the field already exists for the course and is not deleted
        IF EXISTS (
            SELECT 1 
            FROM Course_Field 
            WHERE courseID = @CourseID 
              AND field = @field 
              AND isDeleted = 0
        )
        BEGIN
            RAISERROR('Field "%s" already exists for Course with ID %d.', 16, 1, @field, @CourseID);
            RETURN;
        END;

        -- Check if the field exists but is deleted
        IF EXISTS (
            SELECT 1 
            FROM Course_Field 
            WHERE courseID = @CourseID 
              AND field = @field 
              AND isDeleted = 1
        )
        BEGIN
            -- Reactivate the field by setting isDeleted = 0
            UPDATE Course_Field
            SET isDeleted = 0,
                creationDate = GETDATE()  -- Optionally update the creation date
            WHERE courseID = @CourseID 
              AND field = @field;

            PRINT 'Field "' + @field + '" was previously deleted and has been reactivated for Course ID ' + CAST(@CourseID AS NVARCHAR) + '.';
            RETURN;
        END;

        -- Insert new field
        INSERT INTO Course_Field (courseID, field, creationDate)
        VALUES (@CourseID, @field, GETDATE());

        PRINT 'Field "' + @field + '" inserted successfully for Course ID ' + CAST(@CourseID AS NVARCHAR) + '.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while inserting the field "%s" for the course with ID %d. Error Message: %s',
            16,
            1,
            @field,
            @CourseID,
            @ErrorMessage
        );
    END CATCH;
END;
GO

--Updating Course_Field Table
CREATE OR ALTER PROCEDURE UpdateCourseField
    @CourseID INT,
    @OldField NVARCHAR(200),
    @NewField NVARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @CourseID);
            RETURN;
        END;

        -- Check if the old field exists for the course and is not deleted
        IF NOT EXISTS (
            SELECT 1 
            FROM Course_Field 
            WHERE courseID = @CourseID 
              AND field = @OldField 
              AND isDeleted = 0
        )
        BEGIN
            RAISERROR('Field "%s" does not exist or is deleted for Course with ID %d.', 16, 1, @OldField, @CourseID);
            RETURN;
        END;

        -- Check if the new field already exists for the course
        IF EXISTS (
            SELECT 1 
            FROM Course_Field 
            WHERE courseID = @CourseID 
              AND field = @NewField 
              AND isDeleted = 0
        )
        BEGIN
            RAISERROR('Field "%s" already exists for Course with ID %d.', 16, 1, @NewField, @CourseID);
            RETURN;
        END;

        -- Update the specific field
        UPDATE Course_Field
        SET field = @NewField,
            creationDate = GETDATE()  -- Update creation date (consider adding lastModifiedDate)
        WHERE courseID = @CourseID 
          AND field = @OldField
          AND isDeleted = 0;

        PRINT 'Field "' + @OldField + '" updated successfully to "' + @NewField + '" for Course ID ' + CAST(@CourseID AS NVARCHAR) + '.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while updating field from "%s" to "%s" for Course ID %d. Error: %s',
            16,
            1,
            @OldField,
            @NewField,
            @CourseID,
            @ErrorMessage
        );
    END CATCH;
END;
GO

-- Deleting from Course_Field Table 
-- Deleting specific course from specific field
CREATE OR ALTER PROCEDURE DeleteCourseField
    @CourseID INT,
    @field NVARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is already deleted.', 16, 1, @CourseID);
            RETURN;
        END;

        -- Check if the field exists for the course and is not deleted
        IF NOT EXISTS (
            SELECT 1 
            FROM Course_Field 
            WHERE courseID = @CourseID 
              AND field = @field 
              AND isDeleted = 0
        )
        BEGIN
            -- Check if the field is already deleted
            IF EXISTS (
                SELECT 1 
                FROM Course_Field 
                WHERE courseID = @CourseID 
                  AND field = @field 
                  AND isDeleted = 1
            )
            BEGIN
                RAISERROR('Field "%s" for Course with ID %d is already deleted.', 16, 1, @field, @CourseID);
                RETURN;
            END
            ELSE
            BEGIN
                RAISERROR('Field "%s" does not exist for Course with ID %d.', 16, 1, @field, @CourseID);
                RETURN;
            END;
        END;

        -- Soft delete the field by setting isDeleted = 1
        UPDATE Course_Field
        SET isDeleted = 1
        WHERE courseID = @CourseID 
          AND field = @field;

        PRINT 'Field "' + @field + '" for Course ID ' + CAST(@CourseID AS NVARCHAR) + ' has been soft deleted.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while soft deleting the field "%s" for the course with ID %d. Error Message: %s',
            16,
            1,
            @field,
            @CourseID,
            @ErrorMessage
        );
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE DeleteCourseFromAllFields
    @CourseID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is already deleted.', 16, 1, @CourseID);
            RETURN;
        END;

        -- Soft delete all fields for the course by setting isDeleted = 1
        UPDATE Course_Field
        SET isDeleted = 1
        WHERE courseID = @CourseID;

        PRINT 'All fields for Course ID ' + CAST(@CourseID AS NVARCHAR) + ' have been soft deleted.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while soft deleting all fields for the course with ID %d. Error Message: %s',
            16,
            1,
            @CourseID,
            @ErrorMessage
        );
    END CATCH;
END;
GO

--Getting all the fields with all the courses
CREATE OR ALTER PROCEDURE GetCourseByField
    @field NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (
            SELECT 1
            FROM Course_Field CF
            INNER JOIN Course C ON CF.courseID = C.ID
            WHERE CF.field = @field
            AND CF.isDeleted = 0
            AND C.isDeleted = 0
        )
        BEGIN
            RAISERROR('No courses found for field "%s".', 16, 1, @field);
            RETURN;
        END;
        -- Get all courses with the specified field that are not deleted
        SELECT 
            C.ID AS CourseID,
            C.Name AS CourseName,
            CF.field AS FieldName,
            CF.creationDate AS FieldCreationDate
        FROM Course_Field CF
        INNER JOIN Course C ON CF.courseID = C.ID
        WHERE CF.field = @field
          AND CF.isDeleted = 0
          AND C.isDeleted = 0;
              END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while soft deleting all fields for the course with ID %d. Error Message: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;

GO

-- getting number of courses in specific field 
CREATE OR ALTER PROCEDURE GetNumOfCoursesByField
    @field NVARCHAR(200)
AS
BEGIN
    SELECT COUNT(*)
    FROM Course_Field INNER JOIN Course
        ON Course_Field.courseID = Course.ID
    WHERE field = @field AND Course.isDeleted = 0 AND Course_Field.isDeleted = 0;
;
END;