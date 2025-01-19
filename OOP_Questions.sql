DECLARE @QuestionID INT;

-- Question 1
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Option A', 
    @InstructorID = 1, 
    @CourseID = 101, 
    @QuestionText = 'What is the output of 2 + 2?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Option A';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Option B';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Option C';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Option D';

-- Question 2
EXEC InsertQuestion 
    @Type = 'True/False', 
    @CorrectChoice = 'True', 
    @InstructorID = 1, 
    @CourseID = 101, 
    @QuestionText = 'OOP supports code reuse.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 3
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Polymorphism', 
    @InstructorID = 1, 
    @CourseID = 101, 
    @QuestionText = 'Which of the following is a feature of OOP?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Abstraction';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Encapsulation';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the above';

-- Question 4
EXEC InsertQuestion 
    @Type = 'True/False', 
    @CorrectChoice = 'False', 
    @InstructorID = 1, 
    @CourseID = 101, 
    @QuestionText = 'Inheritance supports the concept of reusing code.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 5
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Function Overloading', 
    @InstructorID = 1, 
    @CourseID = 101, 
    @QuestionText = 'Which of the following is an example of polymorphism?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Inheritance';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Function Overloading';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Abstraction';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data Binding';

DECLARE @QuestionID INT;

-- Question 6
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'a',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Which header file is required in C++ to use OOP?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) OOP can be used without using any header file';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) stdlib.h';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) iostream.h';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) stdio.h';

-- Question 7
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'b',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Why is Java Partially OOP language?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) It allows code to be written outside classes';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) It supports usual declaration of primitive data types';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) It does not support pointers';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) It doesn’t support all types of inheritance';

-- Question 8
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'c',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Which among the following doesn’t come under OOP concept?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Data hiding';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Message passing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Platform independent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Data binding';

-- Question 9
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'b',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Which is the correct syntax of inheritance?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) class base_classname :access derived_classname{ /*define class body*/ };';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) class derived_classname : access base_classname{ /*define class body*/ };';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) class derived_classname : base_classname{ /*define class body*/ };';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) class base_classname : derived_classname{ /*define class body*/ };';

-- Question 10
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'a',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Which feature of OOP is indicated by the following code?\n\nclass student{ int marks; };\nclass topper:public student{ int age; topper(int age){ this.age=age; } };',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Encapsulation and Inheritance';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Inheritance and polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Inheritance';

DECLARE @QuestionID INT;

-- Question 11
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'b',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'The feature by which one object can interact with another object is _____________',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Message reading';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Message Passing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Data transfer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Data Binding';

-- Question 12
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'c',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Which among the following, for a pure OOP language, is true?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) The language should follow at least 1 feature of OOP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) The language must follow only 3 features of OOP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) The language must follow all the rules of OOP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) The language should follow 3 or more features of OOP';

-- Question 13
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'b',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'How many types of access specifiers are provided in OOP (C++)?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) 4';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) 3';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) 2';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) 1';

-- Question 14
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'd',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'In multilevel inheritance, which is the most significant feature of OOP used?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Code efficiency';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Code readability';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Flexibility';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Code reusability';

-- Question 15
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'a',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'What is encapsulation in OOP?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) It is a way of combining various data members and member functions that operate on those data members into a single unit';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) It is a way of combining various data members and member functions into a single unit which can operate on any data';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) It is a way of combining various data members into a single unit';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) It is a way of combining various member functions into a single unit';

DECLARE @QuestionID INT;

-- Question 16
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'b',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Which of the following is not true about polymorphism?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Helps in redefining the same functionality';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Increases overhead of function definition always';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) It is feature of OOP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Ease in readability of program';

-- Question 17
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'd',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Which constructor will be called from the object created in the below C++ code? ...',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Parameterized constructor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Default constructor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Run time error';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Compile time error';

-- Question 18
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'a',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'What is an abstraction in object-oriented programming?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Hiding the implementation and showing only the features';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Hiding the important data';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Hiding the implementation';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Showing the important data';

-- Question 19
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'b',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'Which among the following can show polymorphism?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Overloading &&';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Overloading <<';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Overloading ||';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Overloading +=';

-- Question 20
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'c',
    @InstructorID = 1,
    @CourseID = 101,
    @QuestionText = 'In which access should a constructor be defined, so that object of the class can be created in any function?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Any access specifier will work';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Private';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Public';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Protected';
