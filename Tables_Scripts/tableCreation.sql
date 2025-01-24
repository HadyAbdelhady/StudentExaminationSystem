-- Table: Instructor
CREATE TABLE Instructor (
    ID INT PRIMARY KEY IDENTITY(1,1),
    firstName NVARCHAR(20) NOT NULL,
    lastName NVARCHAR(20) NOT NULL,
    gender NVARCHAR(1) CHECK (gender IN ('M', 'F')),
    SSN NVARCHAR(20) UNIQUE NOT NULL,
    enrollmentDate DATETIME NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(15) NOT NULL unique,
    DateOfBirth DATE NOT NULL,
    address NVARCHAR(200) NOT NULL,
	isDeleted BIT  DEFAULT 0
);

-- Branch table 
Create Table Branch
(
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(200) NOT NULL unique,
    Location NVARCHAR(500) NOT NULL,
    phone NVARCHAR(20) NOT NULL unique,
    establishmentDate DateTime,
    ManagerID INT NOT NULL unique,
    isDeleted BIT DEFAULT 0 ,
    FOREIGN KEY (ManagerID) REFERENCES Instructor(ID),
);

-- Table: Department
CREATE TABLE Department (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL unique,
    ManagerID INT NOT NULL unique,
    creationDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ManagerID) REFERENCES Instructor(ID),
	isDeleted BIT  DEFAULT 0 
);

-- Table: Track
CREATE TABLE Track (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL unique,
	isDeleted BIT  DEFAULT 0 ,
    departmentID INT NOT NULL,
    FOREIGN KEY (departmentID) REFERENCES Department(ID),
    creationDate DATETIME NOT NULL
);

-- Table: Student
CREATE TABLE Student (
    ID INT PRIMARY KEY IDENTITY(1,1),
    firstName NVARCHAR(20) NOT NULL,
    lastName NVARCHAR(20) NOT NULL,
    gender NVARCHAR(10) CHECK (gender IN ('M', 'F')),
    SSN NVARCHAR(20) UNIQUE NOT NULL,
    enrollmentDate DATETIME NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(15) NOT NULL unique,
    DateOfBirth DATE NOT NULL,
    address NVARCHAR(200) NOT NULL,
    trackID INT NOT NULL,
    branchID INT NOT NULL,
    departmentID INT NOT NULL,
    FOREIGN KEY (trackID) REFERENCES Track(ID),
    FOREIGN KEY (departmentID) REFERENCES Department(ID),
    FOREIGN KEY (branchID) REFERENCES Branch(ID),
	isDeleted BIT  DEFAULT 0 
);

-- Table: Course
CREATE TABLE Course (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL unique,
	isDeleted BIT  DEFAULT 0,
    creationDate DATETIME DEFAULT GETDATE(),
);

-- Table: QuestionBank
CREATE TABLE QuestionBank (
    ID INT PRIMARY KEY IDENTITY(1,1),
    type NVARCHAR(50) NOT NULL,
    correctChoice NVARCHAR(200) NOT NULL,
    instructorID INT NOT NULL,
    courseID INT NOT NULL,
    insertionDate DATETIME DEFAULT GETDATE(),
    questionText NVARCHAR(200) NOT NULL,
    FOREIGN KEY (instructorID) REFERENCES Instructor(ID),
    FOREIGN KEY (courseID) REFERENCES Course(ID),
	isDeleted BIT DEFAULT 0 
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
    studentID INT NOT NULL,
    examModelID INT NOT NULL,
    FOREIGN KEY (studentID) REFERENCES Student(ID),
    FOREIGN KEY (examModelID) REFERENCES ExamModel(ID),
    submitDate DATETIME DEFAULT GETDATE()
);

-- Junction Tables
CREATE TABLE Course_Topic (
    courseID INT NOT NULL,
    topic NVARCHAR(200) NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(ID),
    PRIMARY KEY (courseID, topic),
    creationDate DATETIME DEFAULT GETDATE(),
    isDeleted BIT DEFAULT 0
);

CREATE TABLE Course_Field (
    courseID INT NOT NULL,
    field NVARCHAR(200) NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(ID),
    PRIMARY KEY (courseID, field),
    creationDate DATETIME DEFAULT GETDATE(),
    isDeleted BIT DEFAULT 0
);

CREATE TABLE QuestionBank_Choice (
    questionID INT NOT NULL,
    Choice NVARCHAR(200) NOT NULL,
    FOREIGN KEY (questionID) REFERENCES QuestionBank(ID),
    PRIMARY KEY (questionID, Choice)
);

-- ExamModel_Question table
CREATE TABLE ExamModel_Question (
    examModelID INT NOT NULL,
    questionID INT NOT NULL,
    mark INT NOT NULL,
    correctChoice NVARCHAR(200) NOT NULL,
    FOREIGN KEY (examModelID) REFERENCES ExamModel(ID),
    FOREIGN KEY (questionID) REFERENCES QuestionBank(ID),
    PRIMARY KEY (examModelID, questionID)
);

-- StudentSubmit_Answer table
CREATE TABLE StudentSubmit_Answer (
    StudentSubmitID INT NOT NULL,
    examModelID INT NOT NULL, 
    questionID INT NOT NULL,
    studentAnswer NVARCHAR(200) ,
    FOREIGN KEY (StudentSubmitID) REFERENCES StudentSubmit(ID),
    FOREIGN KEY (examModelID, questionID) REFERENCES ExamModel_Question(examModelID, questionID),
	PRIMARY KEY (StudentSubmitID,studentAnswer)
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

CREATE TABLE Course_Student_Instructor (
    courseID INT NOT NULL,
    studentID INT NOT NULL,
    instructorID INT NOT NULL,
    startDate DATETIME NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(ID),
    FOREIGN KEY (studentID) REFERENCES Student(ID),
    FOREIGN KEY (instructorID) REFERENCES Instructor(ID),
    PRIMARY KEY (courseID, studentID, instructorID)
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

CREATE TABLE Branch_Track (
    branchID INT NOT NULL,
    trackID INT NOT NULL,
    creationDate DATETIME NOT NULL,
    isDeleted BIT DEFAULT 0,
    FOREIGN KEY (branchID) REFERENCES Branch(ID),
    FOREIGN KEY (trackID) REFERENCES Track(ID),
    PRIMARY KEY (trackID, branchID)
)