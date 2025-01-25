BEGIN TRY
    BEGIN TRANSACTION;

    -- Disable referential integrity
    EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

    -- Drop junction tables first (no dependencies on them)
    DROP TABLE IF EXISTS ExamModel_StudentSubmit_Student;
    DROP TABLE IF EXISTS StudentSubmit_Answer;
    DROP TABLE IF EXISTS ExamModel_Question;
    DROP TABLE IF EXISTS QuestionBank_Choice;
    DROP TABLE IF EXISTS Course_Topic;
    DROP TABLE IF EXISTS Course_Field;
    DROP TABLE IF EXISTS Course_Student_Instructor;
    DROP TABLE IF EXISTS Course_Instructor;
    DROP TABLE IF EXISTS Track_Course;
    DROP TABLE IF EXISTS Department_Instructor;

    -- Drop dependent tables
    DROP TABLE IF EXISTS StudentSubmit;
    DROP TABLE IF EXISTS ExamModel;
    DROP TABLE IF EXISTS QuestionBank;
    DROP TABLE IF EXISTS Student;
    DROP TABLE IF EXISTS Branch_Department_Track;
    DROP TABLE IF EXISTS Track;

    -- Drop main tables
    DROP TABLE IF EXISTS Branch;
    DROP TABLE IF EXISTS Course;
    DROP TABLE IF EXISTS Department;
    DROP TABLE IF EXISTS Instructor;

    -- Re-enable referential integrity
    EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"

    COMMIT TRANSACTION;
    PRINT 'All tables dropped successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred while dropping the tables.';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;