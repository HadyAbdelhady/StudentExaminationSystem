-------------------------------------------
-------------Department_instructor---------
-------------------------------------------

-- Insertion SP
CREATE PROCEDURE InsertIntoDepartmenttInstructor
    @DEPTID INT,
    @INSTID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the department and instructor are not deleted
        IF EXISTS (SELECT 1 FROM Department WHERE ID = @DEPTID AND isDeleted = 0) AND
           EXISTS (SELECT 1 FROM Instructor WHERE ID = @INSTID AND isDeleted = 0)
        BEGIN
            -- Attempt to insert the data
            INSERT INTO Department_Instructor
            (instructorID, departmentID, joinDate)
            VALUES
            (@INSTID, @DEPTID, GETDATE())
        END
        ELSE
        BEGIN
            RAISERROR ('Department or Instructor is deleted or does not exist.', 16, 1);
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

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- Delete SP 
CREATE PROCEDURE DeleteInstructorFromDepartment
    @INSTID INT,
    @DEPTID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the department and instructor are not deleted
        IF EXISTS (SELECT 1 FROM Department WHERE ID = @DEPTID AND isDeleted = 0) AND
           EXISTS (SELECT 1 FROM Instructor WHERE ID = @INSTID AND isDeleted = 0)
        BEGIN
            DELETE FROM Department_Instructor
            WHERE departmentID = @DEPTID AND instructorID = @INSTID
        END
        ELSE
        BEGIN
            RAISERROR ('Department or Instructor is deleted or does not exist.', 16, 1);
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

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- Read SP

-- Get the IDs of the instructors in a specific department
CREATE PROCEDURE GetInstructorsIDsInDepartment
    @DEPTID INT
AS
BEGIN
    BEGIN TRY
        SELECT DI.instructorID
        FROM Department_Instructor DI
        INNER JOIN Instructor I ON DI.instructorID = I.ID
        WHERE DI.departmentID = @DEPTID AND I.isDeleted = 0;
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

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- Get all the data of the indtructors in a specific department 
CREATE PROCEDURE GetInstructorsDataInDepartment
    @DEPTID INT
AS
BEGIN
    BEGIN TRY 
        SELECT INST.*, DEPT_INST.joinDate
        FROM Instructor INST
        INNER JOIN Department_Instructor DEPT_INST ON INST.ID = DEPT_INST.instructorID
        WHERE DEPT_INST.departmentID = @DEPTID AND INST.isDeleted = 0;
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

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
