CREATE INDEX idx_branch_name ON Branch(Name);
CREATE INDEX idx_branch_manager ON Branch(ManagerID);

CREATE INDEX idx_department_name ON Department(Name);

CREATE INDEX idx_track_name ON Track(Name);
CREATE INDEX idx_track_department ON Track(departmentID);

CREATE INDEX idx_instructor_ssn ON Instructor(SSN);
CREATE INDEX idx_instructor_email ON Instructor(email);
CREATE INDEX idx_instructor_phone ON Instructor(phone);

CREATE INDEX idx_student_ssn ON Student(SSN);
CREATE INDEX idx_student_email ON Student(email);
CREATE INDEX idx_student_phone ON Student(phone);
CREATE INDEX idx_student_track ON Student(trackID);
CREATE INDEX idx_student_department ON Student(departmentID);

CREATE INDEX idx_course_name ON Course(Name);

CREATE INDEX idx_questionbank_instructor ON QuestionBank(instructorID);
CREATE INDEX idx_questionbank_course ON QuestionBank(courseID);

CREATE INDEX idx_exammodel_course ON ExamModel(CourseID);
CREATE INDEX idx_exammodel_instructor ON ExamModel(instructorID);

CREATE INDEX idx_studentsubmit_student ON StudentSubmit(studentID);
CREATE INDEX idx_studentsubmit_exam ON StudentSubmit(examModelID);

CREATE INDEX idx_course_student_instructor_course ON Course_Student_Instructor(courseID);
CREATE INDEX idx_course_student_instructor_student ON Course_Student_Instructor(studentID);
CREATE INDEX idx_course_student_instructor_instructor ON Course_Student_Instructor(instructorID);
