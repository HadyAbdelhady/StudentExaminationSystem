DECLARE @QuestionID INT;

-- Question 1
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Option A', 
    @InstructorID = 3, 
    @CourseID = 6, 
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
    @InstructorID = 3, 
    @CourseID = 6, 
    @QuestionText = 'OOP supports code reuse.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 3
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the above', 
    @InstructorID = 3, 
    @CourseID = 6, 
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
    @InstructorID = 3, 
    @CourseID = 6, 
    @QuestionText = 'Inheritance supports the concept of reusing code.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 5
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Function Overloading', 
    @InstructorID = 3, 
    @CourseID = 6, 
    @QuestionText = 'Which of the following is an example of polymorphism?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Inheritance';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Function Overloading';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Abstraction';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data Binding';

-- Question 6
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'OOP can be used without using any header file',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which header file is required in C++ to use OOP?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'OOP can be used without using any header file';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'stdlib.h';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'iostream.h';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'stdio.h';

-- Question 7
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'It supports usual declaration of primitive data types',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Why is Java Partially OOP language?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It allows code to be written outside classes';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It supports usual declaration of primitive data types';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It does not support pointers';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It doesn’t support all types of inheritance';

-- Question 8
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Platform independent',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which among the following doesn’t come under OOP concept?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data hiding';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Message passing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Platform independent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data binding';

-- Question 9
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'class derived_classname : access base_classname{ /*define class body*/ };',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which is the correct syntax of inheritance?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'class base_classname :access derived_classname{ /*define class body*/ };';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'class derived_classname : access base_classname{ /*define class body*/ };';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'class derived_classname : base_classname{ /*define class body*/ };';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'class base_classname : derived_classname{ /*define class body*/ };';

-- Question 10
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Encapsulation and Inheritance',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which feature of OOP is indicated by the following code?\n\nclass student{ int marks; };\nclass topper:public student{ int age; topper(int age){ this.age=age; } };',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Encapsulation and Inheritance';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Inheritance and polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Inheritance';

-- Question 11
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Message Passing',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'The feature by which one object can interact with another object is _____________',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Message reading';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Message Passing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data transfer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data Binding';

-- Question 12
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'The language must follow all the rules of OOP',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which among the following, for a pure OOP language, is true?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'The language should follow at least 1 feature of OOP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'The language must follow only 3 features of OOP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'The language must follow all the rules of OOP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'The language should follow 3 or more features of OOP';

-- Question 13
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = '3',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'How many types of access specifiers are provided in OOP (C++)?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '4';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '3';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '2';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '1';

-- Question 14
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Code reusability',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'In multilevel inheritance, which is the most significant feature of OOP used?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Code efficiency';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Code readability';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Flexibility';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Code reusability';

-- Question 15
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'It is a way of combining various data members and member functions that operate on those data members into a single unit',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'What is encapsulation in OOP?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is a way of combining various data members and member functions that operate on those data members into a single unit';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is a way of combining various data members and member functions into a single unit which can operate on any data';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is a way of combining various data members into a single unit';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is a way of combining various member functions into a single unit';

-- Question 16
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Increases overhead of function definition always',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which of the following is not true about polymorphism?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Helps in redefining the same functionality';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Increases overhead of function definition always';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is feature of OOP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Ease in readability of program';

-- Question 17
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Compile time error',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which constructor will be called from the object created in the below C++ code? ...',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Parameterized constructor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Default constructor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Run time error';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Compile time error';

-- Question 18
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Hiding the implementation and showing only the features',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'What is an abstraction in object-oriented programming?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Hiding the implementation and showing only the features';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Hiding the important data';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Hiding the implementation';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Showing the important data';

-- Question 19
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Overloading <<',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which among the following can show polymorphism?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Overloading &&';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Overloading <<';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Overloading ||';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Overloading +=';

-- Question 20
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Public',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'In which access should a constructor be defined, so that object of the class can be created in any function?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Any access specifier will work';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Private';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Public';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Protected';

-- Question 21
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Program runs and all objects are created',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which among the following is correct for the class defined below? class student { int marks; public: student(){} student(int x) { marks=x; } }; main() { student s1(100); student s2(); student s3=100; return 0; }',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Program will give compile time error';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Object s3, syntax error';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Only object s1 and s2 will be created';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Program runs and all objects are created';

-- Question 22
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Copy an object so that it can be passed to a function',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'The copy constructors can be used to ________',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Copy an object so that it can be passed to another primitive type variable';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Copy an object for type casting';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Copy an object so that it can be passed to a function';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Copy an object so that it can be passed to a class';

-- Question 23
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'A(int y, int x)',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which constructor will be called from the object obj2 in the following C++ program? class A { int i; A() { i=0; } A(int x) { i=x+1; } A(int y, int x) { i=x+y; } }; A obj1(10); A obj2(10,20); A obj3;',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A(int y, int x)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A(int y; int x)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A(int y)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A(int x)';

-- Question 24
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'classname()',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which among the following represents correct constructor?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '–classname()';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'classname()';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '()classname';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '~classname()';

-- Question 25
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Destructor is not called',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'What happens when an object is passed by reference?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Destructor is called at end of function';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Destructor is called when called explicitly';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Destructor is not called';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Destructor is called when function is out of scope';




-- Question 26
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Private',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which access specifier is usually used for data members of a class?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Protected';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Private';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Public';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Default';

-- Question 27
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Dot or arrow as required',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'How to access data members of a class?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Dot, arrow or direct call';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Dot operator';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Arrow operator';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Dot or arrow as required';

-- Question 28
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Inheritance',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which feature of OOP reduces the use of nested classes?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Inheritance';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Binding';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Abstraction';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Encapsulation';

-- Question 29
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'new',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which keyword among the following can be used to declare an array of objects in java?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'allocate';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'arr';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'new';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'create';

-- Question 30
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'delete',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which operator can be used to free the memory allocated for an object in C++?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Unallocate';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Free()';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Collect';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'delete';

-- Question 31
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Names',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which of the following is not a property of an object?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Properties';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Names';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Identity';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Attributes';

-- Question 32
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Private',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which type of members can’t be accessed in derived classes of a base class?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All can be accessed';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Protected';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Private';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Public';

-- Question 33
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Using the data and functions into derived segment',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which among the following best describes the Inheritance?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using the data and functions into derived segment';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using already defined functions in a programming language';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using the code already written once';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Copying the code already written';

-- Question 34
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Runtime',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Single level inheritance supports _____________ inheritance.',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Language independency';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Multiple inheritance';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Compile time';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Runtime';

-- Question 35
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Using virtual keyword with same name function',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'How to overcome diamond problem?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using seperate derived class';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using virtual keyword with same name function';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Can’t be done';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using alias name';

-- Question 36
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'virtual',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which keyword is used to declare virtual functions?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'virt';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'virtually';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'virtual';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'anonymous';

-- Question 37
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Compile time error',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'What happens if non static members are used in static member function?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Executes fine';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Compile time error';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Executes if that member function is not used';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Runtime error';

-- Question 38
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Non-member functions which have access to all the members (including private) of a class',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'What is friend member functions in C++?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Non-member functions which have access to all the members (including private) of a class';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Member function which doesn’t have access to private members';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Member function which can modify any data of a class';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Member function which can access all the members of a class';

-- Question 39
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'RAM',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Where is the memory allocated for the objects?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Cache';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'ROM';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'HDD';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'RAM';

-- Question 40
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Member functions having the same name in base and derived classes',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which of the following best describes member function overriding?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Member functions having the same name in derived class only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Member functions having the same name and different signature inside main function';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Member functions having the same name in base and derived classes';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Member functions having the same name in base class only';

-- Question 41
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Binding and Hiding respectively',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Encapsulation and abstraction differ as ____________',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Hiding and hiding respectively';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Binding and Hiding respectively';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Hiding and Binding respectively';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Can be used any way';

-- Question 42
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Polymorphism',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which feature of OOP is exhibited by the function overriding?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Encapsulation';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Abstraction';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Inheritance';

-- Question 43
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Using address of member function',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'How to access the private member function of a class?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using class address';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using object of class';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using object pointer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Using address of member function';

-- Question 44
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'static',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which keyword should be used to declare static variables?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'const';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'common';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'static';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'stat';

-- Question 45
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'className* objectName;',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which is correct syntax for declaring pointer to object?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '*className objectName;';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'className* objectName;';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'className objectName();';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'className objectName;';

-- Question 46
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'All class student, topper and average together can show polymorphism',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which class/set of classes can illustrate polymorphism in the following C++ code?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Only class student and topper together can show polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Only class student can show polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Class failed should also inherit class student for this code to work for polymorphism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All class student, topper and average together can show polymorphism';

-- Question 47
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Create public member functions to access those data members',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'If data members are private, what can we do to access them from the class object?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Private data members can never be accessed from outside the class';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Create public member functions to access those data members';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Create private member functions to access those data members';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Create protected member functions to access those data members';

-- Question 48
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'It must contain a definition body',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Which among the following is not a necessary condition for constructors?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Its name must be same as that of class';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It must not have any return type';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It must contain a definition body';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It can contains arguments';

-- Question 49
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = 'Must be passed by reference',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'Object being passed to a copy constructor ___________',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Must not be mentioned in parameter list';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Must be passed with integer type';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Must be passed by value';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Must be passed by reference';

-- Question 50
EXEC InsertQuestion 
    @Type = 'Multiple Choice',
    @CorrectChoice = '~C() then ~B() then ~A()',
    @InstructorID = 3,
    @CourseID = 6,
    @QuestionText = 'If in multiple inheritance, class C inherits class B, and Class B inherits class A. In which sequence are their destructors called if an object of class C was declared?',
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '~A() then ~B() then ~C()';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '~C() then ~A() then ~B()';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '~C() then ~B() then ~A()';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '~B() then ~C() then ~A()';