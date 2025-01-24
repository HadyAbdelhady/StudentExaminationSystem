-------------------------------------------------------
-----------------Branch Table--------------------------
-------------------------------------------------------

-- CREATE OR ALTER PROCEDURE: Insert a new branch
CREATE OR ALTER PROCEDURE InsertBranch
    @Name NVARCHAR(200),
    @Location NVARCHAR(500),
    @Phone NVARCHAR(20),
    @EstablishmentDate DATETIME,
    @ManagerID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the name already exists and is marked as deleted
        IF EXISTS (SELECT 1 FROM Branch WHERE Name = @Name AND IsDeleted = 1)
        BEGIN
            UPDATE Branch
            SET Location = @Location,
                Phone = @Phone,
                EstablishmentDate = @EstablishmentDate,
                ManagerID = @ManagerID,
                IsDeleted = 0
            WHERE Name = @Name;

            SELECT ID AS ID
            FROM Branch
            WHERE Name = @Name;
        END
        ELSE
        BEGIN
            -- Insert a new record if the name does not exist or is not deleted
            INSERT INTO Branch (Name, Location, Phone, EstablishmentDate, ManagerID)
            VALUES (@Name, @Location, @Phone, @EstablishmentDate, @ManagerID);

            SELECT SCOPE_IDENTITY() AS ID;
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO


-- READ PROCEDURE: Get all branches
CREATE OR ALTER PROCEDURE GetAllBranches
AS
BEGIN
    SELECT ID, Name, Location, Phone, EstablishmentDate, ManagerID
    FROM Branch
    WHERE IsDeleted = 0;
END;
GO

CREATE OR ALTER PROCEDURE GetAllDeletedBranches
AS
BEGIN
    SELECT ID, Name, Location, Phone, EstablishmentDate, ManagerID
    FROM Branch
    WHERE IsDeleted = 1;
END;
GO



-- READ PROCEDURE: Get branch by ID
CREATE OR ALTER PROCEDURE GetBranchByID
    @BranchID INT
AS
BEGIN
    SELECT ID, Name, Location, Phone, EstablishmentDate, ManagerID
    FROM Branch
    WHERE ID = @BranchID AND IsDeleted = 0;
END;
GO

-- UPDATE PROCEDURE: Update an existing branch
CREATE OR ALTER PROCEDURE UpdateBranch
    @BranchID INT,
    @Name NVARCHAR(200),
    @Location NVARCHAR(500),
    @Phone NVARCHAR(20),
    @EstablishmentDate DATETIME,
    @ManagerID INT
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Branch WHERE ID = @BranchID AND isDeleted = 0)
            RAISERROR('The branch does not exist', 16, 1);
        UPDATE Branch
        SET Name = @Name,
            Location = @Location,
            Phone = @Phone,
            EstablishmentDate = @EstablishmentDate,
            ManagerID = @ManagerID
        WHERE ID = @BranchID AND IsDeleted = 0;
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

-- DELETE PROCEDURE: Soft delete a branch
CREATE OR ALTER PROCEDURE DeleteBranch
    @BranchID INT
AS
BEGIN
    BEGIN TRY
        UPDATE Branch
        SET IsDeleted = 1
        WHERE ID = @BranchID;

        DELETE FROM Branch_Track
        WHERE BranchId = @BranchID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO