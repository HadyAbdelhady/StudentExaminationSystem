/***************************Table Track***************************************/
GO
-- Create
CREATE PROCEDURE InsertTrack
    @Name NVARCHAR(100),
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY 
        INSERT INTO Track
            (Name, DepartmentID)
        VALUES
            (@Name, @DepartmentID)
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
CREATE PROCEDURE GetTrack
    @ID INT
AS
BEGIN
    SELECT *
    FROM Track
    WHERE ID = @ID
END

GO
-- Update
CREATE PROCEDURE UpdateTrack
    @ID INT,
    @Name NVARCHAR(100),
    @DepartmentID INT
AS
BEGIN
    UPDATE Track
    SET Name = @Name, DepartmentID = @DepartmentID
    WHERE ID = @ID
END

GO
-- Delete
CREATE PROCEDURE DeleteTrack
    @ID INT
AS
BEGIN
    DELETE FROM Track
    WHERE ID = @ID
END

GO
--Select all tracks under a specific department
CREATE PROCEDURE GetTracksByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT *
    FROM Track
    WHERE DepartmentID = @DepartmentID;
END



