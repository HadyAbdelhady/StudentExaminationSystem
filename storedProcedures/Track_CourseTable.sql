/*************************************Track_Course Table***********************************/
GO
-- Create
CREATE PROCEDURE InsertTrack_Course
    @TrackID INT,
    @CourseID INT
AS
BEGIN
    BEGIN TRY
    INSERT INTO Track_Course
        (TrackID, CourseID)
    VALUES
        (@TrackID, @CourseID)
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

GO
-- Read
CREATE PROCEDURE GetTrack_Course
    @TrackID INT,
    @CourseID INT
AS
BEGIN
    SELECT *
    FROM Track_Course
    WHERE TrackID = @TrackID AND CourseID = @CourseID
END

GO
-- Update
CREATE PROCEDURE UpdateTrack_Course
    @OldTrackID INT,
    @OldCourseID INT,
    @NewTrackID INT,
    @NewCourseID INT
AS
BEGIN
    BEGIN TRY 
        UPDATE Track_Course
        SET TrackID = @NewTrackID, CourseID = @NewCourseID
        WHERE TrackID = @OldTrackID AND CourseID = @OldCourseID
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

GO
-- Delete
CREATE PROCEDURE DeleteTrack_Course
    @TrackID INT,
    @CourseID INT
AS
BEGIN
    DELETE FROM Track_Course
    WHERE TrackID = @TrackID AND CourseID = @CourseID
END

GO
--Select all courses info by TrackID
CREATE PROCEDURE GetCoursesByTrack
    @TrackID INT
AS
BEGIN
    SELECT C.*
    FROM Course C
        INNER JOIN Track_Course TC ON C.ID = TC.CourseID
    WHERE TC.TrackID = @TrackID;
END

GO
--Count all courses for each track
CREATE PROCEDURE GetCountCoursesByTrack
    @TrackID INT
AS
BEGIN
    SELECT COUNT(*) AS CourseCount
    FROM Track_Course
    WHERE TrackID = @TrackID;
END