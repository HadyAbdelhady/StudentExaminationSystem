
# Student Examination System - Database

This repository contains the database schema and related scripts for a **Student Examination System**. The system is designed to manage and track various entities involved in an academic examination process, including departments, courses, students, instructors, exams, and submissions.

## Initial Schema Overview

The database schema consists of the following main entities and relationships:

### Core Entities:
1. **Department**  
   - Tracks academic departments, each with a unique ID, name, and manager.
   - Fields: `ID`, `Name`, `ManagerID`

2. **Track**  
   - Represents different academic tracks under departments.
   - Fields: `ID`, `Name`, `departmentID`

3. **Instructor**  
   - Manages instructor details such as personal information and contact.
   - Fields: `ID`, `firstName`, `lastName`, `gender`, `SSN`, `enrollmentDate`, `email`, `phone`, `DateOfBirth`, `address`

4. **Student**  
   - Captures student details and their association with tracks and departments.
   - Fields: `ID`, `firstName`, `lastName`, `gender`, `SSN`, `enrollmentDate`, `email`, `phone`, `DateOfBirth`, `address`, `trackID`, `departmentID`

5. **Course**  
   - Stores details about the courses offered in the system.
   - Fields: `ID`, `Name`

6. **QuestionBank**  
   - Maintains a collection of questions for exams, including type, correct choice, and marks.
   - Fields: `ID`, `type`, `correctChoice`, `mark`, `instructorID`, `courseID`, `lastEditDate`

7. **ExamModel**  
   - Defines exams, including scheduling and marking details.
   - Fields: `ID`, `date`, `startTime`, `endTime`, `TotalMark`, `CourseID`, `instructorID`, `creationDate`

8. **StudentSubmit**  
   - Tracks student exam submissions and grades.
   - Fields: `ID`, `grade`, `studentID`, `examModelID`

### Relationships and Many-to-Many Mapping:
1. **ExamModel_StudentSubmit_Student**  
   - Tracks student submissions for specific exams.
   - Fields: `examModelID`, `studentSubmitID`, `studentID`, `submitDate`

2. **Department_Instructor**  
   - Associates instructors with departments.
   - Fields: `departmentID`, `instructorID`, `joinDate`

3. **Track_Course**  
   - Links academic tracks to courses.
   - Fields: `trackID`, `courseID`

4. **Course_Topic**  
   - Lists topics under a course.
   - Fields: `courseID`, `topic`

5. **Course_Field**  
   - Tracks fields related to a course.
   - Fields: `courseID`, `field`

6. **Course_Instructor**  
   - Maps instructors to courses they teach.
   - Fields: `courseID`, `instructorID`

7. **Course_Student**  
   - Links students to their enrolled courses.
   - Fields: `courseID`, `studentID`, `startDate`

8. **QuestionBank_Choice**  
   - Stores choices for questions in the question bank.
   - Fields: `questionID`, `Choice`

9. **StudentSubmit_Answer**  
   - Captures student answers for questions.
   - Fields: `StudentSubmitID`, `studentAnswer`

10. **ExamModel_Question**  
    - Links questions to specific exams.
    - Fields: `examModelID`, `questionID`, `correctChoice`
