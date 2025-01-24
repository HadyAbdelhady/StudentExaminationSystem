BEGIN TRY
    BEGIN TRANSACTION;
    
    DECLARE @InstructorID INT = 1;
    DECLARE @CourseID INT = 7;
    DECLARE @Type NVARCHAR(50) = 'Multiple Choice';
    DECLARE @QuestionID INT;

    -- Question 1: Variables
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'let',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to declare a block-scoped variable in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'let';
    EXEC insertQuestionBankChoice @QuestionID, 'var';
    EXEC insertQuestionBankChoice @QuestionID, 'const';
    EXEC insertQuestionBankChoice @QuestionID, 'variable';

    -- Question 2: Data Types
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'typeof',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which operator is used to check the type of a variable in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'typeof';
    EXEC insertQuestionBankChoice @QuestionID, 'type';
    EXEC insertQuestionBankChoice @QuestionID, 'instanceof';
    EXEC insertQuestionBankChoice @QuestionID, 'checktype';

    -- Question 3: Arrays
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'push()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method is used to add elements to the end of an array?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'push()';
    EXEC insertQuestionBankChoice @QuestionID, 'append()';
    EXEC insertQuestionBankChoice @QuestionID, 'add()';
    EXEC insertQuestionBankChoice @QuestionID, 'insert()';

    -- Question 4: Functions
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'return',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword is used to specify the value that a function should return?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'return';
    EXEC insertQuestionBankChoice @QuestionID, 'output';
    EXEC insertQuestionBankChoice @QuestionID, 'yield';
    EXEC insertQuestionBankChoice @QuestionID, 'send';

    -- Question 5: Objects
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Object.keys()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method returns an array of a given object''s property names?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Object.keys()';
    EXEC insertQuestionBankChoice @QuestionID, 'Object.properties()';
    EXEC insertQuestionBankChoice @QuestionID, 'Object.names()';
    EXEC insertQuestionBankChoice @QuestionID, 'Object.getKeys()';

    -- Continue with remaining questions...
    -- Question 6: Promises
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'then()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method is used to handle the successful completion of a Promise?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'then()';
    EXEC insertQuestionBankChoice @QuestionID, 'success()';
    EXEC insertQuestionBankChoice @QuestionID, 'complete()';
    EXEC insertQuestionBankChoice @QuestionID, 'done()';

    -- Question 7: DOM Manipulation
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'getElementById()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method is used to select an HTML element by its ID?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'getElementById()';
    EXEC insertQuestionBankChoice @QuestionID, 'querySelector()';
    EXEC insertQuestionBankChoice @QuestionID, 'selectElement()';
    EXEC insertQuestionBankChoice @QuestionID, 'findById()';

    -- Question 8: Event Handling
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'addEventListener()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method is used to attach an event handler to an element?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'addEventListener()';
    EXEC insertQuestionBankChoice @QuestionID, 'attachEvent()';
    EXEC insertQuestionBankChoice @QuestionID, 'bindEvent()';
    EXEC insertQuestionBankChoice @QuestionID, 'connectEvent()';

    -- Question 9: Scope
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Global scope',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Variables declared outside any function belong to which scope?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Global scope';
    EXEC insertQuestionBankChoice @QuestionID, 'Local scope';
    EXEC insertQuestionBankChoice @QuestionID, 'Function scope';
    EXEC insertQuestionBankChoice @QuestionID, 'Block scope';

    -- Question 10: Classes
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'constructor',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method is called when a new instance of a class is created?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'constructor';
    EXEC insertQuestionBankChoice @QuestionID, 'init';
    EXEC insertQuestionBankChoice @QuestionID, 'create';
    EXEC insertQuestionBankChoice @QuestionID, 'new';
    COMMIT TRANSACTION;
    PRINT 'All JavaScript questions inserted successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred while inserting the questions.';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;

GO

BEGIN TRY
    BEGIN TRANSACTION;
    
    DECLARE @InstructorID INT = 1;
    DECLARE @CourseID INT = 7;
    DECLARE @Type NVARCHAR(50) = 'Multiple Choice';
    DECLARE @QuestionID INT;

    -- Question 11: Async/Await
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'async',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword must be used before a function declaration to make it return a Promise?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'async';
    EXEC insertQuestionBankChoice @QuestionID, 'await';
    EXEC insertQuestionBankChoice @QuestionID, 'promise';
    EXEC insertQuestionBankChoice @QuestionID, 'then';

    -- Question 12: ES6 Features
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = '...array',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which syntax is used to spread elements of an array in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, '...array';
    EXEC insertQuestionBankChoice @QuestionID, '*array';
    EXEC insertQuestionBankChoice @QuestionID, 'array[]';
    EXEC insertQuestionBankChoice @QuestionID, 'array.spread()';

    -- Question 13: Arrow Functions
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'They don''t have their own this binding',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is a key difference between arrow functions and regular functions?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'They don''t have their own this binding';
    EXEC insertQuestionBankChoice @QuestionID, 'They can''t take parameters';
    EXEC insertQuestionBankChoice @QuestionID, 'They can''t return values';
    EXEC insertQuestionBankChoice @QuestionID, 'They must be assigned to variables';

    -- Question 14: Local Storage
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'localStorage.setItem()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method is used to store data in the browser''s local storage?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'localStorage.setItem()';
    EXEC insertQuestionBankChoice @QuestionID, 'localStorage.store()';
    EXEC insertQuestionBankChoice @QuestionID, 'localStorage.save()';
    EXEC insertQuestionBankChoice @QuestionID, 'localStorage.add()';

    -- Question 15: Map Function
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'A new array with transformed elements',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What does the Array.map() method return?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'A new array with transformed elements';
    EXEC insertQuestionBankChoice @QuestionID, 'The original array modified';
    EXEC insertQuestionBankChoice @QuestionID, 'A single value';
    EXEC insertQuestionBankChoice @QuestionID, 'undefined';

    -- Question 16: Destructuring
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'const { name, age } = person',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which is the correct syntax for object destructuring in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'const { name, age } = person';
    EXEC insertQuestionBankChoice @QuestionID, 'const [name, age] = person';
    EXEC insertQuestionBankChoice @QuestionID, 'const (name, age) = person';
    EXEC insertQuestionBankChoice @QuestionID, 'const {name + age} = person';

    -- Question 17: Sets
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'To store unique values',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the primary purpose of using a Set in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'To store unique values';
    EXEC insertQuestionBankChoice @QuestionID, 'To store ordered pairs';
    EXEC insertQuestionBankChoice @QuestionID, 'To store functions';
    EXEC insertQuestionBankChoice @QuestionID, 'To store JSON data';

    -- Question 18: Template Literals
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Backticks (`)',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which character is used to define template literals in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Backticks (`)';
    EXEC insertQuestionBankChoice @QuestionID, 'Single quotes ('')';
    EXEC insertQuestionBankChoice @QuestionID, 'Double quotes ("")';
    EXEC insertQuestionBankChoice @QuestionID, 'Forward slash (/)';

    -- Question 19: Modules
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'export default',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which keyword combination is used to export a default value from a JavaScript module?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'export default';
    EXEC insertQuestionBankChoice @QuestionID, 'module export';
    EXEC insertQuestionBankChoice @QuestionID, 'default export';
    EXEC insertQuestionBankChoice @QuestionID, 'module default';

    -- Question 20: Error Handling
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'finally',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which block in a try-catch statement is executed regardless of whether an exception occurs?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'finally';
    EXEC insertQuestionBankChoice @QuestionID, 'end';
    EXEC insertQuestionBankChoice @QuestionID, 'complete';
    EXEC insertQuestionBankChoice @QuestionID, 'always';

    COMMIT TRANSACTION;
    PRINT 'Additional JavaScript questions inserted successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred while inserting the questions.';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;

GO

BEGIN TRY
    BEGIN TRANSACTION;
    
    DECLARE @InstructorID INT = 1;
    DECLARE @CourseID INT = 1;
    DECLARE @Type NVARCHAR(50) = 'Multiple Choice';
    DECLARE @QuestionID INT;

    -- Question 21: Closures
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Access variables in outer scope',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main purpose of a closure in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Access variables in outer scope';
    EXEC insertQuestionBankChoice @QuestionID, 'Create global variables';
    EXEC insertQuestionBankChoice @QuestionID, 'Speed up execution';
    EXEC insertQuestionBankChoice @QuestionID, 'Reduce memory usage';

    -- Question 22: Prototype Chain
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Object.prototype',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the end point of every prototype chain in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Object.prototype';
    EXEC insertQuestionBankChoice @QuestionID, 'null';
    EXEC insertQuestionBankChoice @QuestionID, 'undefined';
    EXEC insertQuestionBankChoice @QuestionID, 'Function.prototype';

    -- Question 23: Promise States
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Pending',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the initial state of a Promise?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Pending';
    EXEC insertQuestionBankChoice @QuestionID, 'Fulfilled';
    EXEC insertQuestionBankChoice @QuestionID, 'Rejected';
    EXEC insertQuestionBankChoice @QuestionID, 'Settled';

    -- Question 24: Event Bubbling
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'stopPropagation()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method stops an event from bubbling up the DOM tree?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'stopPropagation()';
    EXEC insertQuestionBankChoice @QuestionID, 'preventDefault()';
    EXEC insertQuestionBankChoice @QuestionID, 'stopBubbling()';
    EXEC insertQuestionBankChoice @QuestionID, 'cancelBubble()';

    -- Question 25: JSON
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'JSON.stringify()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method converts a JavaScript object to a JSON string?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'JSON.stringify()';
    EXEC insertQuestionBankChoice @QuestionID, 'JSON.parse()';
    EXEC insertQuestionBankChoice @QuestionID, 'JSON.toSt ring()';
    EXEC insertQuestionBankChoice @QuestionID, 'JSON.convert()';

    -- Question 26: Array Methods
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'reduce()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which array method is best suited for calculating the sum of all elements?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'reduce()';
    EXEC insertQuestionBankChoice @QuestionID, 'map()';
    EXEC insertQuestionBankChoice @QuestionID, 'forEach()';
    EXEC insertQuestionBankChoice @QuestionID, 'filter()';

    -- Question 27: Hoisting
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Function declarations',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which of these is hoisted with its initial value in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Function declarations';
    EXEC insertQuestionBankChoice @QuestionID, 'let declarations';
    EXEC insertQuestionBankChoice @QuestionID, 'const declarations';
    EXEC insertQuestionBankChoice @QuestionID, 'Arrow functions';

    -- Question 28: Web APIs
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'setInterval()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which function is used to repeatedly execute a function at fixed time intervals?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'setInterval()';
    EXEC insertQuestionBankChoice @QuestionID, 'setTimeout()';
    EXEC insertQuestionBankChoice @QuestionID, 'requestAnimationFrame()';
    EXEC insertQuestionBankChoice @QuestionID, 'setTimer()';

    -- Question 29: Regular Expressions
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'test()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which RegExp method returns true or false for a pattern match?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'test()';
    EXEC insertQuestionBankChoice @QuestionID, 'exec()';
    EXEC insertQuestionBankChoice @QuestionID, 'match()';
    EXEC insertQuestionBankChoice @QuestionID, 'search()';

    -- Question 30: Map Object
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Any type',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What type of keys can a Map object in JavaScript use?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Any type';
    EXEC insertQuestionBankChoice @QuestionID, 'Only strings';
    EXEC insertQuestionBankChoice @QuestionID, 'Only numbers';
    EXEC insertQuestionBankChoice @QuestionID, 'Only objects';

    -- Question 31: Generators
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'function*',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which syntax declares a generator function in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'function*';
    EXEC insertQuestionBankChoice @QuestionID, 'generator';
    EXEC insertQuestionBankChoice @QuestionID, 'yield';
    EXEC insertQuestionBankChoice @QuestionID, 'gen function';

    -- Question 32: Strict Mode
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = '''use strict'';',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which directive enables strict mode in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, '''use strict'';';
    EXEC insertQuestionBankChoice @QuestionID, '''strict mode'';';
    EXEC insertQuestionBankChoice @QuestionID, '''enable strict'';';
    EXEC insertQuestionBankChoice @QuestionID, '''strict'';';

    -- Question 33: WeakMap
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Allow garbage collection of key objects',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main advantage of using WeakMap over Map?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Allow garbage collection of key objects';
    EXEC insertQuestionBankChoice @QuestionID, 'Faster performance';
    EXEC insertQuestionBankChoice @QuestionID, 'Less memory usage';
    EXEC insertQuestionBankChoice @QuestionID, 'Better security';

    -- Question 34: Symbol Type
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Create unique identifiers',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the primary purpose of the Symbol type in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Create unique identifiers';
    EXEC insertQuestionBankChoice @QuestionID, 'Improve performance';
    EXEC insertQuestionBankChoice @QuestionID, 'Enable type checking';
    EXEC insertQuestionBankChoice @QuestionID, 'Define constants';

    -- Question 35: Proxy
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Intercept and customize operations',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main use of Proxy objects in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Intercept and customize operations';
    EXEC insertQuestionBankChoice @QuestionID, 'Create network requests';
    EXEC insertQuestionBankChoice @QuestionID, 'Cache function results';
    EXEC insertQuestionBankChoice @QuestionID, 'Handle errors';

    -- Question 36: Performance
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'performance.now()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method provides high-resolution timestamps for performance measurements?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'performance.now()';
    EXEC insertQuestionBankChoice @QuestionID, 'Date.now()';
    EXEC insertQuestionBankChoice @QuestionID, 'process.hrtime()';
    EXEC insertQuestionBankChoice @QuestionID, 'console.time()';

    -- Question 37: Web Workers
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Run scripts in background threads',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main purpose of Web Workers in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Run scripts in background threads';
    EXEC insertQuestionBankChoice @QuestionID, 'Handle DOM events';
    EXEC insertQuestionBankChoice @QuestionID, 'Manage cookies';
    EXEC insertQuestionBankChoice @QuestionID, 'Cache API requests';

    -- Question 38: Fetch API
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Promise',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What does the fetch() function return?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Promise';
    EXEC insertQuestionBankChoice @QuestionID, 'JSON';
    EXEC insertQuestionBankChoice @QuestionID, 'Response';
    EXEC insertQuestionBankChoice @QuestionID, 'String';

    -- Question 39: Event Loop
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Microtask queue',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which queue has higher priority in the JavaScript event loop?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Microtask queue';
    EXEC insertQuestionBankChoice @QuestionID, 'Macrotask queue';
    EXEC insertQuestionBankChoice @QuestionID, 'Event queue';
    EXEC insertQuestionBankChoice @QuestionID, 'Callback queue';

    -- Question 40: Modules
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'type="module"',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What attribute must be added to a script tag to use ES6 modules?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'type="module"';
    EXEC insertQuestionBankChoice @QuestionID, 'module="true"';
    EXEC insertQuestionBankChoice @QuestionID, 'es6="true"';
    EXEC insertQuestionBankChoice @QuestionID, 'import="true"';

    COMMIT TRANSACTION;
    PRINT 'Final set of JavaScript questions inserted successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred while inserting the questions.';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;

GO

BEGIN TRY
    BEGIN TRANSACTION;
    
    DECLARE @InstructorID INT = 1;
    DECLARE @CourseID INT = 1;
    DECLARE @Type NVARCHAR(50) = 'Multiple Choice';
    DECLARE @QuestionID INT;

    -- Question 41: Debouncing
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Limit the rate at which a function can fire',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main purpose of debouncing in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Limit the rate at which a function can fire';
    EXEC insertQuestionBankChoice @QuestionID, 'Increase function execution speed';
    EXEC insertQuestionBankChoice @QuestionID, 'Prevent memory leaks';
    EXEC insertQuestionBankChoice @QuestionID, 'Handle async operations';

    -- Question 42: Memory Management
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Circular references',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which of these can cause memory leaks in JavaScript?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Circular references';
    EXEC insertQuestionBankChoice @QuestionID, 'Using strict mode';
    EXEC insertQuestionBankChoice @QuestionID, 'Using let instead of var';
    EXEC insertQuestionBankChoice @QuestionID, 'Using arrow functions';

    -- Question 43: Browser Storage
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'IndexedDB',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which storage API is best for storing large amounts of structured data?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'IndexedDB';
    EXEC insertQuestionBankChoice @QuestionID, 'localStorage';
    EXEC insertQuestionBankChoice @QuestionID, 'sessionStorage';
    EXEC insertQuestionBankChoice @QuestionID, 'Cookies';

    -- Question 44: Error Types
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'TypeError',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which error occurs when an operation is performed on an incompatible type?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'TypeError';
    EXEC insertQuestionBankChoice @QuestionID, 'SyntaxError';
    EXEC insertQuestionBankChoice @QuestionID, 'ReferenceError';
    EXEC insertQuestionBankChoice @QuestionID, 'RangeError';

    -- Question 45: Service Workers
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Enable offline functionality',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the primary use case for Service Workers?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Enable offline functionality';
    EXEC insertQuestionBankChoice @QuestionID, 'Process heavy computations';
    EXEC insertQuestionBankChoice @QuestionID, 'Handle DOM events';
    EXEC insertQuestionBankChoice @QuestionID, 'Manage database connections';

    -- Question 46: ESM vs CommonJS
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'import/export',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which module syntax is native to JavaScript in browsers?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'import/export';
    EXEC insertQuestionBankChoice @QuestionID, 'require/module.exports';
    EXEC insertQuestionBankChoice @QuestionID, 'include/export';
    EXEC insertQuestionBankChoice @QuestionID, 'using/expose';

    -- Question 47: Virtual DOM
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Improve rendering performance',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main purpose of Virtual DOM in frameworks like React?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Improve rendering performance';
    EXEC insertQuestionBankChoice @QuestionID, 'Provide security';
    EXEC insertQuestionBankChoice @QuestionID, 'Handle routing';
    EXEC insertQuestionBankChoice @QuestionID, 'Manage state';

    -- Question 48: Event Delegation
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Improve performance with many event handlers',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main benefit of event delegation?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Improve performance with many event handlers';
    EXEC insertQuestionBankChoice @QuestionID, 'Prevent event bubbling';
    EXEC insertQuestionBankChoice @QuestionID, 'Enable event capturing';
    EXEC insertQuestionBankChoice @QuestionID, 'Create custom events';

    -- Question 49: requestAnimationFrame
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Optimize animations',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the primary use of requestAnimationFrame?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Optimize animations';
    EXEC insertQuestionBankChoice @QuestionID, 'Handle HTTP requests';
    EXEC insertQuestionBankChoice @QuestionID, 'Process form data';
    EXEC insertQuestionBankChoice @QuestionID, 'Load images';

    -- Question 50: TypeScript Integration
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = '.ts',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What file extension is used for TypeScript files?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, '.ts';
    EXEC insertQuestionBankChoice @QuestionID, '.typescript';
    EXEC insertQuestionBankChoice @QuestionID, '.type';
    EXEC insertQuestionBankChoice @QuestionID, '.tsx';

    -- Question 51: Web Components
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'customElements.define()',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which method is used to register a new custom element?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'customElements.define()';
    EXEC insertQuestionBankChoice @QuestionID, 'document.registerElement()';
    EXEC insertQuestionBankChoice @QuestionID, 'createElement()';
    EXEC insertQuestionBankChoice @QuestionID, 'defineElement()';

    -- Question 52: JavaScript Engine
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'V8',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which JavaScript engine is used in Chrome and Node.js?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'V8';
    EXEC insertQuestionBankChoice @QuestionID, 'SpiderMonkey';
    EXEC insertQuestionBankChoice @QuestionID, 'JavaScriptCore';
    EXEC insertQuestionBankChoice @QuestionID, 'Chakra';

    -- Question 53: Web Authentication
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'navigator.credentials',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which API is used for credential management in modern browsers?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'navigator.credentials';
    EXEC insertQuestionBankChoice @QuestionID, 'window.auth';
    EXEC insertQuestionBankChoice @QuestionID, 'document.authentication';
    EXEC insertQuestionBankChoice @QuestionID, 'browser.login';

    -- Question 54: Performance Optimization
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Code splitting',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which technique helps reduce initial bundle size in modern JavaScript applications?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Code splitting';
    EXEC insertQuestionBankChoice @QuestionID, 'Minification';
    EXEC insertQuestionBankChoice @QuestionID, 'Compression';
    EXEC insertQuestionBankChoice @QuestionID, 'Caching';

    -- Question 55: WebRTC
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Peer-to-peer communication',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the primary purpose of WebRTC?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Peer-to-peer communication';
    EXEC insertQuestionBankChoice @QuestionID, 'Server-side rendering';
    EXEC insertQuestionBankChoice @QuestionID, 'Database management';
    EXEC insertQuestionBankChoice @QuestionID, 'File compression';

    -- Question 56: Intersection Observer
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Detect element visibility',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main use of Intersection Observer API?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Detect element visibility';
    EXEC insertQuestionBankChoice @QuestionID, 'Track mouse movement';
    EXEC insertQuestionBankChoice @QuestionID, 'Monitor network requests';
    EXEC insertQuestionBankChoice @QuestionID, 'Handle form submissions';

    -- Question 57: WebAssembly
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Run high-performance code in the browser',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main purpose of WebAssembly?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Run high-performance code in the browser';
    EXEC insertQuestionBankChoice @QuestionID, 'Create web components';
    EXEC insertQuestionBankChoice @QuestionID, 'Handle HTTP requests';
    EXEC insertQuestionBankChoice @QuestionID, 'Manage browser storage';

    -- Question 58: Browser APIs
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Share content with other applications',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the purpose of the Web Share API?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Share content with other applications';
    EXEC insertQuestionBankChoice @QuestionID, 'Share memory between tabs';
    EXEC insertQuestionBankChoice @QuestionID, 'Share CPU resources';
    EXEC insertQuestionBankChoice @QuestionID, 'Share database connections';

    -- Question 59: Security
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Content Security Policy',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which security feature helps prevent XSS attacks by controlling resource loading?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Content Security Policy';
    EXEC insertQuestionBankChoice @QuestionID, 'CORS';
    EXEC insertQuestionBankChoice @QuestionID, 'Same-Origin Policy';
    EXEC insertQuestionBankChoice @QuestionID, 'HTTP Strict Transport Security';

    -- Question 60: Package Management
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'package-lock.json',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which file ensures consistent installation of dependencies across different environments?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'package-lock.json';
    EXEC insertQuestionBankChoice @QuestionID, 'package.json';
    EXEC insertQuestionBankChoice @QuestionID, 'npm-shrinkwrap.json';
    EXEC insertQuestionBankChoice @QuestionID, 'dependencies.json';

    COMMIT TRANSACTION;
    PRINT 'Final set of JavaScript questions inserted successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred while inserting the questions.';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;