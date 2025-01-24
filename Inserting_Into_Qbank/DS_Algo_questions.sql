DECLARE @QuestionID INT;

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'A way to store and organize data', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'What is a data structure?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A programming language';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A collection of algorithms';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A way to store and organize data';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A type of computer hardware';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'There are chances of wastage of memory space if elements inserted in an array are lesser than the allocated size', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'What are the disadvantages of arrays?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Index value of an array can be negative';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Elements are sequentially accessed';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data structure like queue or stack cannot be implemented';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'There are chances of wastage of memory space if elements inserted in an array are lesser than the allocated size';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Stack', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which data structure is used for implementing recursion?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'List';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Array';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Stack', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'The data structure required to check whether an expression contains a balanced parenthesis is?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Array';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Data Transfer between two asynchronous process', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following is not the application of stack?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data Transfer between two asynchronous process';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Compiler Syntax Analyzer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Tracking of local variables at run time';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'A parentheses balancing program';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Stack', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which data structure is needed to convert infix notation to postfix notation?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Branch';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Queue';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = '-18', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'What is the value of the postfix expression 6 3 2 4 + – *?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '74';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '-18';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '22';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '40';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Stack', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'What data structure would you mostly likely see in non recursive implementation of a recursive algorithm?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Linked List';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Queue';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Stack is the FIFO data structure', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following statement(s) about stack data structure is/are NOT correct?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Top of the Stack always contain the new node';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack is the FIFO data structure';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Null link is present in the last node at the bottom of the stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Linked List are used for implementing Stacks';

EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Queue', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'The data structure required for Breadth First Traversal on a graph is?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Array';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Queue';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = '-A/B*C^DE', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'The prefix form of A-B/ (C * D ^ E) is?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '-A/B*C^DE';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '-A/BC*^DE';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '-ABCD*^DE';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '-/*^ACBDE';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Access of elements in linked list takes less time than compared to arrays', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following points is/are not true about Linked List data structure when it is compared with an array?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Random access is not allowed in a typical implementation of Linked Lists';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Access of elements in linked list takes less time than compared to arrays';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Arrays have better cache locality that can make them better in terms of performance';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is easy to insert and delete elements in Linked List';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Stack', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which data structure is based on the Last In First Out (LIFO) principle?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Linked List';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Queue';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Allocating CPU to resources', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following application makes use of a circular linked list?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Recursive function calls';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Undo operation in a text editor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Implement Hash Tables';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Allocating CPU to resources';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Data structure that compactly stores bits', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'What is a bit array?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data structure that compactly stores bits';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Data structure for representing arrays of records';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Array in which elements are not present in continuous locations';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'An array in which most of the elements have the same value';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'B-tree', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following tree data structures is not a balanced binary tree?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Splay tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'B-tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'AVL tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Red-black tree';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Single ended queue', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following is not the type of queue?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Priority queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Circular queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Single ended queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Ordinary queue';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Stack', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following data structures can be used for parentheses matching?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'n-ary tree';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'priority queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'stack';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Divide and Conquer', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which algorithm is used in the top tree data structure?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Backtracking';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Divide and Conquer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Branch';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Greedy';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'effective usage of memory', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'What is the need for a circular queue?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'easier computations';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'implement LIFO principle in queues';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'effective usage of memory';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'to delete elements based on priority';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Algorithm', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'The word ____________comes from the name of a Persian mathematician Abu Ja’far Mohammed ibn-i Musa al Khowarizmi.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Flowchart';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Flow';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Syntax';


EXEC InsertQuestion 
    @Type = 'True/False', 
    @CorrectChoice = 'True', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'In computer science, algorithm refers to a special method usable by a computer for the solution to a problem.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Performance', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'This characteristic often draws the line between what is feasible and what is impossible.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Performance';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'System Evaluation';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Modularity';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Reliability';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Running', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'The time that depends on the input: an already sorted sequence that is easier to sort.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Process';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Evaluation';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Running';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Input';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'as syntax', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following is incorrect? Algorithms can be represented:', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'as pseudo codes';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'as syntax';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'as programs';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'as flowcharts';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Program', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'When an algorithm is written in the form of a programming language, it becomes a _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Flowchart';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Program';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Pseudo code';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Syntax';


EXEC InsertQuestion 
    @Type = 'True/False', 
    @CorrectChoice = 'False', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Any algorithm is a program.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Queue', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'A system wherein items are added from one and removed from the other end.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Linked List';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Array';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Linear arrays', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Another name for 1-D arrays.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Linear arrays';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Lists';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Horizontal array';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Vertical array';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Queue', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'A data structure that follows the FIFO principle.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Queue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'LL';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stack';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Union';



EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'analysing the zero flow', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'The first step in the naïve greedy algorithm is?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'adding flows with higher values';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'reversing flow if required';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'analysing the zero flow';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'calculating the maximum flow using trial and error';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = '100', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Suppose you have coins of denominations 1,3 and 4. You use a greedy algorithm, in which you choose the largest denomination coin which is not greater than the remaining sum. For which of the following sums, will the algorithm produce an optimal answer?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '100';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '10';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '6';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '14';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'branch and bound divides a problem into at least 2 new restricted sub problems', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Choose the correct statement from the following.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'branch and bound is not suitable where a greedy algorithm is not applicable';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'branch and bound divides a problem into at least 2 new restricted sub problems';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'backtracking divides a problem into at least 2 new restricted sub problems';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'branch and bound is more efficient than backtracking';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Greedy algorithm', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'Dijkstra’s Algorithm is the prime example for ___________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Dynamic programming';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Back tracking';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Branch and bound';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Greedy algorithm';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Dynamic Programming', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'Bellmann Ford Algorithm is an example for ____________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Linear Programming';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Greedy Algorithms';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Dynamic Programming';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Branch and Bound';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'greedy algorithm', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following algorithms is the best approach for solving Huffman codes?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'greedy algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'exhaustive search';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'divide and conquer algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'brute force algorithm';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Greedy algorithm', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'Fractional knapsack problem is solved most efficiently by which of the following algorithm?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Backtracking';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Greedy algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Dynamic programming';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Divide and conquer';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'It can accept cycles in the MST', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following is false about the Kruskal’s algorithm?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It constructs MST by selecting edges in increasing order of their weights';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is a greedy algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It uses union-find data structure';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It can accept cycles in the MST';



EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Null case', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'Which of the following case does not exist in complexity theory?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Best case';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Worst case';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Average case';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Null case';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'O(n)', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'The complexity of linear search algorithm is _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(log n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n2)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n log n)';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'O(log n)', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'The complexity of Binary search algorithm is _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(log n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n2)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n log n)';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'O(n log n)', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'The complexity of merge sort algorithm is _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(log n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n2)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n log n)';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'O(n2)', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'The complexity of Bubble sort algorithm is _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(log n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n2)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n log n)';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Item is the last element in the array or is not there at all', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'The Worst case occur in linear search algorithm when _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Item is somewhere in the middle of the array';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Item is not in the array at all';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Item is the last element in the array';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Item is the last element in the array or is not there at all';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'O(n2)', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'The worst case complexity for insertion sort is _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(log n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n2)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n log n)';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'O(2n)', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'The complexity of Fibonacci series is _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(2n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(log n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n2)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n log n)';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Pivot is the smallest element', 
    @InstructorID = 2, 
    @CourseID = 2, 
    @QuestionText = 'The worst case occurs in quick sort when _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Pivot is the median of the array';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Pivot is the smallest element';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Pivot is the middle element';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';


EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'O(n2)', 
    @InstructorID = 1, 
    @CourseID = 2, 
    @QuestionText = 'The worst case complexity of quick sort is _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(log n)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n2)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'O(n log n)';