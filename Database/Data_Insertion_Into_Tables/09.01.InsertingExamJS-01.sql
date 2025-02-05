BEGIN TRY
    BEGIN TRANSACTION
        DECLARE @newExamModelID INT;
        EXEC InsertExamModel
            @date = '2025-02-15',
            @startTime = '10:30:00',
            @endTime = '11:30:00',
            @CourseID = 1,
            @instructorID = 1,
            @examModelID  = @newExamModelID OUTPUT ;

        -- Inserting 10 MCQ Question 
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 1,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 2,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 3,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 4,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 5,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 6,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 7,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 8,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 9,
        @mark = 1;
        EXEC InsertIntoExamModel_Question
        @examModelID = 1,
        @questionId = 10,
        @mark = 1;

        -- Inserting 5 true or false Question 2 marks each
            EXEC InsertIntoExamModel_Question
            @examModelID = 1,
            @questionId = 61,
            @mark = 2;
            EXEC InsertIntoExamModel_Question
            @examModelID = 1,
            @questionId = 62,
            @mark = 2;
            EXEC InsertIntoExamModel_Question
            @examModelID = 1,
            @questionId = 63,
            @mark = 2;
            EXEC InsertIntoExamModel_Question
            @examModelID = 1,
            @questionId = 64,
            @mark = 2;
            EXEC InsertIntoExamModel_Question
            @examModelID = 1,
            @questionId = 65,
            @mark = 2;
    COMMIT;
END TRY
BEGIN CATCH
    if @@ROWCOUNT > 0
        ROLLBACK;
END CATCH