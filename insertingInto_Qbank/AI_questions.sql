DECLARE @QuestionID INT;

-- Question 1: What is the full form of “AI”? (Course: Artificial Intelligence, Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Artificial Intelligence', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is the full form of “AI”?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Artificially Intelligent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Artificial Intelligence';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Artificially Intelligence';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Advanced Intelligence';

-- Question 2: What is Artificial Intelligence? (Course: Artificial Intelligence, Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) Artificial Intelligence is a field that aims to develop intelligent machines', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Artificial Intelligence is a field that aims to make humans more intelligent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Artificial Intelligence is a field that aims to improve the security';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Artificial Intelligence is a field that aims to develop intelligent machines';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Artificial Intelligence is a field that aims to mine the data';

-- Question 3: Who is the inventor of Artificial Intelligence? (Course: Artificial Intelligence, Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) John McCarthy', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Who is the inventor of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Geoffrey Hinton';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Andrew Ng';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) John McCarthy';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Jürgen Schmidhuber';

-- Question 4: Which of the following is the branch of Artificial Intelligence? (Course: Artificial Intelligence, Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'a) Machine Learning', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is the branch of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Machine Learning';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Cyber forensics';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Full-Stack Developer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Network Design';

-- Question 5: What is the goal of Artificial Intelligence? (Course: Artificial Intelligence, Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) To explain various sorts of intelligence', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is the goal of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) To solve artificial problems';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) To extract scientific causes';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) To explain various sorts of intelligence';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) To solve real-world problems';


-- Question 6: Which of the following is an application of Artificial Intelligence? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Language understanding and problem-solving (Text analytics and NLP)', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is an application of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) It helps to exploit vulnerabilities to secure the firm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Language understanding and problem-solving (Text analytics and NLP)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Easy to create a website';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) It helps to deploy applications on the cloud';

-- Question 7: In how many categories process of Artificial Intelligence is categorized? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) categorized into 3 categories', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'In how many categories process of Artificial Intelligence is categorized?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) categorized into 5 categories';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) processes are categorized based on the input provided';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) categorized into 3 categories';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) process is not categorized';

-- Question 8: Based on which of the following parameter Artificial Intelligence is categorized? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) Based on capabilities and functionally', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Based on which of the following parameter Artificial Intelligence is categorized?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Based on functionally only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Based on capabilities only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Based on capabilities and functionally';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) It is not categorized';

-- Question 9: Which of the following is a component of Artificial Intelligence? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'a) Learning', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is a component of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Learning';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Training';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Designing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Puzzling';

-- Question 10: What is the function of an Artificial Intelligence “Agent”? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) Mapping of precept sequence to an action', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is the function of an Artificial Intelligence “Agent”?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Mapping of goal sequence to an action';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Work without the direct interference of the people';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Mapping of precept sequence to an action';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Mapping of environment sequence to an action';

-- Question 11: Which of the following is not a type of Artificial Intelligence agent? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) Unity-based AI agent', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is not a type of Artificial Intelligence agent?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Learning AI agent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Goal-based AI agent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Simple reflex AI agent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Unity-based AI agent';

-- Question 12: Which of the following is not the commonly used programming language for Artificial Intelligence? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'a) Perl', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is not the commonly used programming language for Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Perl';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Java';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) PROLOG';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) LISP';

-- Question 13: What is the name of the Artificial Intelligence system developed by Daniel Bobrow? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) system known as STUDENT', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is the name of the Artificial Intelligence system developed by Daniel Bobrow?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) program known as BACON';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) system known as STUDENT';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) program known as SHRDLU';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) system known as SIMD';

-- Question 14: What is the function of the system Student? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) system which can read and solve algebra word problems', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is the function of the system Student?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) program that can read algebra word problems only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) system which can solve algebra word problems but not read';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) system which can read and solve algebra word problems';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 15: Which of the following is not an application of artificial intelligence? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) DBMS', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is not an application of artificial intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Face recognition system';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Chatbots';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) LIDAR';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) DBMS';


-- Question 16: Which of the following machine requires input from the humans but can interpret the outputs themselves? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) AI system', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following machine requires input from the humans but can interpret the outputs themselves?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Actuators';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Sensor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Agents';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) AI system';

-- Question 17: _________ number of informed search method are there in Artificial Intelligence. (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'a) 4', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = '_________ number of informed search method are there in Artificial Intelligence.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) 4';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) 3';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) 2';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) 1';

-- Question 18: The total number of proposition symbols in AI are ________ (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) 2 proposition symbols', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'The total number of proposition symbols in AI are ________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) 3 proposition symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) 1 proposition symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) 2 proposition symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) No proposition symbols';

-- Question 19: The total number of logical symbols in AI are ____________ (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) There are 5 logical symbols', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'The total number of logical symbols in AI are ____________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) There are 3 logical symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) There are 5 logical symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Number of logical symbols are based on the input';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Logical symbols are not used';

-- Question 20: Which of the following are the approaches to Artificial Intelligence? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) All of the mentioned', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following are the approaches to Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Applied approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Strong approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Weak approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the mentioned';

-- Question 21: Face Recognition system is based on which type of approach? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Applied AI approach', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Face Recognition system is based on which type of approach?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Weak AI approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Applied AI approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Cognitive AI approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Strong AI approach';

-- Question 22: Which of the following is an advantage of artificial intelligence? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) All of the above', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is an advantage of artificial intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Reduces the time taken to solve the problem';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Helps in providing security';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Have the ability to think hence makes the work easier';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the above';

-- Question 23: Which of the following can improve the performance of an AI agent? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Learning', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following can improve the performance of an AI agent?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Perceiving';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Learning';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Observing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the mentioned';

-- Question 24: Which of the following is/are the composition for AI agents? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) Both Program and Architecture', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is/are the composition for AI agents?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Program only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Architecture only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Both Program and Architecture';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 25: On which of the following approach A basic line following robot is based? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Weak approach', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'On which of the following approach A basic line following robot is based?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Applied approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Weak approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Strong approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Cognitive approach';


-- Question 26: Artificial Intelligence has evolved extremely in all the fields except for _________ (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) All of the mentioned', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Artificial Intelligence has evolved extremely in all the fields except for _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Web mining';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Construction of plans in real time dynamic systems';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Understanding natural language robustly';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the mentioned';

-- Question 27: Which of the following is an example of artificial intelligent agent/agents? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) All of the mentioned', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is an example of artificial intelligent agent/agents?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Autonomous Spacecraft';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Human';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Robot';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the mentioned';

-- Question 28: Which of the following is an expansion of Artificial Intelligence application? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) All of the mentioned', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is an expansion of Artificial Intelligence application?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Game Playing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Planning and Scheduling';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Diagnosis';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the mentioned';

-- Question 29: What is an AI ‘agent’? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) All of the mentioned', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is an AI ‘agent’?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Takes input from the surroundings and uses its intelligence and performs the desired operations';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) An embedded program controlling line following robot';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Perceives its environment through sensors and acting upon that environment through actuators';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the mentioned';

-- Question 30: Which of the following environment is strategic? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Deterministic', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following environment is strategic?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Rational';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Deterministic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Partial';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Stochastic';

-- Question 31: What is the name of Artificial Intelligence which allows machines to handle vague information with a deftness that mimics human intuition? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) Fuzzy logic', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is the name of Artificial Intelligence which allows machines to handle vague information with a deftness that mimics human intuition?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Human intelligence';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Boolean logic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Functional logic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Fuzzy logic';

-- Question 32: Which of the following produces hypotheses that are easy to read for humans? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) ILP', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following produces hypotheses that are easy to read for humans?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Machine Learning';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) ILP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) First-order logic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Propositional logic';

-- Question 33: What does the Bayesian network provide? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) Complete description of the domain', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What does the Bayesian network provide?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Partial description of the domain';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Complete description of the problem';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Complete description of the domain';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 34: What is the total number of quantification available in artificial intelligence? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) 2', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is the total number of quantification available in artificial intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) 4';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) 3';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) 1';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) 2';

-- Question 35: What is Weak AI? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'a) the study of mental faculties using mental models implemented on a computer', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is Weak AI?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) the study of mental faculties using mental models implemented on a computer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) the embodiment of human intellectual capabilities within a computer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) a set of computer programs that produce output that would be considered to reflect intelligence if it were generated by humans';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) all of the mentioned';

-- Question 36: Which of the following are the 5 big ideas of AI? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) All of the above', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following are the 5 big ideas of AI?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Perception';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Human-AI Interaction';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Societal Impact';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the above';


-- Question 36: Which depends on the percepts and actions available to the agent? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) Design problem', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which depends on the percepts and actions available to the agent?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Agent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Sensor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Design problem';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 37: Which were built in such a way that humans had to supply the inputs and interpret the outputs? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) AI system', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which were built in such a way that humans had to supply the inputs and interpret the outputs?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Agents';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) AI system';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Sensor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Actuators';

-- Question 38: Which technology uses miniaturized accelerometers and gyroscopes? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) MEMS', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which technology uses miniaturized accelerometers and gyroscopes?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Sensors';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Actuators';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) MEMS';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 39: What is used for tracking uncertain events? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'a) Filtering algorithm', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is used for tracking uncertain events?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Filtering algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Sensors';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Actuators';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 40: What is not represented by using propositional logic? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) Both Objects & Relations', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is not represented by using propositional logic?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Objects';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Relations';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Both Objects & Relations';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 41: Which functions are used as preferences over state history? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Reward', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which functions are used as preferences over state history?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Award';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Reward';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Explicit';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Implicit';

-- Question 42: Which kind of agent architecture should an agent use? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) All of the mentioned', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which kind of agent architecture should an agent use?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Relaxed';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Logic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Relational';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) All of the mentioned';

-- Question 43: Specify the agent architecture name that is used to capture all kinds of actions. (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) Hybrid', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Specify the agent architecture name that is used to capture all kinds of actions.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Complex';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Relational';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Hybrid';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 44: Which agent enables the deliberation about the computational entities and actions? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Reflective', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which agent enables the deliberation about the computational entities and actions?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Hybrid';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Reflective';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Relational';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 45: What can operate over the joint state space? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) Both Decision-making & Learning algorithm', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What can operate over the joint state space?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Decision-making algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Learning algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Complex algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Both Decision-making & Learning algorithm';


-- Question 46: Why is the XOR problem exceptionally interesting to neural network researchers? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'd) Because it is the simplest linearly inseparable problem that exists.', 
    @InstructorID = 1, -- John Doe
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Why is the XOR problem exceptionally interesting to neural network researchers?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Because it can be expressed in a way that allows you to use a neural network';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Because it is complex binary operation that cannot be solved using neural networks';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Because it can be solved by a single layer perceptron';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Because it is the simplest linearly inseparable problem that exists.';

-- Question 47: What is back propagation? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'c) It is the transmission of error back through the network to allow weights to be adjusted so that the network can learn', 
    @InstructorID = 2, -- Jane Smith
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'What is back propagation?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) It is another name given to the curvy function in the perceptron';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) It is the transmission of error back through the network to adjust the inputs';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) It is the transmission of error back through the network to allow weights to be adjusted so that the network can learn';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) None of the mentioned';

-- Question 48: Why are linearly separable problems of interest of neural network researchers? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'b) Because they are the only class of problem that Perceptron can solve successfully', 
    @InstructorID = 3, -- Alice Johnson
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Why are linearly separable problems of interest of neural network researchers?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Because they are the only class of problem that network can solve successfully';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Because they are the only class of problem that Perceptron can solve successfully';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Because they are the only mathematical functions that are continue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Because they are the only mathematical functions you can draw';

-- Question 49: Which of the following is not the promise of artificial neural network? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'a) It can explain result', 
    @InstructorID = 4, -- Robert Brown
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Which of the following is not the promise of artificial neural network?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) It can explain result';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) It can survive the failure of some nodes';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) It has inherent parallelism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) It can handle noise';

-- Question 50: Neural Networks are complex ______________ with many parameters. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'a) Linear Functions', 
    @InstructorID = 5, -- Emily Davis
    @CourseID = 1, -- Artificial Intelligence
    @QuestionText = 'Neural Networks are complex ______________ with many parameters.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a) Linear Functions';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'b) Nonlinear Functions';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'c) Discrete Functions';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'd) Exponential Functions';