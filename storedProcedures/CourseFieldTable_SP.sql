--Course_Field Table 
GO

--Inserting into Course_Field Table
CREATE PROCEDURE InsertCourseField
    @CourseID INT,
    @field NVARCHAR(200)
AS
BEGIN
    BEGIN TRY 
    IF EXISTS(SELECT 1
    FROM Course
    WHERE ID = @CourseID)
BEGIN
        INSERT INTO Course_Field
            (courseID,field)
        VALUES
            (@CourseID, @field)
    END
ELSE
BEGIN
        RAISERROR('CourseID does not exist in the Course table', 16 , 50)
    --16 means user error --5 means error in the course table --0 means field
    END
    END TRY 
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

GO

--Updating Course_Field Table
CREATE PROCEDURE UpdateCourseField
    @CourseID INT,
    @field NVARCHAR(200)
AS
BEGIN
    UPDATE Course_Field
SET field = @field
WHERE courseID = @CourseID
END;


GO
-- Deleting from Course_Field Table 
-- Deleting specific course from specific field
CREATE PROCEDURE DeleteCourseField
    @CourseID INT,
    @field NVARCHAR(200)
AS
BEGIN
    DELETE FROM Course_Field
WHERE courseID = @CourseID AND field = @field
END;
GO

--Deleting the course with all of its field
CREATE PROCEDURE DeleteCourseFromAllFields
    @CourseID INT
AS
BEGIN
    DELETE FROM Course_Field 
WHERE courseID = @CourseID
END;
GO

--Getting all the fields with all the courses
CREATE PROCEDURE GetCourseByField
@field NVARCHAR(200) 
AS
BEGIN
    SELECT C.*
    FROM Course_Field CF INNER JOIN Course C
    ON CF.courseID = C.ID
    WHERE field = @field
END;

GO

-- getting number of courses in specific field 
CREATE PROCEDURE GetNumOfCoursesByField
@field NVARCHAR(200)
AS 
BEGIN 
    SELECT COUNT(*)
    FROM Course_Field
    WHERE field = @field ;
END;