BEGIN TRY
    BEGIN TRANSACTION;
    DECLARE @InstructorID INT = 1;  -- Set Instructor ID to 1
    DECLARE @CourseID INT = 2;      -- Set Course ID to 2
    DECLARE @Type NVARCHAR(50) = 'TrueOrFalse';
    DECLARE @QuestionID INT;

    -- Question 1: C# Basics
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'C# is a type-safe language.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 2: C# Basics
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'False',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'C# was developed by Apple.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 3: C# Data Types
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'The "int" data type in C# is used to store whole numbers.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 4: C# Exception Handling
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'The "try" block in C# is used to handle exceptions.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 5: C# Object-Oriented Programming
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'False',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'C# does not support inheritance.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 6: C# Collections
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'A List in C# can store multiple elements of the same type.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 7: C# Syntax
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'False',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'In C#, semicolons are not required at the end of statements.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 8: C# Properties
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Properties in C# provide a way to access and update private fields.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 9: C# Control Structures
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'False',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'The "switch" statement in C# can only be used with numerical values.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 10: C# Delegates
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Delegates in C# are used to pass methods as arguments to other methods.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 11: C# Events
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Events in C# are based on delegates.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 12: C# LINQ
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'False',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'LINQ in C# does not support filtering operations.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 13: C# File I/O
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'C# provides classes for reading and writing files.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 14: C# Asynchronous Programming
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'The "async" and "await" keywords in C# are used for asynchronous programming.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    -- Question 15: C# Namespaces
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'True',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Namespaces in C# are used to organize code and avoid naming conflicts.',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'True';
    EXEC insertQuestionBankChoice @QuestionID, 'False';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
END CATCH;

GO

BEGIN TRY
    BEGIN TRANSACTION;
    DECLARE @InstructorID INT = 1;  -- Set Instructor ID to 1
    DECLARE @CourseID INT = 2;      -- Set Course ID to 2
    DECLARE @Type NVARCHAR(50) = 'Multiple Choice';
    DECLARE @QuestionID INT;

    -- Question 1: C# Basics
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Microsoft',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Who developed the C# programming language?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'Microsoft';
    EXEC insertQuestionBankChoice @QuestionID, 'Apple';
    EXEC insertQuestionBankChoice @QuestionID, 'Google';
    EXEC insertQuestionBankChoice @QuestionID, 'IBM';

    -- Question 2: C# Data Types
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'int',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which data type is used to store whole numbers in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'int';
    EXEC insertQuestionBankChoice @QuestionID, 'float';
    EXEC insertQuestionBankChoice @QuestionID, 'double';
    EXEC insertQuestionBankChoice @QuestionID, 'char';

    -- Question 3: C# Loops
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'for',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which loop in C# is used when the number of iterations is known beforehand?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'for';
    EXEC insertQuestionBankChoice @QuestionID, 'while';
    EXEC insertQuestionBankChoice @QuestionID, 'do-while';
    EXEC insertQuestionBankChoice @QuestionID, 'foreach';

    -- Question 4: C# Exception Handling
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'try-catch',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which block is used to handle exceptions in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'try-catch';
    EXEC insertQuestionBankChoice @QuestionID, 'if-else';
    EXEC insertQuestionBankChoice @QuestionID, 'switch-case';
    EXEC insertQuestionBankChoice @QuestionID, 'for-each';

    -- Question 5: C# Methods
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'void',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to declare a method that does not return a value in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'void';
    EXEC insertQuestionBankChoice @QuestionID, 'null';
    EXEC insertQuestionBankChoice @QuestionID, 'return';
    EXEC insertQuestionBankChoice @QuestionID, 'break';

    -- Question 6: C# Inheritance
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'base',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to access the base class constructor in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'base';
    EXEC insertQuestionBankChoice @QuestionID, 'this';
    EXEC insertQuestionBankChoice @QuestionID, 'super';
    EXEC insertQuestionBankChoice @QuestionID, 'parent';

    -- Question 7: C# Interfaces
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'interface',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to define an interface in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'interface';
    EXEC insertQuestionBankChoice @QuestionID, 'class';
    EXEC insertQuestionBankChoice @QuestionID, 'struct';
    EXEC insertQuestionBankChoice @QuestionID, 'enum';

    -- Question 8: C# Properties
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'get and set',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keywords are used to define a property in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'get and set';
    EXEC insertQuestionBankChoice @QuestionID, 'read and write';
    EXEC insertQuestionBankChoice @QuestionID, 'define and assign';
    EXEC insertQuestionBankChoice @QuestionID, 'read and assign';

    -- Question 9: C# Events
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'event',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to declare an event in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'event';
    EXEC insertQuestionBankChoice @QuestionID, 'delegate';
    EXEC insertQuestionBankChoice @QuestionID, 'method';
    EXEC insertQuestionBankChoice @QuestionID, 'property';

    -- Question 10: C# Access Modifiers
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'public, private, protected',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What are the access modifiers available in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'public, private, protected';
    EXEC insertQuestionBankChoice @QuestionID, 'public, internal, abstract';
    EXEC insertQuestionBankChoice @QuestionID, 'static, abstract, sealed';
    EXEC insertQuestionBankChoice @QuestionID, 'public, static, virtual';

    -- Question 11: C# Polymorphism
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'override',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to override a method in the derived class in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'override';
    EXEC insertQuestionBankChoice @QuestionID, 'virtual';
    EXEC insertQuestionBankChoice @QuestionID, 'static';
    EXEC insertQuestionBankChoice @QuestionID, 'abstract';

    -- Question 12: C# Namespaces
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'using',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to include namespaces in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'using';
    EXEC insertQuestionBankChoice @QuestionID, 'include';
    EXEC insertQuestionBankChoice @QuestionID, 'import';
    EXEC insertQuestionBankChoice @QuestionID, 'namespace';

    -- Question 13: C# Attributes
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'attribute',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to define an attribute in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'attribute';
    EXEC insertQuestionBankChoice @QuestionID, 'metadata';
    EXEC insertQuestionBankChoice @QuestionID, 'decorator';
    EXEC insertQuestionBankChoice @QuestionID, 'annotation';

    -- Question 14: C# LINQ
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Language Integrated Query',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What does LINQ stand for in C#?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, 'Language Integrated Query';
    EXEC insertQuestionBankChoice @QuestionID, 'Language Interactive Query';
    EXEC insertQuestionBankChoice @QuestionID, 'Language Inquisitive Query';
    EXEC insertQuestionBankChoice @QuestionID, 'Language Inductive Query';

    -- Question 14: C# LINQ
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = '[Flags]',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'In c#, what is the annotation used to make the enum allow combinations?',
        @QuestionID = @QuestionID OUTPUT;

    EXEC insertQuestionBankChoice @QuestionID, '[Flags]';
    EXEC insertQuestionBankChoice @QuestionID, '[NotMapped]';
    EXEC insertQuestionBankChoice @QuestionID, '[Flag]';
    EXEC insertQuestionBankChoice @QuestionID, '[Smart Enum]';
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
END CATCH;

GO