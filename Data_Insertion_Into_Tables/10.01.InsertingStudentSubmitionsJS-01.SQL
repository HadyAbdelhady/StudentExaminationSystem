-- Student One
        DECLARE @newStudentSubmitID INT;
        EXEC insertStudentSubmission  @stdID = 1, @examMdlID = 1,  @SubmissionID = @newStudentSubmitID OUTPUT;
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 1,
            @studentAnswer = 'let';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 2,
            @studentAnswer = 'typeof';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 3,
            @studentAnswer = 'push()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 4,
            @studentAnswer = 'return';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 5,
            @studentAnswer = 'Object.keys()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 6,
            @studentAnswer = 'then()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 7,
            @studentAnswer = 'getElementById()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 8,
            @studentAnswer = 'addEventListener()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 9,
            @studentAnswer = 'Global scope';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 10,
            @studentAnswer = 'constructor';

        -- Insertingg TrueOrFalse Answers
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 61,
            @studentAnswer = 'True';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 62,
            @studentAnswer = 'False';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 63,
            @studentAnswer = 'False';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 64,
            @studentAnswer = 'True';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 65,
            @studentAnswer = 'False';
GO

-- Student two
        DECLARE @newStudentSubmitID INT;
        EXEC insertStudentSubmission  @stdID = 2, @examMdlID = 1,  @SubmissionID = @newStudentSubmitID OUTPUT;
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 1,
            @studentAnswer = 'let';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 2,
            @studentAnswer = 'typeof';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 3,
            @studentAnswer = 'push()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 4,
            @studentAnswer = 'return';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 5,
            @studentAnswer = 'Object.properties()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 6,
            @studentAnswer = 'then()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 7,
            @studentAnswer = 'getElementById()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 8,
            @studentAnswer = 'attachEvent()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 9,
            @studentAnswer = 'Global scope';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 10,
            @studentAnswer = 'constructor';

        -- Insertingg TrueOrFalse Answers
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 61,
            @studentAnswer = 'True';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 62,
            @studentAnswer = 'True';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 63,
            @studentAnswer = 'False';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 64,
            @studentAnswer = 'True';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 65,
            @studentAnswer = 'False';
GO

-- Student three
        DECLARE @newStudentSubmitID INT;
        EXEC insertStudentSubmission  @stdID = 3, @examMdlID = 1,  @SubmissionID = @newStudentSubmitID OUTPUT;
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 1,
            @studentAnswer = 'let';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 2,
            @studentAnswer = 'typeof';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 3,
            @studentAnswer = 'push()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 4,
            @studentAnswer = 'return';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 5,
            @studentAnswer = 'Object.properties()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 6,
            @studentAnswer = 'then()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 7,
            @studentAnswer = 'getElementById()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 8,
            @studentAnswer = 'addEventListener()';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 9,
            @studentAnswer = 'Global scope';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 10,
            @studentAnswer = 'constructor';

        -- Insertingg TrueOrFalse Answers
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 61,
            @studentAnswer = 'True';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 62,
            @studentAnswer = 'True';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 63,
            @studentAnswer = 'False';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 64,
            @studentAnswer = 'True';
        -- Inserting Answers
        EXEC InsertAnswerForStudentSubmition 
            @StudentSubmitID = @newStudentSubmitID,
            @examModelID = 1,
            @questionID = 65,
            @studentAnswer = 'True';
GO