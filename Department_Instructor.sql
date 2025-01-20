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
        -- Attempt to insert the data
        INSERT INTO Department_Instructor
        (instructorID, departmentID, joinDate)
    VALUES
        (@INSTID, @DEPTID, GETDATE())
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
    @INSTID INT ,
    @DEPTID INT
AS
BEGIN
    BEGIN TRY
    DELETE FROM Department_Instructor
    WHERE departmentID = @DEPTID AND instructorID = @INSTID
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
        SELECT InstructorID
    FROM Department_Instructor
    WHERE departmentID = @DEPTID;
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

-- Get all the data of the indtructors in a specific department 
CREATE PROCEDURE GetInstructorsDataInDepartment
    @DEPTID INT
AS

BEGIN
    BEGIN TRY 
        SELECT INST.* , DEPT_INST.joinDate
    FROM Instructor INST INNER JOIN Department_Instructor DEPT_INST
        ON INST.ID = DEPT_INST.instructorID
    WHERE @DEPTID = DEPT_INST.departmentID
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
END