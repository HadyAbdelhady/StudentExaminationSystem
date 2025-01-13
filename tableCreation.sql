-- Table: Department
CREATE TABLE Department (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    ManagerID INT,
    creationDate DATETIME DEFAULT GETDATE()
);

-- Table: Track
CREATE TABLE Track (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    departmentID INT NOT NULL,
    FOREIGN KEY (departmentID) REFERENCES Department(ID)
);

-- Table: Instructor
CREATE TABLE Instructor (
    ID INT PRIMARY KEY IDENTITY(1,1),
    firstName NVARCHAR(100) NOT NULL,
    lastName NVARCHAR(100) NOT NULL,
    gender NVARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    SSN NVARCHAR(20) UNIQUE NOT NULL,
    enrollmentDate DATETIME NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(15) NOT NULL,
    DateOfBirth DATE NOT NULL,
    address NVARCHAR(200) NOT NULL
);

-- Table: Student
CREATE TABLE Student (
    ID INT PRIMARY KEY IDENTITY(1,1),
    firstName NVARCHAR(100) NOT NULL,
    lastName NVARCHAR(100) NOT NULL,
    gender NVARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    SSN NVARCHAR(20) UNIQUE NOT NULL,
    enrollmentDate DATETIME NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(15) NOT NULL,
    DateOfBirth DATE NOT NULL,
    address NVARCHAR(200) NOT NULL,
    trackID INT,
    departmentID INT NOT NULL,
    FOREIGN KEY (trackID) REFERENCES Track(ID),
    FOREIGN KEY (departmentID) REFERENCES Department(ID)
);

-- Table: Course
CREATE TABLE Course (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL
);

-- Table: QuestionBank
CREATE TABLE QuestionBank (
    ID INT PRIMARY KEY IDENTITY(1,1),
    type NVARCHAR(50) NOT NULL,
    correctChoice NVARCHAR(200) NOT NULL,
    mark INT NOT NULL,
    instructorID INT NOT NULL,
    courseID INT NOT NULL,
    lastEditDate DATETIME DEFAULT GETDATE(),
    questionText NVARCHAR(200) NOT NULL,
    FOREIGN KEY (instructorID) REFERENCES Instructor(ID),
    FOREIGN KEY (courseID) REFERENCES Course(ID)
);

-- Table: ExamModel
CREATE TABLE ExamModel (
    ID INT PRIMARY KEY IDENTITY(1,1),
    date DATE NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    TotalMark INT NOT NULL,
    CourseID INT NOT NULL,
    instructorID INT NOT NULL,
    creationDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CourseID) REFERENCES Course(ID),
    FOREIGN KEY (instructorID) REFERENCES Instructor(ID)
);

-- Table: StudentSubmit
CREATE TABLE StudentSubmit (
    ID INT PRIMARY KEY IDENTITY(1,1),
    grade INT NOT NULL,
    studentID INT NOT NULL,
    examModelID INT NOT NULL,
    FOREIGN KEY (studentID) REFERENCES Student(ID),
    FOREIGN KEY (examModelID) REFERENCES ExamModel(ID)
);

-- Junction Tables
CREATE TABLE Course_Topic (
    courseID INT NOT NULL,
    topic NVARCHAR(200) NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(ID),
    PRIMARY KEY (courseID, topic)
);

CREATE TABLE Course_Field (
    courseID INT NOT NULL,
    field NVARCHAR(200) NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(ID),
    PRIMARY KEY (courseID, field)
);

CREATE TABLE QuestionBank_Choice (
    questionID INT NOT NULL,
    Choice NVARCHAR(200) NOT NULL,
    FOREIGN KEY (questionID) REFERENCES QuestionBank(ID),
    PRIMARY KEY (questionID, Choice)
);

CREATE TABLE ExamModel_Question (
    examModelID INT NOT NULL,
    questionID INT NOT NULL,
    correctChoice NVARCHAR(200) NOT NULL,
    FOREIGN KEY (examModelID) REFERENCES ExamModel(ID),
    FOREIGN KEY (questionID) REFERENCES QuestionBank(ID),
    PRIMARY KEY (examModelID, questionID)
);

CREATE TABLE StudentSubmit_Answer (
    StudentSubmitID INT NOT NULL,
    studentAnswer NVARCHAR(200) NOT NULL,
    FOREIGN KEY (StudentSubmitID) REFERENCES StudentSubmit(ID)
);

CREATE TABLE ExamModel_StudentSubmit_Student (
    examModelID INT NOT NULL,
    studentSubmitID INT NOT NULL,
    studentID INT NOT NULL,
    submitDate DATETIME NOT NULL,
    FOREIGN KEY (examModelID) REFERENCES ExamModel(ID),
    FOREIGN KEY (studentSubmitID) REFERENCES StudentSubmit(ID),
    FOREIGN KEY (studentID) REFERENCES Student(ID),
    PRIMARY KEY (examModelID, studentSubmitID, studentID)
);

CREATE TABLE Course_Student (
    courseID INT NOT NULL,
    studentID INT NOT NULL,
    startDate DATETIME NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(ID),
    FOREIGN KEY (studentID) REFERENCES Student(ID),
    PRIMARY KEY (courseID, studentID)
);

CREATE TABLE Course_Instructor (
    courseID INT NOT NULL,
    instructorID INT NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(ID),
    FOREIGN KEY (instructorID) REFERENCES Instructor(ID),
    PRIMARY KEY (courseID, instructorID)
);

CREATE TABLE Track_Course (
    trackID INT NOT NULL,
    courseID INT NOT NULL,
    FOREIGN KEY (trackID) REFERENCES Track(ID),
    FOREIGN KEY (courseID) REFERENCES Course(ID),
    PRIMARY KEY (trackID, courseID)
);

CREATE TABLE Department_Instructor (
    departmentID INT NOT NULL,
    instructorID INT NOT NULL,
    joinDate DATETIME NOT NULL,
    FOREIGN KEY (departmentID) REFERENCES Department(ID),
    FOREIGN KEY (instructorID) REFERENCES Instructor(ID),
    PRIMARY KEY (departmentID, instructorID)
);
