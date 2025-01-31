-----------------------------------------------------
------------------ Department -----------------------
-----------------------------------------------------

-- READ PROCEDURE: Get Department by ID
CREATE OR ALTER PROCEDURE GetDepartmentByID
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY 
    IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DepartmentID)
        BEGIN
            RAISERROR('The department does not exist.', 16, 1);
            RETURN;
        END 
    SELECT ID, Name, CreationDate
    FROM Department
    WHERE ID = @DepartmentID AND IsDeleted = 0;
    END TRY
    BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
		DECLARE @ErrorState INT = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END;
GO

-- getting all the departments data
CREATE OR ALTER PROCEDURE GetDepartmentData
AS
BEGIN
    SELECT *
    FROM Department
    WHERE isDeleted = 0;
END;
GO

--getting all the departements in a specific branch 
CREATE OR ALTER PROCEDURE GetDepartmentsBranchData
    @BranchID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if branch exists and is active
        IF NOT EXISTS (
            SELECT 1 
            FROM Branch 
            WHERE ID = @BranchID 
            AND isDeleted = 0
        )
        BEGIN
            RAISERROR ('Branch ID %d does not exist or is deleted.', 16, 1, @BranchID);
            RETURN;
        END;

        -- Get distinct departments for the specific branch
        SELECT DISTINCT
            D.ID,
            D.Name,
            D.creationDate,
            BDT.departmentManagerID
        FROM Branch_Department_Track BDT
        INNER JOIN Department D 
            ON BDT.departmentID = D.ID
            AND D.isDeleted = 0
        WHERE BDT.branchID = @BranchID
          AND BDT.isDeleted = 0;

        PRINT 'Distinct department data retrieved for branch ID ' + CAST(@BranchID AS NVARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error retrieving department data: ' + ERROR_MESSAGE();
    END CATCH;
END;
GO

-- getting the manager data of a specific department
CREATE OR ALTER PROCEDURE GetDepartmentManager
    @BranchID INT,
    @DepartmentID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check branch-department relationship
        IF NOT EXISTS (
            SELECT 1 
            FROM Branch_Department_Track 
            WHERE branchID = @BranchID 
            AND departmentID = @DepartmentID
            AND isDeleted = 0
        )
        BEGIN
            RAISERROR ('Department %d does not exist in branch %d or is deleted.', 16, 1, @DepartmentID, @BranchID);
            RETURN;
        END;

        -- Get branch-specific department manager
        SELECT 
            I.*,
            BDT.departmentManagerID AS BranchDepartmentManagerID
        FROM Branch_Department_Track BDT
        INNER JOIN Instructor I
            ON BDT.departmentManagerID = I.ID
            AND I.isDeleted = 0
        INNER JOIN Department D 
            ON BDT.departmentID = D.ID
            AND D.isDeleted = 0
        WHERE BDT.branchID = @BranchID
          AND BDT.departmentID = @DepartmentID;

        PRINT 'Department manager retrieved for branch ' + CAST(@BranchID AS NVARCHAR) 
            + ' and department ' + CAST(@DepartmentID AS NVARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error retrieving department manager: ' + ERROR_MESSAGE();
    END CATCH;
END;
GO

-- create new department 
CREATE OR ALTER PROCEDURE InsertDepartment
    @DEPTNAME NVARCHAR(100),
    @NewDepartmentID INT OUTPUT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if department name exists
        IF EXISTS (SELECT 1 FROM Department WHERE Name = @DEPTNAME)
        BEGIN
            -- Handle existing department
            IF EXISTS (
                SELECT 1 
                FROM Department 
                WHERE Name = @DEPTNAME 
                AND isDeleted = 1
            )
            BEGIN
                -- Reactivate department with new manager
                UPDATE Department
                SET isDeleted = 0,
                    creationDate = GETDATE()
                WHERE Name = @DEPTNAME;

                SELECT @NewDepartmentID = ID
                FROM Department 
                WHERE Name = @DEPTNAME;

                PRINT 'Reactivated department "' + @DEPTNAME ;
            END
            ELSE
            BEGIN
                RAISERROR ('Department name already exists and is active.', 16, 1);
                RETURN;
            END
        END
        ELSE
        BEGIN
            -- Insert new department with validated manager
            INSERT INTO DEPARTMENT
                (Name, creationDate)
            VALUES
                (@DEPTNAME, GETDATE());

            SET @NewDepartmentID = SCOPE_IDENTITY();
            PRINT 'New department "' + @DEPTNAME + '" is created';
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        RETURN;
    END CATCH
END;
GO

-- update department
CREATE OR ALTER PROCEDURE UpdateDepartment
    @DepartmentID INT,
    @NewName NVARCHAR(100) = NULL
AS
BEGIN
    -- Check if the department exists and is not deleted
    IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DepartmentID AND isDeleted = 0)
    BEGIN
        SELECT 'Department does not exist or is deleted.' AS Message;
        RETURN;
    END;

    -- Initialize variables for feedback
    DECLARE @NameUpdated BIT = 0;

    -- Update the Name if a new name is provided and it's unique
    IF @NewName IS NOT NULL AND
        NOT EXISTS (SELECT 1 FROM Department WHERE Name = @NewName AND ID != @DepartmentID)
    BEGIN
        UPDATE Department
        SET Name = @NewName
        WHERE ID = @DepartmentID;
        SET @NameUpdated = 1;
    END
    ELSE IF @NewName IS NOT NULL
    BEGIN
        SELECT 'Department name already exists or is invalid.' AS Message;
    END;
    -- Return success message if any updates were made
    IF @NameUpdated = 1
    BEGIN
        SELECT 'Department updated successfully.' AS Message;
    END;
END;
GO



-- delete a department 
CREATE OR ALTER PROCEDURE DeleteDepartment
    @DEPTID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if the department exists and is not already deleted
        IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DEPTID AND isDeleted = 0)
        BEGIN
            RAISERROR('Department with ID %d does not exist or is already deleted.', 16, 1, @DEPTID);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Check for active dependencies in Branch_Department_Track
        IF EXISTS (SELECT 1 FROM Branch_Department_Track WHERE departmentID = @DEPTID AND isDeleted = 0)
        BEGIN
            RAISERROR('Department with ID %d has active dependencies in Branch_Department_Track. Delete them first.', 16, 1, @DEPTID);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Soft delete the department
        UPDATE Department
        SET isDeleted = 1
        WHERE ID = @DEPTID;

        --hard delet from Departement_Instructor table
        DELETE FROM Department_Instructor
        WHERE departmentID = @DEPTID

        -- Soft delete the track
        UPDATE Track
        SET isDeleted = 1
        WHERE departmentID = @DEPTID;

        -- Ensure the update affected rows
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('The department deletion failed; no rows were updated.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        COMMIT TRANSACTION;

        PRINT 'Department with ID ' + CAST(@DEPTID AS NVARCHAR) + ' has been soft deleted successfully.';
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