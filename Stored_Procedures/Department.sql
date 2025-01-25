-----------------------------------------------------
------------------ Department -----------------------
-----------------------------------------------------

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
            D.ID AS DepartmentID,
            D.Name AS DepartmentName,
            D.creationDate AS DepartmentCreationDate,
            BDT.departmentManagerID AS DepartmentManagerID
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
            BDT.departmentManagerID AS BranchDepartmentManagerID,
            D.ManagerID AS GlobalDepartmentManagerID
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
AS
BEGIN
    -- Check if the department exists and is not already deleted
    IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DEPTID AND isDeleted = 0)
    BEGIN
        SELECT 'Department does not exist or is already deleted.' AS Message;
        RETURN;
    END;

    -- Check if there are dependent instructors
    DECLARE @NumOfDependantInstructors INT;
    SET @NumOfDependantInstructors = (
        SELECT COUNT(*)
        FROM Department_Instructor
        WHERE departmentID = @DEPTID
    );

    IF @NumOfDependantInstructors > 0 
    BEGIN
        SELECT 'Department cannot be deleted. Some instructors are assigned to it.' AS Message;
        RETURN;
    END;

    -- Check if there are dependent tracks
    DECLARE @NumOfDependantTracks INT;
    SET @NumOfDependantTracks = (
        SELECT COUNT(*)
        FROM TRACK
        WHERE DEPARTMENTID = @DEPTID
    );

    IF @NumOfDependantTracks > 0 
    BEGIN
        SELECT 'Department cannot be deleted. Some tracks have been added to it.' AS Message;
        RETURN;
    END;

    -- Check if there are dependent students
    DECLARE @NumOfDependantStudents INT;
    SET @NumOfDependantStudents = (
        SELECT COUNT(ID)
        FROM STUDENT
        WHERE DEPARTMENTID = @DEPTID
    );

    IF @NumOfDependantStudents > 0 
    BEGIN
        SELECT 'Department cannot be deleted. Some students have been enrolled in it.' AS Message;
        RETURN;
    END;

    -- If no dependencies, mark the department as deleted
    UPDATE Department
    SET isDeleted = 1
    WHERE ID = @DEPTID;

    SELECT 'Department marked as deleted successfully.' AS Message;
END;
GO