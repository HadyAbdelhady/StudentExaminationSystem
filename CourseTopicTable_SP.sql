--Course_Topic Table 


--RAISERROR (message_string, severity, state)
--severity: Indicates the severity level of the error. It ranges from 0 to 25:
--0–10: Informational messages (no effect on execution).
--11–16: User-defined errors.
--17–25: Software or hardware errors (requires sysadmin role).
--state: Any integer from 0 to 255. It is used to identify the location in the code that raised the error.

--Inserting into Course_Topic Table
CREATE PROCEDURE InsertTopicIntoCourse
    @courseID INT,
    @topic NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
        BEGIN
            RAISERROR('Course with ID %d does not exist in the Course table.', 16, 5, @courseID);  --16 means user error --5 means error in the course table
            RETURN;
        END

        IF EXISTS (
            SELECT 1 
            FROM Course_Topic 
            WHERE courseID = @courseID AND topic = @Topic
        )
        BEGIN
            RAISERROR('Topic "%s" already exists for Course with ID %d.', 16, 51, @Topic, @courseID); --16 means user error --5 means error in the course table --1 means topic
            RETURN;
        END

        INSERT INTO Course_Topic (courseID, topic)
        VALUES (@courseID, @Topic);
    END TRY
   BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
		DECLARE @ErrorState INT = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH	
END;


GO

--Updating Course_Topic Table
CREATE PROCEDURE UpdateCourseTopic
    @courseID INT,
    @newTopic NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
        BEGIN
            RAISERROR('Course with ID %d not found.', 16, 1, @courseID);
            RETURN;
        END

        UPDATE Course_Topic
        SET topic = @newTopic
        WHERE courseID = @courseID;

    END TRY
  BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
		DECLARE @ErrorState INT = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH	
END;

GO


--Deleting From Course_Topic Table specific topic from specific course
CREATE PROCEDURE DeleteSpecificTopicFromCourse
    @courseID INT,
    @Topic NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
        BEGIN
            RAISERROR('Course with ID %d not found.', 16, 1, @courseID);
            RETURN;
        END

        IF NOT EXISTS (
            SELECT 1 
            FROM Course_Topic 
            WHERE courseID = @courseID AND topic = @Topic
        )
        BEGIN
            RAISERROR('Topic "%s" not found for Course with ID %d.', 16, 1, @Topic, @courseID);
            RETURN;
        END

        DELETE FROM Course_Topic
        WHERE courseID = @courseID AND topic = @Topic;
    END TRY
    BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
		DECLARE @ErrorState INT = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH	
END;

GO

--Deleting the course with all of its topics
CREATE PROCEDURE DeleteAllTopicsByCourseID
    @courseID INT
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
        BEGIN
            RAISERROR('Course with ID %d not found.', 16, 1, @courseID);
            RETURN;
        END

        DELETE FROM Course_Topic
        WHERE courseID = @courseID;
    END TRY
 BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
		DECLARE @ErrorState INT = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH	
END;

GO

--Getting all the topics with courses
CREATE PROCEDURE GetAllCourseTopics
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
            ON c.ID = ct.courseID;
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
CREATE PROCEDURE GetCourseTopics 
    @courseID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
    BEGIN
        RAISERROR('Course with ID "%d" is not found.', 16, 1, @courseID);
        RETURN;
    END

    SELECT  CT.topic AS TopicName
    FROM    Course_Topic CT
    WHERE   CT.courseID = @courseID;
END;
