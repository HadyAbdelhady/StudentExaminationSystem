-----------------------------------------------------
------------------ Department -----------------------
-----------------------------------------------------

-- getting all the departments data
CREATE PROCEDURE GetDepartmentData
AS
BEGIN
    SELECT *
    FROM Department
    WHERE isDeleted = 0;
END;
GO

-- getting the manager data of a specific department
CREATE PROCEDURE GetDepartmentManager
    @MANAGERID INT
AS
BEGIN
    SELECT INST.*
    FROM DEPARTMENT DEPT
    INNER JOIN INSTRUCTOR INST ON DEPT.ManagerID = INST.ID
    WHERE DEPT.ManagerID = @MANAGERID AND DEPT.isDeleted = 0;
END;
GO

-- create new department 
CREATE PROCEDURE InsertDepartment
    @DEPTNAME VARCHAR(100),
    @DEPTMANAGER INT,
    @NewDepartmentID INT OUTPUT
AS
BEGIN
    -- Check if the manager is not deleted
    IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @DEPTMANAGER AND isDeleted = 0)
    BEGIN
        INSERT INTO DEPARTMENT
            (NAME, MANAGERID, CREATIONDATE)
        VALUES
            (@DEPTNAME, @DEPTMANAGER, GETDATE());

        -- Set the output parameter to the last inserted identity value
        SET @NewDepartmentID = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        RAISERROR ('Manager is deleted or does not exist.', 16, 1);
    END
END;
GO

-- update department
CREATE PROCEDURE UpdateDepartment
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
CREATE PROCEDURE DeleteDepartment
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