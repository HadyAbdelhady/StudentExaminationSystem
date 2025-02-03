--- Add a New Student
CREATE OR ALTER PROCEDURE InsertStudent
    @firstName NVARCHAR(20),
    @lastName NVARCHAR(20),
    @gender NVARCHAR(10),
    @SSN NVARCHAR(20),
    @enrollmentDate DATETIME = GETDATE,
    @Email NVARCHAR(100),
    @phone NVARCHAR(15),
    @DateOfBirth DATE,
    @address NVARCHAR(200),
    @trackID INT,
    @branchID INT,
    @departmentID INT
AS 
BEGIN
    BEGIN TRY
    BEGIN TRANSACTION
        DECLARE @studentID INT;
        -- Handling Data Dublication
        IF EXISTS (SELECT 1 FROM Student WHERE SSN = @SSN AND isDeleted = 0)
            BEGIN
                RAISERROR('Student with this SSN : "%s" already exists', 16, 1, @SSN)
			    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
                RETURN
            END;
        -- Handling Department existance 
        IF NOT EXISTS (SELECT 1 FROM Branch_Department_Track 
               WHERE branchID = @branchID 
                 AND departmentID = @departmentID 
                 AND trackID = @trackID 
                 AND isDeleted = 0)
            BEGIN
                RAISERROR('check the avilability of that track in the specified department or branch', 16, 2)
			    RETURN
            END;
        IF EXISTS (SELECT 1 FROM Student WHERE SSN = @SSN AND isDeleted = 1)
            BEGIN
                UPDATE Student 
                SET firstName = @firstName ,
                    lastName = @lastName ,
                    gender = @gender,
                    enrollmentDate = @enrollmentDate,
                    email = @email,
                    phone = @phone,
                    DateOfBirth = @DateOfBirth,
                    address = @address,
                    branchID = @branchID,
                    departmentID = @departmentID,
                    trackId = @trackID,
                    isDeleted = 0
                WHERE SSN = @SSN; 

                -- RETURNING THE ID OF THE NEWLY UPDATED (REINSERTED) STUDENT 
                SELECT @studentID =  ID FROM Student
                WHERE SSN = @SSN;
            END
            ELSE 
            BEGIN 
                -- Insert the new student
                INSERT INTO Student (firstName, lastName, gender, SSN, enrollmentDate, email, phone, DateOfBirth, address, trackID, departmentID, branchID)
                VALUES (@firstName, @lastName, @gender, @SSN, @enrollmentDate , @email, @phone, @DateOfBirth, @address, @trackID, @departmentID, @branchID);
                
                -- Get the ID of the inserted student
                SET @studentID = SCOPE_IDENTITY();
            END;

        -- Enroll the student in all courses associated with the track
        INSERT INTO Course_Student_Instructor (courseID, studentID, startDate)
        SELECT 
            tc.courseID,
            @studentID,
            GETDATE() 
        FROM 
            Track_Course tc
        WHERE 
            tc.trackID = @trackID;
        
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of error
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        -- Raise the error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO

--Get Student by ID
CREATE OR ALTER PROCEDURE GetStudentById
    @StudentID INT
AS
BEGIN
    SELECT 
        Std.ID, 
        Std.firstName, 
        Std.lastName, 
        Std.gender, 
        Std.SSN, 
        Std.enrollmentDate, 
        Std.email, 
        Std.phone, 
        Std.DateOfBirth, 
        Std.address, 
        Std.trackID, 
        Std.departmentID, 
        Std.branchID, 
        D.Name AS [departmentName], 
        T.Name AS [trackName], 
        B.Name AS [branchName]
    FROM 
        Student Std 
    INNER JOIN 
        Department D ON Std.departmentID = D.ID
    INNER JOIN 
        Track T ON Std.trackID = T.ID
    INNER JOIN 
        Branch B ON B.ID = std.branchID
    WHERE 
        Std.ID = @StudentID 
        AND Std.isDeleted = 0;
END;
GO

--Remove a Student
CREATE OR ALTER PROCEDURE DeleteStudent
    @StudentID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Check if the student exists and is not already deleted
        IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID AND isDeleted = 0)
        BEGIN
            RAISERROR('Student with ID %d does not exist or is already deleted.', 16, 1, @StudentID);
            RETURN;
        END;

        -- Mark the student as deleted
        UPDATE Student
        SET isDeleted = 1
        WHERE ID = @StudentID;

        DELETE FROM Course_Student_Instructor
        WHERE studentID = @studentID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

--Update Student Information
CREATE OR ALTER PROCEDURE UpdateStudent
    @StudentID INT,
    @firstName NVARCHAR(20),
    @lastName NVARCHAR(20),
    @gender NVARCHAR(10),
    @SSN NVARCHAR(20),
    @email NVARCHAR(100),
    @phone NVARCHAR(15),
    @DateOfBirth DATE,
    @address NVARCHAR(200),
    @trackID INT,
    @departmentID INT,
    @branchID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Check if the student exists and is not deleted
        DECLARE @oldTrackID INT;
        SELECT @oldTrackID = trackId 
        FROM STUDENT 
        WHERE ID = @StudentID AND isDeleted = 0;

        IF @oldTrackID IS NULL
        BEGIN
            RAISERROR('Student with ID %d does not exist or is deleted.', 16, 1, @StudentID);
            RETURN;
        END;

        -- Validate Branch, Department, and Track combination
        IF NOT EXISTS (
            SELECT 1
            FROM Branch_Department_Track bdt
            WHERE bdt.trackID = @trackID
                AND bdt.departmentID = @departmentID
                AND bdt.branchID = @branchID
                AND bdt.isDeleted = 0
        )
        BEGIN
            RAISERROR('Invalid combination of Branch, Department, or Track. Ensure all IDs are valid and active.', 16, 1);
            RETURN;
        END;

        -- Update courses if track has changed
        IF @oldTrackID <> @trackID
        BEGIN
            -- Remove existing courses for the student
            DELETE FROM Course_Student_Instructor
            WHERE studentID = @StudentID;

            -- Enroll in courses for the new track
            INSERT INTO Course_Student_Instructor (courseID, studentID, startDate)
            SELECT 
                tc.courseID,
                @StudentID,
                GETDATE()
            FROM 
                Track_Course tc
            WHERE 
                tc.trackID = @trackID;
        END

        -- Update student details
        UPDATE Student
        SET 
            firstName = @firstName,
            lastName = @lastName,
            gender = @gender,
            SSN = @SSN,
            email = @email,
            phone = @phone,
            DateOfBirth = @DateOfBirth,
            address = @address,
            trackID = @trackID,
            departmentID = @departmentID,
            branchID = @branchID
        WHERE 
            ID = @StudentID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

--Enroll Student in a Course
CREATE OR ALTER PROCEDURE InsertStudentInCourse
    @courseID INT,
    @studentID INT,
    @instructorID INT,
    @startDate DATETIME
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @studentTrackID INT;

        -- Check if student exists and get their track
        SELECT @studentTrackID = trackID 
        FROM Student 
        WHERE ID = @studentID AND isDeleted = 0;

        IF @studentTrackID IS NULL
        BEGIN
            RAISERROR('Student with ID %d does not exist or is deleted.', 16, 1, @studentID);
            RETURN;
        END;

        -- Check course existence
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @courseID);
            RETURN;
        END;

        -- Check if course is part of student's track
        IF NOT EXISTS (
            SELECT 1 
            FROM Track_Course 
            WHERE trackID = @studentTrackID 
            AND courseID = @courseID
        )
        BEGIN
            RAISERROR('Course ID %d is not available in the student''s track.', 16, 1, @courseID);
            RETURN;
        END;

        -- Check existing enrollment
        IF EXISTS (
            SELECT 1 
            FROM Course_Student_Instructor 
            WHERE courseID = @courseID 
            AND studentID = @studentID
        )
        BEGIN
            RAISERROR('Student is already enrolled in course ID %d.', 16, 1, @courseID);
            RETURN;
        END;

        -- Insert enrollment
        INSERT INTO Course_Student_Instructor (courseID, studentID, instructorID, startDate)
        VALUES (@courseID, @studentID, @instructorID, @startDate);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

--Get Courses Enrolled by a Student
CREATE OR ALTER PROCEDURE GetCoursesEnrolledByStudent
    @studentID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the student exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @studentID AND isDeleted = 0)
        BEGIN
            RAISERROR('Student with ID %d does not exist or is deleted.', 16, 1, @studentID);
            RETURN;
        END;

        -- Retrieve the courses the student is enrolled in
        SELECT 
            c.Name as [CourseName],
            Inst.firstName,
            Inst.lastName,
            CSI.startDate,
            CSI.courseId,
            CSI.StudentId,
            CSI.instructorId
        FROM 
            Course_Student_Instructor CSI
        INNER JOIN 
            Course c ON CSI.courseID = c.ID
        INNER JOIN
            Instructor Inst ON Inst.Id = CSI.instructorId
        WHERE 
            CSI.studentID = @studentID
            AND c.isDeleted = 0;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

GO
CREATE OR ALTER PROCEDURE GetCoursesNotEnrolledByStudent
    @studentID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the student exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @studentID AND isDeleted = 0)
        BEGIN
            RAISERROR('Student with ID %d does not exist or is deleted.', 16, 1, @studentID);
            RETURN;
        END;

        -- Retrieve courses not enrolled by the student but available in their track
        SELECT 
            C.Name AS [CourseName],
            C.ID AS [CourseId]
        FROM 
            Track_Course TC
            INNER JOIN Student S ON S.trackID = TC.trackID
            INNER JOIN Course C ON TC.courseID = C.ID
        WHERE 
            S.ID = @studentID
            AND C.isDeleted = 0 
            AND C.ID NOT IN (
                SELECT CourseId 
                FROM Course_Student_Instructor 
                WHERE studentId = @studentID
            );
    END TRY
    BEGIN CATCH
        -- Handle errors
        THROW;
    END CATCH
END;


GO
CREATE OR ALTER PROCEDURE DeleteCourseFromStudent
    @courseID INT,
    @studentID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1
            FROM Course_Student_Instructor
            WHERE courseID = @courseID AND studentID = @studentID
        )
        BEGIN
            RAISERROR('No matching record found for the given course and student.', 16, 1);
            RETURN;
        END;

        DELETE FROM Course_Student_Instructor
        WHERE courseID = @courseID AND studentID = @studentID;

        COMMIT TRANSACTION;
        PRINT 'Student successfully removed from the course.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
		SELECT  @ErrorMessage = ERROR_MESSAGE(), 
				@ErrorSeverity = ERROR_SEVERITY(), 
				@ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

-------------------------------------------------
GO
--Count Students Enrolled in a Course
CREATE OR ALTER PROCEDURE GetCountStudentInCourse
    @courseID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0)
    BEGIN
        RAISERROR ('The specified course ID does not exist.', 16, 1);
        RETURN;
    END;
    SELECT COUNT(CSI.studentID) AS StudentCount
    FROM Course_Student_Instructor CSI
    WHERE CSI.courseID = @courseID;
END;


------------------------EXTRA MAHARAT------------------------------------------------
GO 
CREATE OR ALTER PROCEDURE GetCountExamAnsweredByStudent
    @StudentID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
    BEGIN
        RAISERROR('Student with ID %d not found.', 16, 1, @StudentID);
        RETURN;
    END

    SELECT COUNT(*)
    FROM StudentSubmit SS
    WHERE SS.studentID = @StudentID;
END;

--------------------------------------------------------------

GO
CREATE OR ALTER PROCEDURE GetExamCourseNamesByStudent
    @StudentID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
    BEGIN
        RAISERROR('Student with ID %d not found.', 16, 1, @StudentID);
        RETURN;
    END

    SELECT C.Name AS ExamName
    FROM Course C
    INNER JOIN ExamModel EM
        ON C.ID = EM.CourseID
    INNER JOIN StudentSubmit SS
        ON EM.ID = SS.examModelID
    WHERE SS.studentID = @StudentID;
END;

----------------------------------------------------------------------


GO
CREATE OR ALTER PROCEDURE GetAllStudentsInBranch
    @BranchID INT
AS
BEGIN
    -- Check for active branch
    IF NOT EXISTS (SELECT 1 FROM Branch WHERE ID = @BranchID AND isDeleted = 0)
    BEGIN
        RAISERROR('Branch with ID %d does not exist or is deleted.', 16, 1, @BranchID);
        RETURN;
    END;

    SELECT 
        S.ID,
        S.firstName,
        S.lastName,
        S.gender,
        S.SSN,
        S.enrollmentDate,
        S.email,
        S.phone,
        S.DateOfBirth,
        S.address,
        S.trackID,
        S.branchID,
        S.departmentID,
        T.Name AS [TrackName],
        D.Name AS [DepartmentName],
        B.Name AS [branchName]
    FROM 
        Student S
    INNER JOIN 
        Branch B ON S.branchID = B.ID AND B.isDeleted = 0
    INNER JOIN 
        Branch_Department_Track BDT 
        ON S.branchID = BDT.branchID 
        AND S.departmentID = BDT.departmentID 
        AND S.trackID = BDT.trackID 
        AND BDT.isDeleted = 0
    INNER JOIN Department D ON D.ID = S.departmentID
    INNER JOIN Track T ON T.ID = S.trackID
    WHERE 
        S.branchID = @BranchID
        AND S.isDeleted = 0;

END;
GO
CREATE OR ALTER PROCEDURE GetAllStudentsInDepartment
    @DepartmentID INT
AS
BEGIN
    -- Check for active department
    IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DepartmentID AND isDeleted = 0)
    BEGIN
        RAISERROR('Department with ID %d does not exist or is deleted.', 16, 1, @DepartmentID);
        RETURN;
    END;

    SELECT 
        S.ID,
        S.firstName,
        S.lastName,
        S.gender,
        S.SSN,
        S.enrollmentDate,
        S.email,
        S.phone,
        S.DateOfBirth,
        S.address,
        S.trackID,
        S.branchID,
        S.departmentID,
        T.Name AS [TrackName],
        D.Name AS [DepartmentName],
        B.Name AS [branchName]
    FROM 
        Student S
    INNER JOIN 
        Department D ON S.departmentID = D.ID AND D.isDeleted = 0
    INNER JOIN 
        Branch_Department_Track BDT 
        ON S.branchID = BDT.branchID 
        AND S.departmentID = BDT.departmentID 
        AND S.trackID = BDT.trackID 
        AND BDT.isDeleted = 0
    INNER JOIN Track T ON T.ID = S.trackID
    INNER JOIN Branch B ON B.ID = S.branchID
    WHERE 
        S.departmentID = @DepartmentID
        AND S.isDeleted = 0;
END;
GO
CREATE OR ALTER PROCEDURE GetAllStudentsInTrack
    @TrackID INT
AS
BEGIN
    -- Check for active track
    IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @TrackID AND isDeleted = 0)
    BEGIN
        RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @TrackID);
        RETURN;
    END;

    SELECT 
        S.ID,
        S.firstName,
        S.lastName,
        S.gender,
        S.SSN,
        S.enrollmentDate,
        S.email,
        S.phone,
        S.DateOfBirth,
        S.address,
        S.trackID,
        S.branchID,
        S.departmentID,
        T.Name AS [TrackName],
        D.Name AS [DepartmentName],
        B.Name AS [branchName]
    FROM 
        Student S
    INNER JOIN 
        Track T ON S.trackID = T.ID AND T.isDeleted = 0
    INNER JOIN 
        Branch_Department_Track BDT 
        ON S.branchID = BDT.branchID 
        AND S.departmentID = BDT.departmentID 
        AND S.trackID = BDT.trackID 
        AND BDT.isDeleted = 0
    INNER JOIN 
        Branch B ON B.ID = S.branchID
    INNER JOIN 
        Department D ON D.ID = S.departmentID
    WHERE 
        S.trackID = @TrackID
        AND S.isDeleted = 0;
END;
GO
CREATE OR ALTER PROCEDURE GetStudentCountInBranch
    @BranchID INT
AS
BEGIN
    -- Check for active branch
    IF NOT EXISTS (SELECT 1 FROM Branch WHERE ID = @BranchID AND isDeleted = 0)
    BEGIN
        RAISERROR('Branch with ID %d does not exist or is deleted.', 16, 1, @BranchID);
        RETURN;
    END;

    SELECT 
        COUNT(*) AS StudentCount,
        B.Name AS BranchName
    FROM 
        Student S
    INNER JOIN 
        Branch B ON S.branchID = B.ID AND B.isDeleted = 0
    INNER JOIN 
        Branch_Department_Track BDT 
        ON S.branchID = BDT.branchID 
        AND S.departmentID = BDT.departmentID 
        AND S.trackID = BDT.trackID 
        AND BDT.isDeleted = 0
    WHERE 
        S.branchID = @BranchID
        AND S.isDeleted = 0
    GROUP BY 
        B.Name;
END;
GO
CREATE OR ALTER PROCEDURE GetStudentCountInDepartment
    @DepartmentID INT
AS
BEGIN
    -- Check for active department
    IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @DepartmentID AND isDeleted = 0)
    BEGIN
        RAISERROR('Department with ID %d does not exist or is deleted.', 16, 1, @DepartmentID);
        RETURN;
    END;

    SELECT 
        COUNT(*) AS StudentCount,
        D.Name AS DepartmentName
    FROM 
        Student S
    INNER JOIN 
        Department D ON S.departmentID = D.ID AND D.isDeleted = 0
    INNER JOIN 
        Branch_Department_Track BDT 
        ON S.branchID = BDT.branchID 
        AND S.departmentID = BDT.departmentID 
        AND S.trackID = BDT.trackID 
        AND BDT.isDeleted = 0
    WHERE 
        S.departmentID = @DepartmentID
        AND S.isDeleted = 0
    GROUP BY 
        D.Name;
END;
GO
CREATE OR ALTER PROCEDURE GetStudentCountInTrack
    @TrackID INT
AS
BEGIN
    -- Check for active track
    IF NOT EXISTS (SELECT 1 FROM Track WHERE ID = @TrackID AND isDeleted = 0)
    BEGIN
        RAISERROR('Track with ID %d does not exist or is deleted.', 16, 1, @TrackID);
        RETURN;
    END;

    SELECT 
        COUNT(*) AS StudentCount,
        T.Name AS TrackName
    FROM 
        Student S
    INNER JOIN 
        Track T ON S.trackID = T.ID AND T.isDeleted = 0
    INNER JOIN 
        Branch_Department_Track BDT 
        ON S.branchID = BDT.branchID 
        AND S.departmentID = BDT.departmentID 
        AND S.trackID = BDT.trackID 
        AND BDT.isDeleted = 0
    WHERE 
        S.trackID = @TrackID
        AND S.isDeleted = 0
    GROUP BY 
        T.Name;
END;
GO

CREATE OR ALTER PROCEDURE GetAllStudents
AS 
BEGIN
    SELECT 
        S.ID,
        S.firstName,
        S.lastName,
        S.gender,
        S.SSN,
        S.enrollmentDate,
        S.email,
        S.phone,
        S.DateOfBirth,
        S.address,
        S.trackID,
        S.branchID,
        S.departmentID,
        T.Name AS [TrackName],
        D.Name AS [DepartmentName],
        B.Name AS [branchName] 
    FROM Student S
    INNER JOIN Department D on D.ID = S.departmentID
    INNER JOIN Track T ON T.ID = S.trackID
    INNER JOIN Branch B ON B.ID = S.branchID
    WHERE S.isDeleted = 0;
END;

GO

CREATE OR ALTER PROCEDURE GetAllStudentsInCourse 
@courseID INT
AS 
BEGIN
    SELECT 
        S.ID,
        S.firstName,
        S.lastName,
        S.gender,
        S.SSN,
        S.enrollmentDate,
        S.email,
        S.phone,
        S.DateOfBirth,
        S.address,
        S.trackID,
        S.branchID,
        S.departmentID,
        T.Name AS [TrackName],
        D.Name AS [DepartmentName],
        B.Name AS [branchName] 
    FROM Student S
    INNER JOIN Department D on D.ID = S.departmentID
    INNER JOIN Track T ON T.ID = S.trackID
    INNER JOIN Branch B ON B.ID = S.branchID
    INNER JOIN Course_Student_Instructor CSI ON CSI.studentID = S.ID
    WHERE S.isDeleted = 0 AND CSI.courseID = @courseID;
END;

GO

CREATE OR ALTER PROCEDURE GetAllStudentsPerInstructor
@instructorId INT
AS
BEGIN
     SELECT 
        S.ID,
        S.firstName,
        S.lastName,
        S.gender,
        S.SSN,
        S.enrollmentDate,
        S.email,
        S.phone,
        S.DateOfBirth,
        S.address,
        S.trackID,
        S.branchID,
        S.departmentID,
        T.Name AS [TrackName],
        D.Name AS [DepartmentName],
        B.Name AS [branchName] 
    FROM Student S
    INNER JOIN Department D on D.ID = S.departmentID
    INNER JOIN Track T ON T.ID = S.trackID
    INNER JOIN Branch B ON B.ID = S.branchID
    INNER JOIN Course_Student_Instructor CSI ON CSI.studentID = S.ID
    WHERE S.isDeleted = 0 AND CSI.instructorID = @instructorId;
END;

GO

CREATE OR ALTER PROCEDURE GetAllStudentsInCourseAndInstructor
    @instructorId INT,
    @courseId INT
AS
BEGIN
     SELECT 
        S.ID,
        S.firstName,
        S.lastName,
        S.gender,
        S.SSN,
        S.enrollmentDate,
        S.email,
        S.phone,
        S.DateOfBirth,
        S.address,
        S.trackID,
        S.branchID,
        S.departmentID,
        T.Name AS [TrackName],
        D.Name AS [DepartmentName],
        B.Name AS [branchName] 
    FROM Student S
    INNER JOIN Department D on D.ID = S.departmentID
    INNER JOIN Track T ON T.ID = S.trackID
    INNER JOIN Branch B ON B.ID = S.branchID
    INNER JOIN Track_Course TC ON TC.trackID = T.ID 
    INNER JOIN Course_Student_Instructor CSI ON CSI.studentID = S.ID
    WHERE S.isDeleted = 0 AND CSI.instructorID = @instructorId AND TC.courseID = @courseId;
END;