-- Insert Instructor 1
EXEC InsertInstructor 
    @fName = 'John',
    @lName = 'Doe',
    @Gender = 'M',
    @ssn = 123456789,
    @mail = 'john.doe@university.edu',
    @mobilePhone = '1234567890',
    @enrollDate = '2020-01-01',
    @DOB = '1980-05-15',
    @homeAt = '123 Main St, City, Country';

-- Insert Instructor 2
EXEC InsertInstructor 
    @fName = 'Jane',
    @lName = 'Smith',
    @Gender = 'F',
    @ssn = 987654321,
    @mail = 'jane.smith@university.edu',
    @mobilePhone = '0987654321',
    @enrollDate = '2019-06-01',
    @DOB = '1985-10-20',
    @homeAt = '456 Elm St, City, Country';

-- Insert Instructor 3
EXEC InsertInstructor 
    @fName = 'Michael',
    @lName = 'Johnson',
    @Gender = 'M',
    @ssn = 126359748,
    @mail = 'michael.johnson@university.edu',
    @mobilePhone = '1234567890',
    @enrollDate = '2020-09-15',
    @DOB = '1990-03-12',
    @homeAt = '789 Oak St, City, Country';

-- Insert Instructor 4
EXEC InsertInstructor 
    @fName = 'Sophia',
    @lName = 'Brown',
    @Gender = 'F',
    @ssn = 375849102,
    @mail = 'sophia.brown@university.edu',
    @mobilePhone = '9876543210',
    @enrollDate = '2017-08-25',
    @DOB = '1992-04-15',
    @homeAt = '123 Cedar St, City, Country';

-- Insert Instructor 5
EXEC InsertInstructor 
    @fName = 'James',
    @lName = 'Taylor',
    @Gender = 'M',
    @ssn = 584739210,
    @mail = 'james.taylor@university.edu',
    @mobilePhone = '8765432109',
    @enrollDate = '2022-05-18',
    @DOB = '1988-09-30',
    @homeAt = '987 Birch St, City, Country';

GO
-- Declare variable to capture new IDs
DECLARE @newDepartmentID INT;

-- Insert Department 1: Computer Science
EXEC InsertDepartment 
    @DEPTNAME = 'Computer Science', 
    @DEPTMANAGER = 1, 
    @newDepartmentID = @newDepartmentID OUTPUT;


-- Insert Department 2: Mathematics
EXEC InsertDepartment 
    @DEPTNAME = 'Mathematics', 
    @DEPTMANAGER = 2, 
    @newDepartmentID = @newDepartmentID OUTPUT;

-- Insert Department 3: SD
EXEC InsertDepartment 
    @DEPTNAME = 'System Development', 
    @DEPTMANAGER = 3, 
    @newDepartmentID = @newDepartmentID OUTPUT;

-- Insert Department 4: Data Science
EXEC InsertDepartment 
    @DEPTNAME = 'Data Science', 
    @DEPTMANAGER = 4, 
    @newDepartmentID = @newDepartmentID OUTPUT;
-- Insert Department 5: Open Source
EXEC InsertDepartment 
    @DEPTNAME = 'Open Source', 
    @DEPTMANAGER = 5, 
    @newDepartmentID = @newDepartmentID OUTPUT;

GO
-- Declare a new variable to capture track IDs (optional)
DECLARE @newTrackID INT;

-- Insert Track 1: Software Engineering (Computer Science Department)
EXEC InsertTrack 
    @Name = 'Software Engineering', 
    @DepartmentID = 1, 
    @newTrackID = @newTrackID OUTPUT;

-- Insert Track 2: Artificial Intelligence (Computer Science Department)
EXEC InsertTrack 
    @Name = 'Artificial Intelligence', 
    @DepartmentID = 2, 
    @newTrackID = @newTrackID OUTPUT;


-- Insert Track 3: Pure Mathematics (Mathematics Department)
EXEC InsertTrack 
    @Name = 'Pure Mathematics', 
    @DepartmentID = 3, 
    @newTrackID = @newTrackID OUTPUT;

GO


    -- Insert Student 1: Software Engineering Track
EXEC InsertStudent 
    @firstName = 'Michael',
    @lastName = 'Brown',
    @gender = 'M',
    @SSN = '111-22-3333',
    @Email = 'michael.brown@university.edu',
    @phone = '1112223333',
    @DateOfBirth = '2000-01-01',
    @address = '101 Pine St, City, Country',
    @trackID = 1, -- Software Engineering Track
    @departmentID = 1; -- Computer Science Department

-- Insert Student 2: Artificial Intelligence Track
EXEC InsertStudent 
    @firstName = 'Emily',
    @lastName = 'Davis',
    @gender = 'F',
    @SSN = '222-33-4444',
    @Email = 'emily.davis@university.edu',
    @phone = '2223334444',
    @DateOfBirth = '2001-02-02',
    @address = '202 Maple St, City, Country',
    @trackID = 2, -- Artificial Intelligence Track
    @departmentID = 1; -- Computer Science Department

-- Insert Student 3: Pure Mathematics Track
EXEC InsertStudent 
    @firstName = 'David',
    @lastName = 'Wilson',
    @gender = 'M',
    @SSN = '333-44-5555',
    @Email = 'david.wilson@university.edu',
    @phone = '3334445555',
    @DateOfBirth = '2002-03-03',
    @address = '303 Cedar St, City, Country',
    @trackID = 3, -- Pure Mathematics Track
    @departmentID = 2; -- Mathematics Department

-- Insert Student 4: Software Engineering Track
EXEC InsertStudent 
    @firstName = 'Olivia',
    @lastName = 'Taylor',
    @gender = 'F',
    @SSN = '444-55-6666',
    @Email = 'olivia.taylor@university.edu',
    @phone = '4445556666',
    @DateOfBirth = '2003-04-04',
    @address = '404 Birch St, City, Country',
    @trackID = 1, -- Software Engineering Track
    @departmentID = 1; -- Computer Science Department

-- Insert Student 5: Artificial Intelligence Track
EXEC InsertStudent 
    @firstName = 'James',
    @lastName = 'Anderson',
    @gender = 'M',
    @SSN = '555-66-7777',
    @Email = 'james.anderson@university.edu',
    @phone = '5556667777',
    @DateOfBirth = '2004-05-05',
    @address = '505 Oak St, City, Country',
    @trackID = 2, -- Artificial Intelligence Track
    @departmentID = 1; -- Computer Science Department
GO

    -- Insert Course 1: Artificial Intelligence (AI)
EXEC InsertCourse @CourseName = 'Artificial Intelligence';

-- Insert Course 2: Data Structures and Algorithms
EXEC InsertCourse @CourseName = 'Data Structures and Algorithms';

-- Insert Course 3: Networking
EXEC InsertCourse @CourseName = 'Networking';

-- Insert Course 4: Operating Systems
EXEC InsertCourse @CourseName = 'Operating Systems';

-- Insert Course 5: Databases
EXEC InsertCourse @CourseName = 'Databases';

-- Insert Course 6: Object-Oriented Programming with C#
EXEC InsertCourse @CourseName = 'Object-Oriented Programming with C#';

-- Insert Course 7: JavaScript Programming
EXEC InsertCourse @CourseName = 'JavaScript Programming';

GO

-- Enroll Student 1 (Software Engineering) in Course 2 (Data Structures and Algorithms)
EXEC InsertStudentInCourse @courseID = 2, @studentID = 1, @startDate = '2023-09-01';

-- Enroll Student 1 (Software Engineering) in Course 4 (Operating Systems)
EXEC InsertStudentInCourse @courseID = 4, @studentID = 1, @startDate = '2023-09-01';

-- Enroll Student 2 (Artificial Intelligence) in Course 1 (Artificial Intelligence)
EXEC InsertStudentInCourse @courseID = 1, @studentID = 2, @startDate = '2023-09-01';

-- Enroll Student 2 (Artificial Intelligence) in Course 5 (Databases)
EXEC InsertStudentInCourse @courseID = 5, @studentID = 2, @startDate = '2023-09-01';

-- Enroll Student 3 (Pure Mathematics) in Course 2 (Data Structures and Algorithms)
EXEC InsertStudentInCourse @courseID = 2, @studentID = 3, @startDate = '2023-09-01';

-- Enroll Student 4 (Software Engineering) in Course 6 (OOP with C#)
EXEC InsertStudentInCourse @courseID = 6, @studentID = 4, @startDate = '2023-09-01';

-- Enroll Student 5 (Artificial Intelligence) in Course 7 (JavaScript Programming)
EXEC InsertStudentInCourse @courseID = 7, @studentID = 5, @startDate = '2023-09-01';