/***************************Table Track***************************************/
-- Create
CREATE OR ALTER PROCEDURE InsertTrack
    @Name NVARCHAR(100),
    @DepartmentID INT,
    @NewTrackID INT OUTPUT -- Output parameter to return the new or reactivated track ID
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the department exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DepartmentID AND isDeleted = 0)
        BEGIN
            RAISERROR('Department with ID %d does not exist or is deleted.', 16, 1, @DepartmentID);
            RETURN;
        END;

        -- Check if the track name already exists and is not deleted
        IF EXISTS (SELECT 1 FROM Track WHERE Name = @Name AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with name "%s" already exists and is active.', 16, 1, @Name);
            RETURN;
        END;

        -- Check if the track name exists but is deleted
        IF EXISTS (SELECT 1 FROM Track WHERE Name = @Name AND isDeleted = 1)
        BEGIN
            -- Reactivate the track
            UPDATE Track
            SET isDeleted = 0,
                DepartmentID = @DepartmentID, -- Update department if needed
                creationDate = GETDATE() -- Optionally update creation date
            WHERE Name = @Name;

            -- Get the ID of the reactivated track
            SELECT @NewTrackID = ID
            FROM Track
            WHERE Name = @Name;

            PRINT 'Track "' + @Name + '" was previously deleted and has been reactivated.';
            RETURN;
        END;

        -- Insert the new track
        INSERT INTO Track (Name, DepartmentID)
        VALUES (@Name, @DepartmentID);

        -- Get the ID of the newly inserted track
        SET @NewTrackID = SCOPE_IDENTITY();

        PRINT 'Track "' + @Name + '" inserted successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while inserting/updating the track. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO


-- Read
CREATE OR ALTER PROCEDURE GetTrack
    @ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @ID AND isDeleted = 0)
        BEGIN
            -- Check if the track exists but is deleted
            IF EXISTS (SELECT 1 FROM Track WHERE ID = @ID AND isDeleted = 1)
            BEGIN
                RAISERROR('Track with ID %d is deleted.', 16, 1, @ID);
                RETURN;
            END
            ELSE
            BEGIN
                RAISERROR('Track with ID %d does not exist.', 16, 1, @ID);
                RETURN;
            END;
        END;

        -- Retrieve the track details
        SELECT *
        FROM Track
        WHERE ID = @ID AND isDeleted = 0;

        PRINT 'Track with ID ' + CAST(@ID AS NVARCHAR) + ' retrieved successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while retrieving the track. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO

-- Update
CREATE OR ALTER PROCEDURE UpdateTrack
    @ID INT,
    @Name NVARCHAR(100),
    @DepartmentID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @ID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @ID);
            RETURN;
        END;

        -- Check if the department exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DepartmentID AND isDeleted = 0)
        BEGIN
            RAISERROR('Department with ID %d does not exist or is deleted.', 16, 1, @DepartmentID);
            RETURN;
        END;

        -- Check if the new track name already exists for another active track
        IF EXISTS (SELECT 1 FROM Track WHERE Name = @Name AND ID <> @ID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with name "%s" already exists and is active.', 16, 1, @Name);
            RETURN;
        END;

        -- Update the track information
        UPDATE Track
        SET Name = @Name, DepartmentID = @DepartmentID
        WHERE ID = @ID;

        PRINT 'Track with ID ' + CAST(@ID AS NVARCHAR) + ' updated successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while updating the track. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO

-- Soft Delete Track and checking its active dependencies
CREATE OR ALTER PROCEDURE DeleteTrack
    @ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if the track exists and is not already deleted
        IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @ID AND isDeleted = 0)
        BEGIN
            RAISERROR('Track with ID %d does not exist or is already deleted.', 16, 1, @ID);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Check for active dependencies in Branch_Department_Track
        IF EXISTS (SELECT 1 FROM Branch_Department_Track WHERE trackID = @ID AND isDeleted = 0)
        BEGIN
            RAISERROR('The specified track has active dependencies in Branch_Department_Track. Delete them first.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Soft delete the track
        UPDATE Track
        SET isDeleted = 1
        WHERE ID = @ID;

        -- Ensure the update affected rows
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('The track deletion failed; no rows were updated.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        COMMIT TRANSACTION;

        PRINT 'Track with ID ' + CAST(@ID AS NVARCHAR) + ' has been soft deleted successfully.';
    END TRY
    BEGIN CATCH
        -- Rollback in case of any error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Rethrow the error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO

--Select all tracks under a specific department
CREATE OR ALTER PROCEDURE GetTracksByDepartment
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



