-------------------------------------------------------
-----------------Branch_Track Table--------------------
-------------------------------------------------------

-- CREATE OR ALTER PROCEDURE: Insert into Branch_Track
CREATE OR ALTER PROCEDURE InsertTrackIntoBranch
    @branchID INT,
    @trackID INT,
    @departmentManagerID INT,
    @DepartementManagerJoinDate DATETIME = GETDATE,
    @trackManagerID INT, 
    @TrackManagerJoinDate DATETIME = GETDATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @departmentID INT = NULL;

        -- Validate the track and department
        SELECT @departmentID = departmentID 
        FROM Track 
        WHERE ID = @trackID AND isDeleted = 0;

        IF (@departmentID IS NULL)
        BEGIN
            RAISERROR('The track ID is invalid or it has been deleted.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Check if the track already exists in the branch and is soft-deleted
        IF EXISTS (
            SELECT 1 
            FROM Branch_Department_Track
            WHERE branchID = @branchID AND departmentID = @departmentID AND trackID = @trackID AND IsDeleted = 1
        )
        BEGIN
            UPDATE Branch_Department_Track
            SET IsDeleted = 0
            WHERE branchID = @branchID AND trackID = @trackID AND departmentID = @departmentID;

            -- Reactivate associated students
            UPDATE Student
            SET isDeleted = 0
            WHERE branchID = @branchID AND departmentID = @departmentID AND trackID = @trackID;

            COMMIT TRANSACTION;
            RETURN;
        END;

        -- Insert a new record if it does not exist
        IF EXISTS (
            SELECT 1 
            FROM Branch_Department_Track
            WHERE branchID = @branchID AND trackID = @trackID
        )
        BEGIN
            RAISERROR('The track already exists in this branch.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        DECLARE @creationDate DATETIME = GETDATE();
        INSERT INTO Branch_Department_Track (
            BranchID, TrackID, departmentID, departmentManagerID, trackManagerID, 
            DepartementManagerJoinDate, trackManagerJoinDate, CreationDate
        )
        VALUES (
            @branchID, @trackID, @departmentID, @departmentManagerID, @trackManagerID,
            @DepartementManagerJoinDate, @TrackManagerJoinDate, @creationDate
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO

-- CREATE OR ALTER PROCEDURE: Get all tracks in a specified branch
CREATE OR ALTER PROCEDURE GetTracksPerBranch
    @BranchID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the branch exists and is not soft deleted
        IF NOT EXISTS (SELECT 1
    FROM Branch
    WHERE ID = @BranchID AND IsDeleted = 0)
        BEGIN
        RAISERROR('Branch does not exist or is deleted.', 16, 1);
        RETURN;
    END

        -- Retrieve all tracks in the specified branch
        SELECT t.ID AS TrackID, t.Name AS TrackName, t.CreationDate AS TrackCreationDate,
        d.ID AS DepartmentID, d.Name AS DepartmentName
    FROM Branch_Department_Track bdt
        INNER JOIN Track t ON bdt.TrackID = t.ID AND t.IsDeleted = 0
        INNER JOIN Department d ON t.DepartmentID = d.ID
    WHERE bdt.BranchID = @BranchID AND bdt.IsDeleted = 0;
    END TRY
    BEGIN CATCH
        -- Handle the error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        -- Optionally, log the error or re-throw it
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- CREATE OR ALTER PROCEDURE: Get all branches that teach a specified track
CREATE OR ALTER PROCEDURE GetBranchesPerTrack
    @TrackID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists and is not soft deleted
        IF NOT EXISTS (SELECT 1
    FROM Track
    WHERE ID = @TrackID AND IsDeleted = 0)
        BEGIN
        RAISERROR('Track does not exist or is deleted.', 16, 1);
        RETURN;
    END

        -- Retrieve all branches that teach the specified track
        SELECT b.ID AS BranchID, b.Name AS BranchName, b.Location AS BranchLocation,
        b.Phone AS BranchPhone, b.EstablishmentDate AS BranchEstablishmentDate,
        b.ManagerID AS BranchManagerID
    FROM Branch_Department_Track bdt
        JOIN Branch b ON bdt.BranchID = b.ID AND b.IsDeleted = 0
    WHERE bdt.TrackID = @TrackID AND bdt.IsDeleted = 0;
    END TRY
    BEGIN CATCH
        -- Handle the error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        -- Optionally, log the error or re-throw it
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- CREATE OR ALTER PROCEDURE: Soft delete a Branch_Track record
CREATE OR ALTER PROCEDURE DeleteTrackFromBranch
    @BranchID INT,
    @TrackID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @departmentID INT = NULL;
        SELECT @departmentID = departmentID 
        FROM Track 
        WHERE ID = @trackID AND isDeleted = 0;

        IF (@departmentID IS NULL)
        BEGIN
            RAISERROR('Invalid track ID or it is deleted.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Check if the record exists and is active
        IF NOT EXISTS (
            SELECT 1 
            FROM Branch_Department_Track
            WHERE branchID = @branchID AND trackID = @trackID AND isDeleted = 0
        )
        BEGIN
            RAISERROR('The track does not exist or is already deleted from this branch.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Soft delete the track
        UPDATE Branch_Department_Track
        SET IsDeleted = 1
        WHERE branchID = @branchID AND trackID = @trackID;

        -- Soft delete associated students
        UPDATE Student
        SET isDeleted = 1
        WHERE branchID = @branchID AND departmentID = @departmentID AND trackID = @trackID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO

CREATE OR ALTER PROCEDURE UpdateTrackManager
    @branchID INT,
    @departmentID INT,
    @trackID INT,
    @newTrackManagerID INT,
    @joinDate DATETIME
AS
BEGIN
    -- Check if the new track manager exists and is not soft-deleted
    IF NOT EXISTS (
        SELECT 1 
        FROM Instructor 
        WHERE ID = @newTrackManagerID
          AND isDeleted = 0
    )
    BEGIN
        RAISERROR('Invalid Track Manager ID. The instructor does not exist or is deleted.', 16, 1);
        RETURN;
    END;
    IF NOT EXISTS (
        SELECT 1 
        FROM Branch_Department_Track 
        WHERE branchID = @branchID 
        AND departmentID = @departmentID 
        AND trackID = @trackID 
        AND isDeleted = 0
    )
    BEGIN
        RAISERROR('The specified branch, department, or track does not exist.', 16, 1);
        RETURN;
    END;

    -- Update the track manager and join date
    UPDATE Branch_Department_Track
    SET 
        trackManagerID = @newTrackManagerID,
        TrackManagerJoinDate = @joinDate
    WHERE 
        branchID = @branchID
        AND departmentID = @departmentID
        AND trackID = @trackID
        AND isDeleted = 0;

    -- Check if the update was successful
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('Failed to update the Track Manager. Ensure the branch, department, and track exist and are active.', 16, 1);
        RETURN;
    END;

    PRINT 'Track Manager updated successfully.';
END;

GO

CREATE OR ALTER PROCEDURE UpdateDepartmentManager
    @branchID INT,
    @departmentID INT,
    @newDepartmentManagerID INT,
    @joinDate DATETIME
AS
BEGIN
    -- Check if the new department manager exists and is not soft-deleted
    IF NOT EXISTS (
        SELECT 1 
        FROM Instructor 
        WHERE ID = @newDepartmentManagerID
          AND isDeleted = 0
    )
    BEGIN
        RAISERROR('Invalid Department Manager ID. The instructor does not exist or is deleted.', 16, 1);
        RETURN;
    END;
    IF NOT EXISTS (
        SELECT 1 
        FROM Branch_Department_Track 
        WHERE branchID = @branchID 
        AND departmentID = @departmentID 
        AND isDeleted = 0
    )
    BEGIN
        RAISERROR('The specified branch, department, or track does not exist.', 16, 1);
        RETURN;
    END;
    -- Update the department manager and join date
    UPDATE Branch_Department_Track
    SET 
        departmentManagerID = @newDepartmentManagerID,
        DepartementManagerJoinDate = @joinDate
    WHERE 
        branchID = @branchID
        AND departmentID = @departmentID
        AND isDeleted = 0;

    -- Check if the update was successful
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('Failed to update the Department Manager. Ensure the branch and department exist and are active.', 16, 1);
        RETURN;
    END;

    PRINT 'Department Manager updated successfully.';
END;