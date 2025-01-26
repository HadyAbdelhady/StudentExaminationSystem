/*************************************Track_Course Table***********************************/
GO
-- insert course in a specific track table 
CREATE OR ALTER PROCEDURE InsertCourseInTrack
    @TrackID INT,
    @CourseID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @TrackID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @TrackID);
            RETURN;
        END;

        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @CourseID);
            RETURN;
        END;

        -- Check if the Track_Course relationship already exists and is not deleted
        IF EXISTS (SELECT 1 FROM Track_Course WHERE TrackID = @TrackID AND CourseID = @CourseID)
        BEGIN
            RAISERROR('The Track_Course relationship already exists for TrackID %d and CourseID %d.', 16, 1, @TrackID, @CourseID);
            RETURN;
        END;

        -- Check if the Track_Course relationship exists but is deleted
        IF EXISTS (SELECT 1 FROM Track_Course WHERE TrackID = @TrackID AND CourseID = @CourseID)
        BEGIN
            -- Reactivate the relationship by setting isDeleted = 0
            DELETE FROM Track_Course
            WHERE TrackID = @TrackID AND CourseID = @CourseID;

            PRINT 'Track_Course relationship for TrackID ' + CAST(@TrackID AS NVARCHAR) + ' and CourseID ' + CAST(@CourseID AS NVARCHAR) + ' was previously deleted and has been reactivated.';
            RETURN;
        END;

        -- Insert the Track_Course relationship
        INSERT INTO Track_Course (TrackID, CourseID)
        VALUES (@TrackID, @CourseID);

        PRINT 'Track_Course relationship inserted successfully for TrackID ' + CAST(@TrackID AS NVARCHAR) + ' and CourseID ' + CAST(@CourseID AS NVARCHAR) + '.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while inserting the Track_Course relationship. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO

-- getting all courses in a specific track
CREATE OR ALTER PROCEDURE GetCoursesInTrack
    @TrackID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @TrackID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @TrackID);
            RETURN;
        END;

        -- Retrieve all courses in the track (active courses only)
        SELECT 
            C.ID AS CourseID,
            C.Name AS CourseName,
            C.creationDate AS CourseCreationDate
        FROM Track_Course TC
        INNER JOIN Course C ON TC.CourseID = C.ID
        WHERE TC.TrackID = @TrackID
          AND C.isDeleted = 0; -- Ensure the course is not deleted

        PRINT 'Courses in Track with ID ' + CAST(@TrackID AS NVARCHAR) + ' retrieved successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while retrieving courses in the track. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO

-- getting all courses with tracks name
CREATE OR ALTER PROCEDURE GetAllCoursesWithTrackNames
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if there are any active tracks and courses
        IF NOT EXISTS (
            SELECT 1
            FROM Track T
            INNER JOIN Track_Course TC ON T.ID = TC.TrackID
            INNER JOIN Course C ON TC.CourseID = C.ID
            WHERE T.isDeleted = 0 AND C.isDeleted = 0
        )
        BEGIN
            RAISERROR('No active tracks or courses found.', 16, 1);
            RETURN;
        END;

        -- Retrieve all active courses with their associated track names
        SELECT 
            C.ID AS CourseID,
            T.ID AS TrackID,
            T.Name AS TrackName,
            C.Name AS CourseName
        FROM Track T
        INNER JOIN Track_Course TC ON T.ID = TC.TrackID
        INNER JOIN Course C ON TC.CourseID = C.ID
        WHERE T.isDeleted = 0 -- Ensure the track is not deleted
          AND C.isDeleted = 0 -- Ensure the course is not deleted

        PRINT 'All active courses with track names retrieved successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while retrieving courses with track names. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO

-- hard Deleting from Track_course table
CREATE OR ALTER PROCEDURE DeleteCourseFromTrack
    @TrackID INT,
    @CourseID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @TrackID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @TrackID);
            RETURN;
        END;

        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @CourseID);
            RETURN;
        END;

        -- Check if the Track_Course relationship exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Track_Course WHERE TrackID = @TrackID AND CourseID = @CourseID )
        BEGIN
            RAISERROR('The Track_Course relationship for TrackID %d and CourseID %d does not exist or is already deleted.', 16, 1, @TrackID, @CourseID);
            RETURN;
        END;

            DELETE FROM Track_Course
            WHERE TrackID = @TrackID AND CourseID = @CourseID

        PRINT 'Course with ID ' + CAST(@CourseID AS NVARCHAR) + ' has been removed from Track with ID ' + CAST(@TrackID AS NVARCHAR) + '.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while deleting the course from the track. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE DeleteAllCoursesInTrack
    @TrackID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @TrackID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @TrackID);
            RETURN;
        END;

        DELETE FROM Track_Course
        WHERE TrackID = @TrackID

        PRINT 'All courses in Track with ID ' + CAST(@TrackID AS NVARCHAR) + ' have been soft deleted.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while deleting courses in the track. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO

--Count all courses for each track
CREATE OR ALTER PROCEDURE GetCountCoursesByTrack
    @TrackID INT
AS
BEGIN
    BEGIN TRY
            -- Check if the track exists and is not deleted
            IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @TrackID AND isDeleted = 0)
            BEGIN
                RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @TrackID);
                RETURN;
            END;
    SELECT COUNT(*) AS CourseCount
    FROM Track_Course
    WHERE TrackID = @TrackID;
    END TRY
    
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while retrieving courses in the track. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END