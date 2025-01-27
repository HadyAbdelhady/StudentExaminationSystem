DECLARE @SystemDevID INT, @AIID INT, @JavaTrainingID INT;

-- Insert System Development Department
EXEC InsertDepartment
    @DEPTNAME = N'System Development',
    @NewDepartmentID = @SystemDevID OUTPUT;

PRINT 'System Development Department inserted with ID: ' + CAST(@SystemDevID AS NVARCHAR);

-- Insert Artificial Intelligence Department
EXEC InsertDepartment
    @DEPTNAME = N'Artificial Intelligence',
    @NewDepartmentID = @AIID OUTPUT;

PRINT 'Artificial Intelligence Department inserted with ID: ' + CAST(@AIID AS NVARCHAR);

-- Insert Java Education Training Services Department
EXEC InsertDepartment
    @DEPTNAME = N'Java Education Training Services',
    @NewDepartmentID = @JavaTrainingID OUTPUT;
