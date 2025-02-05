--Course_Topic Table 


--RAISERROR (message_string, severity, state)
--severity: Indicates the severity level of the error. It ranges from 0 to 25:
--0�10: Informational messages (no effect on execution).
--11�16: User-defined errors.
--17�25: Software or hardware errors (requires sysadmin role).
--state: Any integer from 0 to 255. It is used to identify the location in the code that raised the error.

--Inserting into Course_Topic Table
CREATE OR ALTER PROCEDURE InsertTopicIntoCourse
    @courseID INT,
    @topic NVARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @courseID);
            RETURN;
        END;

        -- Check if the topic already exists for the course and is not deleted
        IF EXISTS (
            SELECT 1 
            FROM Course_Topic 
            WHERE courseID = @courseID 
              AND topic = @topic 
              AND isDeleted = 0
        )
        BEGIN
            RAISERROR('Topic "%s" already exists for Course with ID %d.', 16, 1, @topic, @courseID);
            RETURN;
        END;

        -- Check if the topic exists but is deleted
        IF EXISTS (
            SELECT 1 
            FROM Course_Topic 
            WHERE courseID = @courseID 
              AND topic = @topic 
              AND isDeleted = 1
        )
        BEGIN
            -- Reactivate the topic by setting isDeleted = 0
            UPDATE Course_Topic
            SET isDeleted = 0,
                creationDate = GETDATE()  -- Optionally update the creation date
            WHERE courseID = @courseID 
              AND topic = @topic;

            PRINT 'Topic "' + @topic + '" was previously deleted and has been reactivated for Course ID ' + CAST(@courseID AS NVARCHAR) + '.';
            RETURN;
        END;

        -- Insert new topic
        INSERT INTO Course_Topic (courseID, topic, creationDate)
        VALUES (@courseID, @topic, GETDATE());

        PRINT 'Topic "' + @topic + '" inserted successfully for Course ID ' + CAST(@courseID AS NVARCHAR) + '.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while inserting the topic "%s" into the course with ID %d. Error Message: %s',
            16,
            1,
            @topic,
            @courseID,
            @ErrorMessage
        );
    END CATCH;
END;
GO

--Updating Course_Topic Table
CREATE OR ALTER PROCEDURE UpdateCourseTopic
    @courseID INT,
    @oldTopic NVARCHAR(200),
    @newTopic NVARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @courseID);
            RETURN;
        END;

        -- Check if the old topic exists and is not deleted
        IF NOT EXISTS (
            SELECT 1 
            FROM Course_Topic 
            WHERE courseID = @courseID 
              AND topic = @oldTopic 
              AND isDeleted = 0
        )
        BEGIN
            RAISERROR('Topic "%s" does not exist or is deleted for Course with ID %d.', 16, 1, @oldTopic, @courseID);
            RETURN;
        END;

        -- Check if the new topic already exists for the course
        IF EXISTS (
            SELECT 1 
            FROM Course_Topic 
            WHERE courseID = @courseID 
              AND topic = @newTopic 
              AND isDeleted = 0
        )
        BEGIN
            RAISERROR('Topic "%s" already exists for Course with ID %d.', 16, 1, @newTopic, @courseID);
            RETURN;
        END;

        -- Update the specific topic
        UPDATE Course_Topic
        SET topic = @newTopic
        WHERE courseID = @courseID
          AND topic = @oldTopic
          AND isDeleted = 0;

        PRINT 'Topic "' + @oldTopic + '" updated to "' + @newTopic + '" for Course ID ' + CAST(@courseID AS NVARCHAR) + '.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while updating the topic for Course with ID %d. Error Message: %s', 
            16, 
            1, 
            @courseID, 
            @ErrorMessage
        );
    END CATCH;
END;
GO


--Deleting From Course_Topic Table specific topic from specific course
CREATE OR ALTER PROCEDURE DeleteSpecificTopicFromCourse
    @courseID INT,
    @Topic NVARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @courseID);
            RETURN;
        END;

        -- Check if the topic exists for the course
        IF NOT EXISTS (
            SELECT 1 
            FROM Course_Topic 
            WHERE courseID = @courseID 
              AND topic = @Topic
        )
        BEGIN
            RAISERROR('Topic "%s" not found for Course with ID %d.', 16, 1, @Topic, @courseID);
            RETURN;
        END;

        -- Check if the topic is already deleted
        IF EXISTS (
            SELECT 1 
            FROM Course_Topic 
            WHERE courseID = @courseID 
              AND topic = @Topic 
              AND isDeleted = 1
        )
        BEGIN
            RAISERROR('Topic "%s" is already deleted for Course with ID %d.', 16, 1, @Topic, @courseID);
            RETURN;
        END;

        -- Soft-delete the topic (set isDeleted = 1)
        UPDATE Course_Topic
        SET isDeleted = 1
        WHERE courseID = @courseID 
          AND topic = @Topic;

        PRINT 'Topic "' + @Topic + '" has been marked as deleted for Course ID ' + CAST(@courseID AS NVARCHAR) + '.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while deleting the topic "%s" for the course with ID %d. Error Message: %s',
            16,
            1,
            @Topic,
            @courseID,
            @ErrorMessage
        );
    END CATCH;
END;
GO

--Deleting the course with all of its topics
CREATE OR ALTER PROCEDURE DeleteAllTopicsByCourseID
    @courseID INT
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0 ) 
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @courseID);
            RETURN;
        END

        UPDATE Course_Topic
        SET isDeleted = 1
        WHERE courseID = @courseID;
    END TRY
    BEGIN CATCH

        DECLARE @ErrorMessage NVARCHAR(4000)
        SELECT @ErrorMessage = ERROR_MESSAGE() 
		
		
		RAISERROR(
            'An error occurred while deleting topics for the course with ID %d. Error Message: %s', 
            16, 
            1, 
            @courseID,
            @ErrorMessage
        );
        RETURN;
    END CATCH
END;

GO

--Getting all the topics with courses
CREATE OR ALTER PROCEDURE GetAllCourseTopics
AS
BEGIN
    BEGIN TRY
        SELECT 
            c.Name AS CourseName, 
            ct.topic AS TopicName
        FROM 
            Course c
        INNER JOIN 
            Course_Topic ct
            ON c.ID = ct.courseID
        WHERE c.isDeleted = 0
        AND ct.isDeleted  = 0;
    END TRY
    BEGIN CATCH

        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), 
               @ErrorSeverity = ERROR_SEVERITY(), 
               @ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        RETURN;
    END CATCH
END;



--Report that takes course ID and returns its topics
GO
--Getting all the topics for a specific Course 
CREATE OR ALTER PROCEDURE GetCourseTopics 
    @courseID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @courseID);
            RETURN;
        END;

        -- Retrieve topics for the course
        SELECT CT.topic AS TopicName
        FROM Course_Topic CT
        WHERE CT.courseID = @courseID
        AND CT.isDeleted = 0;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
