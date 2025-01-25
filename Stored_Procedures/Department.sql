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

-- getting the manager data of a specific department
CREATE OR ALTER PROCEDURE GetDepartmentManager
    @MANAGERID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if manager exists and is active
        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor 
            WHERE ID = @MANAGERID 
            AND isDeleted = 0
        )
        BEGIN
            PRINT 'Manager with ID ' + CAST(@MANAGERID AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Check if department exists and is active
        IF NOT EXISTS (
            SELECT 1 
            FROM Department 
            WHERE ManagerID = @MANAGERID 
            AND isDeleted = 0
        )
        BEGIN
            PRINT 'No active department found for manager ID ' + CAST(@MANAGERID AS NVARCHAR);
            RETURN;
        END;

        -- Retrieve manager details
        SELECT INST.*
        FROM DEPARTMENT DEPT
        INNER JOIN INSTRUCTOR INST 
            ON DEPT.ManagerID = INST.ID
            AND INST.isDeleted = 0
        WHERE DEPT.ManagerID = @MANAGERID 
          AND DEPT.isDeleted = 0;

        PRINT 'Manager details retrieved successfully for ID ' + CAST(@MANAGERID AS NVARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred while retrieving department manager:';
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END;
GO

-- create new department 
CREATE OR ALTER PROCEDURE InsertDepartment
    @DEPTNAME NVARCHAR(100),
    @DEPTMANAGER INT,
    @NewDepartmentID INT OUTPUT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check manager validation for all cases
        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor 
            WHERE ID = @DEPTMANAGER 
            AND isDeleted = 0
        )
        BEGIN
            RAISERROR ('Invalid ManagerID: Manager does not exist or is deleted.', 16, 1);
            RETURN;
        END

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
                    ManagerID = @DEPTMANAGER,  -- Update to new valid manager
                    creationDate = GETDATE()
                WHERE Name = @DEPTNAME;

                SELECT @NewDepartmentID = ID
                FROM Department 
                WHERE Name = @DEPTNAME;

                PRINT 'Reactivated department "' + @DEPTNAME + '" with new ManagerID: ' 
                      + CAST(@DEPTMANAGER AS NVARCHAR);
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
                (Name, ManagerID, creationDate)
            VALUES
                (@DEPTNAME, @DEPTMANAGER, GETDATE());

            SET @NewDepartmentID = SCOPE_IDENTITY();
            PRINT 'New department "' + @DEPTNAME + '" created with ManagerID: ' 
                  + CAST(@DEPTMANAGER AS NVARCHAR);
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
    @NewName NVARCHAR(100) = NULL,
    @NewManagerID INT = NULL
AS
BEGIN
    -- Check if the department exists and is not deleted
    IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DepartmentID AND isDeleted = 0)
    BEGIN
        SELECT 'Department does not exist or is deleted.' AS Message;
        RETURN;
    END;

    -- Initialize variables for feedback
    DECLARE @NameUpdated BIT = 0, @ManagerUpdated BIT = 0;

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

    -- Update the ManagerID if a new manager ID is provided and not assigned elsewhere
    IF @NewManagerID IS NOT NULL
    BEGIN
        -- Check if the new manager exists and is not deleted
        IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @NewManagerID AND isDeleted = 0)
        BEGIN
            -- Check if the new manager is not already assigned to another department
            IF NOT EXISTS (SELECT 1 FROM Department WHERE ManagerID = @NewManagerID AND ID != @DepartmentID)
            BEGIN
                UPDATE Department
                SET ManagerID = @NewManagerID
                WHERE ID = @DepartmentID;
                SET @ManagerUpdated = 1;
            END
            ELSE
            BEGIN
                SELECT 'Manager is already assigned to another department.' AS Message;
            END;
        END
        ELSE
        BEGIN
            SELECT 'Manager is deleted or does not exist.' AS Message;
        END;
    END;

    -- Return success message if any updates were made
    IF @NameUpdated = 1 OR @ManagerUpdated = 1
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