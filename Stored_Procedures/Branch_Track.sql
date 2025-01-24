-------------------------------------------------------
-----------------Branch_Track Table--------------------
-------------------------------------------------------

-- CREATE OR ALTER PROCEDURE: Insert into Branch_Track
CREATE OR ALTER PROCEDURE InsertTrackIntoBranch
    @BranchID INT,
    @TrackID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the Branch_Track record exists and is marked as deleted
        IF EXISTS (SELECT 1
    FROM Branch_Track
    WHERE BranchID = @BranchID AND TrackID = @TrackID AND IsDeleted = 1)
        BEGIN
        UPDATE Branch_Track
            SET IsDeleted = 0, CreationDate = GETDATE()
            WHERE BranchID = @BranchID AND TrackID = @TrackID;
    END
        ELSE
        BEGIN
        -- Insert a new record if it does not exist or is not deleted
        IF EXISTS (SELECT 1
        FROM Branch_Track
        WHERE BranchID = @BranchID AND TrackID = @TrackID)
        RAISERROR('There is no such track in this branch', 16, 1);
        RETURN;

        INSERT INTO Branch_Track
            (BranchID, TrackID, CreationDate)
        VALUES
            (@BranchID, @TrackID, GETDATE());
    END
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
    END

        -- Retrieve all tracks in the specified branch
        SELECT t.ID AS TrackID, t.Name AS TrackName, t.CreationDate AS TrackCreationDate,
        d.ID AS DepartmentID, d.Name AS DepartmentName
    FROM Branch_Track bt
        JOIN Track t ON bt.TrackID = t.ID AND t.IsDeleted = 0
        JOIN Department d ON t.DepartmentID = d.ID
    WHERE bt.BranchID = @BranchID AND bt.IsDeleted = 0;
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
    END

        -- Retrieve all branches that teach the specified track
        SELECT b.ID AS BranchID, b.Name AS BranchName, b.Location AS BranchLocation,
        b.Phone AS BranchPhone, b.EstablishmentDate AS BranchEstablishmentDate,
        b.ManagerID AS BranchManagerID
    FROM Branch_Track bt
        JOIN Branch b ON bt.BranchID = b.ID AND b.IsDeleted = 0
    WHERE bt.TrackID = @TrackID AND bt.IsDeleted = 0;
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


-- CREATE OR ALTER PROCEDURE: Update CreationDate
CREATE OR ALTER PROCEDURE UpdateCreationDate
    @BranchID INT,
    @TrackID INT,
    @creationDate DATETIME
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Branch_Track WHERE BranchID = @BranchID AND TrackID = @TrackID AND IsDeleted = 0)
            RAISERROR('There is no such track in a branch', 16, 1)
        UPDATE Branch_Track
        SET CreationDate = @creationDate
        WHERE BranchID = @BranchID AND TrackID = @TrackID AND IsDeleted = 0;
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
        IF EXISTS (SELECT 1
    FROM Branch_Track
    WHERE BranchID = @BranchID AND TrackID = @TrackID AND IsDeleted = 1)
            RAISERROR('The track is already deleted from that branch', 16, 1)
            RETURN;

        IF NOT EXISTS (SELECT 1
    FROM Branch_Track
    WHERE BranchID = @BranchID AND TrackID = @TrackID)
            RAISERROR('There is no such track in this branch', 16, 1)
            RETURN;
        
        UPDATE Branch_Track
        SET IsDeleted = 1
        WHERE BranchID = @BranchID AND TrackID = @TrackID;
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

-- CREATE OR ALTER PROCEDURE GetDeletedTracksFromBranches 