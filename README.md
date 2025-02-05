# Student Examination System - Database

This repository contains the database schema and related scripts for a **Student Examination System**. The system is designed to manage and track various entities involved in an academic examination process, including branches, departments, tracks, courses, students, instructors, exams, and submissions.

## Initial Schema Overview

The database schema consists of the following main entities and relationships:

### Core Entities:
1. **Branch**  
   - Represents different institutional branches.  
   - Fields: `ID`, `Name`, `Location`, `phone`, `establishmentDate`, `ManagerID`, `isDeleted`

2. **Department**  
   - Tracks academic departments.  
   - Fields: `ID`, `Name`, `creationDate`, `isDeleted`

3. **Track**  
   - Represents different academic tracks under departments.  
   - Fields: `ID`, `Name`, `departmentID`, `creationDate`, `isDeleted`

4. **Branch_Department_Track**  
   - Links branches, departments, and tracks.  
   - Fields: `branchID`, `trackID`, `departmentID`, `creationDate`, `departmentManagerID`, `trackManagerID`, `DepartementManagerJoinDate`, `TrackManagerJoinDate`, `isDeleted`

5. **Instructor**  
   - Manages instructor details.  
   - Fields: `ID`, `firstName`, `lastName`, `gender`, `SSN`, `enrollmentDate`, `email`, `phone`, `DateOfBirth`, `address`, `isDeleted`

6. **Student**  
   - Captures student details and their association with tracks, departments, and branches.  
   - Fields: `ID`, `firstName`, `lastName`, `gender`, `SSN`, `enrollmentDate`, `email`, `phone`, `DateOfBirth`, `address`, `trackID`, `branchID`, `departmentID`, `isDeleted`

7. **Course**  
   - Stores details about the courses offered.  
   - Fields: `ID`, `Name`, `creationDate`, `isDeleted`

8. **QuestionBank**  
   - Maintains a collection of questions for exams.  
   - Fields: `ID`, `type`, `correctChoice`, `instructorID`, `courseID`, `insertionDate`, `questionText`, `isDeleted`

9. **ExamModel**  
   - Defines exams, including scheduling details.  
   - Fields: `ID`, `date`, `startTime`, `endTime`, `CourseID`, `instructorID`, `creationDate`, `isDeleted`

10. **StudentSubmit**  
    - Tracks student exam submissions.  
    - Fields: `ID`, `studentID`, `examModelID`, `submitDate`, `isDeleted`

### Relationships and Many-to-Many Mapping:

1. **Course_Topic**  
   - Lists topics under a course.  
   - Fields: `courseID`, `topic`, `creationDate`, `isDeleted`

2. **Course_Field**  
   - Tracks fields related to a course.  
   - Fields: `courseID`, `field`, `creationDate`, `isDeleted`

3. **QuestionBank_Choice**  
   - Stores choices for questions in the question bank.  
   - Fields: `questionID`, `Choice`, `isDeleted`

4. **ExamModel_Question**  
   - Links questions to specific exams.  
   - Fields: `examModelID`, `questionID`, `mark`, `correctChoice`

5. **StudentSubmit_Answer**  
   - Captures student answers for questions.  
   - Fields: `StudentSubmitID`, `examModelID`, `questionID`, `studentAnswer`, `isDeleted`

6. **Course_Student_Instructor**  
   - Tracks courses with students and their assigned instructors.  
   - Fields: `courseID`, `studentID`, `instructorID`, `startDate`

7. **Course_Instructor**  
   - Maps instructors to courses they teach.  
   - Fields: `courseID`, `instructorID`

8. **Track_Course**  
   - Links academic tracks to courses.  
   - Fields: `trackID`, `courseID`

9. **Department_Instructor**  
   - Associates instructors with departments.  
   - Fields: `departmentID`, `instructorID`, `joinDate`
