/***************************Table Track***************************************/
-- Create
CREATE PROCEDURE InsertTrack
    @Name NVARCHAR(100),
    @DepartmentID INT,
    @NewTrackID INT OUTPUT -- Add an OUTPUT parameter to return the new track ID
AS
BEGIN
    BEGIN TRY
        -- Insert the new track
        INSERT INTO Track (Name, DepartmentID)
        VALUES (@Name, @DepartmentID);

        -- Get the ID of the newly inserted track
        SET @NewTrackID = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-- Read
CREATE PROCEDURE GetTrack
    @ID INT
AS
BEGIN
    SELECT *
    FROM Track
    WHERE ID = @ID AND isDeleted = 0;
END;
GO

-- Update
CREATE PROCEDURE UpdateTrack
    @ID INT,
    @Name NVARCHAR(100),
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @ID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @ID);
            RETURN;
        END;

        -- Update the track information
        UPDATE Track
        SET Name = @Name, DepartmentID = @DepartmentID
        WHERE ID = @ID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
-- Delete
CREATE PROCEDURE DeleteTrack
    @ID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not already deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @ID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with ID %d does not exist or is already deleted.', 16, 1, @ID);
            RETURN;
        END;

        -- Mark the track as deleted
        UPDATE Track
        SET isDeleted = 1
        WHERE ID = @ID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


--Select all tracks under a specific department
CREATE PROCEDURE GetTracksByDepartment
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the department exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DepartmentID AND isDeleted = 0)
        BEGIN
            RAISERROR('Department with ID %d does not exist or is deleted.', 16, 1, @DepartmentID);
            RETURN;
        END;

        -- Retrieve all tracks under the specified department
        SELECT *
        FROM Track
        WHERE DepartmentID = @DepartmentID AND isDeleted = 0;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO



