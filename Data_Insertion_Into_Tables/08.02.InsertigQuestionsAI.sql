DECLARE @QuestionID INT;

-- Question 1: What is the full form of “AI”? (Course: Artificial Intelligence, Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Artificial Intelligence', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is the full form of “AI”?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Artificially Intelligent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Artificial Intelligence';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Artificially Intelligence';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Advanced Intelligence';

-- Question 2: What is Artificial Intelligence? (Course: Artificial Intelligence, Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Artificial Intelligence is a field that aims to develop intelligent machines', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Artificial Intelligence is a field that aims to make humans more intelligent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Artificial Intelligence is a field that aims to improve the security';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Artificial Intelligence is a field that aims to develop intelligent machines';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Artificial Intelligence is a field that aims to mine the data';

-- Question 3: Who is the inventor of Artificial Intelligence? (Course: Artificial Intelligence, Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'John McCarthy', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Who is the inventor of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Geoffrey Hinton';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Andrew Ng';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'John McCarthy';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Jürgen Schmidhuber';

-- Question 4: Which of the following is the branch of Artificial Intelligence? (Course: Artificial Intelligence, Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Machine Learning', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is the branch of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Machine Learning';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Cyber forensics';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Full-Stack Developer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Network Design';

-- Question 5: What is the goal of Artificial Intelligence? (Course: Artificial Intelligence, Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'To explain various sorts of intelligence', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is the goal of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'To solve artificial problems';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'To extract scientific causes';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'To explain various sorts of intelligence';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'To solve real-world problems';


-- Question 6: Which of the following is an application of Artificial Intelligence? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Language understanding and problem-solving (Text analytics and NLP)', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is an application of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It helps to exploit vulnerabilities to secure the firm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Language understanding and problem-solving (Text analytics and NLP)';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Easy to create a website';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It helps to deploy applications on the cloud';

-- Question 7: In how many categories process of Artificial Intelligence is categorized? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'categorized into 3 categories', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'In how many categories process of Artificial Intelligence is categorized?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'categorized into 5 categories';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'processes are categorized based on the input provided';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'categorized into 3 categories';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'process is not categorized';

-- Question 8: Based on which of the following parameter Artificial Intelligence is categorized? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Based on capabilities and functionally', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Based on which of the following parameter Artificial Intelligence is categorized?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Based on functionally only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Based on capabilities only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Based on capabilities and functionally';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is not categorized';

-- Question 9: Which of the following is a component of Artificial Intelligence? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Learning', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is a component of Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Learning';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Training';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Designing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Puzzling';

-- Question 10: What is the function of an Artificial Intelligence “Agent”? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Mapping of precept sequence to an action', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is the function of an Artificial Intelligence “Agent”?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Mapping of goal sequence to an action';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Work without the direct interference of the people';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Mapping of precept sequence to an action';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Mapping of environment sequence to an action';

-- Question 11: Which of the following is not a type of Artificial Intelligence agent? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Unity-based AI agent', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is not a type of Artificial Intelligence agent?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Learning AI agent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Goal-based AI agent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Simple reflex AI agent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Unity-based AI agent';

-- Question 12: Which of the following is not the commonly used programming language for Artificial Intelligence? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Perl', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is not the commonly used programming language for Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Perl';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Java';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'PROLOG';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'LISP';

-- Question 13: What is the name of the Artificial Intelligence system developed by Daniel Bobrow? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'system known as STUDENT', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is the name of the Artificial Intelligence system developed by Daniel Bobrow?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'program known as BACON';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'system known as STUDENT';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'program known as SHRDLU';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'system known as SIMD';

-- Question 14: What is the function of the system Student? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'system which can read and solve algebra word problems', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is the function of the system Student?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'program that can read algebra word problems only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'system which can solve algebra word problems but not read';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'system which can read and solve algebra word problems';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 15: Which of the following is not an application of artificial intelligence? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'DBMS', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is not an application of artificial intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Face recognition system';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Chatbots';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'LIDAR';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'DBMS';


-- Question 16: Which of the following machine requires input from the humans but can interpret the outputs themselves? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'AI system', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following machine requires input from the humans but can interpret the outputs themselves?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Actuators';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Sensor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Agents';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'AI system';

-- Question 17: _________ number of informed search method are there in Artificial Intelligence. (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = '4', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = '_________ number of informed search method are there in Artificial Intelligence.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '4';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '3';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '2';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '1';

-- Question 18: The total number of proposition symbols in AI are ________ (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = '2 proposition symbols', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'The total number of proposition symbols in AI are ________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '3 proposition symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '1 proposition symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '2 proposition symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'No proposition symbols';

-- Question 19: The total number of logical symbols in AI are ____________ (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'There are 5 logical symbols', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'The total number of logical symbols in AI are ____________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'There are 3 logical symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'There are 5 logical symbols';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Number of logical symbols are based on the input';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Logical symbols are not used';

-- Question 20: Which of the following are the approaches to Artificial Intelligence? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the mentioned', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following are the approaches to Artificial Intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Applied approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Strong approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Weak approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the mentioned';

-- Question 21: Face Recognition system is based on which type of approach? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Applied AI approach', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Face Recognition system is based on which type of approach?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Weak AI approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Applied AI approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Cognitive AI approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Strong AI approach';

-- Question 22: Which of the following is an advantage of artificial intelligence? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the above', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is an advantage of artificial intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Reduces the time taken to solve the problem';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Helps in providing security';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Have the ability to think hence makes the work easier';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the above';

-- Question 23: Which of the following can improve the performance of an AI agent? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Learning', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following can improve the performance of an AI agent?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Perceiving';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Learning';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Observing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the mentioned';

-- Question 24: Which of the following is/are the composition for AI agents? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Both Program and Architecture', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is/are the composition for AI agents?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Program only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Architecture only';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Both Program and Architecture';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 25: On which of the following approach A basic line following robot is based? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Weak approach', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'On which of the following approach A basic line following robot is based?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Applied approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Weak approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Strong approach';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Cognitive approach';


-- Question 26: Artificial Intelligence has evolved extremely in all the fields except for _________ (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the mentioned', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Artificial Intelligence has evolved extremely in all the fields except for _________', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Web mining';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Construction of plans in real time dynamic systems';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Understanding natural language robustly';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the mentioned';

-- Question 27: Which of the following is an example of artificial intelligent agent/agents? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the mentioned', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is an example of artificial intelligent agent/agents?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Autonomous Spacecraft';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Human';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Robot';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the mentioned';

-- Question 28: Which of the following is an expansion of Artificial Intelligence application? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the mentioned', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is an expansion of Artificial Intelligence application?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Game Playing';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Planning and Scheduling';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Diagnosis';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the mentioned';

-- Question 29: What is an AI ‘agent’? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the mentioned', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is an AI ‘agent’?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Takes input from the surroundings and uses its intelligence and performs the desired operations';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'An embedded program controlling line following robot';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Perceives its environment through sensors and acting upon that environment through actuators';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the mentioned';

-- Question 30: Which of the following environment is strategic? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Deterministic', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following environment is strategic?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Rational';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Deterministic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Partial';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Stochastic';

-- Question 31: What is the name of Artificial Intelligence which allows machines to handle vague information with a deftness that mimics human intuition? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Fuzzy logic', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is the name of Artificial Intelligence which allows machines to handle vague information with a deftness that mimics human intuition?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Human intelligence';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Boolean logic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Functional logic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Fuzzy logic';

-- Question 32: Which of the following produces hypotheses that are easy to read for humans? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'ILP', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following produces hypotheses that are easy to read for humans?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Machine Learning';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'ILP';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'First-order logic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Propositional logic';

-- Question 33: What does the Bayesian network provide? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Complete description of the domain', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What does the Bayesian network provide?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Partial description of the domain';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Complete description of the problem';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Complete description of the domain';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 34: What is the total number of quantification available in artificial intelligence? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = '2', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is the total number of quantification available in artificial intelligence?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '4';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '3';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '1';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = '2';

-- Question 35: What is Weak AI? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'the study of mental faculties using mental models implemented on a computer', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is Weak AI?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'the study of mental faculties using mental models implemented on a computer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'the embodiment of human intellectual capabilities within a computer';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'a set of computer programs that produce output that would be considered to reflect intelligence if it were generated by humans';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'all of the mentioned';

-- Question 36: Which of the following are the 5 big ideas of AI? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the above', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following are the 5 big ideas of AI?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Perception';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Human-AI Interaction';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Societal Impact';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the above';


-- Question 36: Which depends on the percepts and actions available to the agent? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Design problem', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which depends on the percepts and actions available to the agent?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Agent';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Sensor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Design problem';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 37: Which were built in such a way that humans had to supply the inputs and interpret the outputs? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'AI system', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which were built in such a way that humans had to supply the inputs and interpret the outputs?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Agents';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'AI system';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Sensor';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Actuators';

-- Question 38: Which technology uses miniaturized accelerometers and gyroscopes? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'MEMS', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which technology uses miniaturized accelerometers and gyroscopes?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Sensors';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Actuators';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'MEMS';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 39: What is used for tracking uncertain events? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Filtering algorithm', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is used for tracking uncertain events?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Filtering algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Sensors';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Actuators';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 40: What is not represented by using propositional logic? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Both Objects & Relations', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is not represented by using propositional logic?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Objects';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Relations';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Both Objects & Relations';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 41: Which functions are used as preferences over state history? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Reward', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which functions are used as preferences over state history?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Award';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Reward';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Explicit';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Implicit';

-- Question 42: Which kind of agent architecture should an agent use? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'All of the mentioned', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which kind of agent architecture should an agent use?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Relaxed';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Logic';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Relational';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'All of the mentioned';

-- Question 43: Specify the agent architecture name that is used to capture all kinds of actions. (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Hybrid', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Specify the agent architecture name that is used to capture all kinds of actions.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Complex';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Relational';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Hybrid';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 44: Which agent enables the deliberation about the computational entities and actions? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Reflective', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which agent enables the deliberation about the computational entities and actions?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Hybrid';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Reflective';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Relational';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 45: What can operate over the joint state space? (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Both Decision-making & Learning algorithm', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What can operate over the joint state space?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Decision-making algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Learning algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Complex algorithm';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Both Decision-making & Learning algorithm';


-- Question 46: Why is the XOR problem exceptionally interesting to neural network researchers? (Instructor: John Doe)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Because it is the simplest linearly inseparable problem that exists.', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Why is the XOR problem exceptionally interesting to neural network researchers?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Because it can be expressed in a way that allows you to use a neural network';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Because it is complex binary operation that cannot be solved using neural networks';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Because it can be solved by a single layer perceptron';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Because it is the simplest linearly inseparable problem that exists.';

-- Question 47: What is back propagation? (Instructor: Jane Smith)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'It is the transmission of error back through the network to allow weights to be adjusted so that the network can learn', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'What is back propagation?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is another name given to the curvy function in the perceptron';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is the transmission of error back through the network to adjust the inputs';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It is the transmission of error back through the network to allow weights to be adjusted so that the network can learn';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'None of the mentioned';

-- Question 48: Why are linearly separable problems of interest of neural network researchers? (Instructor: Alice Johnson)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Because they are the only class of problem that Perceptron can solve successfully', 
    @InstructorID = 11,
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Why are linearly separable problems of interest of neural network researchers?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Because they are the only class of problem that network can solve successfully';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Because they are the only class of problem that Perceptron can solve successfully';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Because they are the only mathematical functions that are continue';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Because they are the only mathematical functions you can draw';

-- Question 49: Which of the following is not the promise of artificial neural network? (Instructor: Robert Brown)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'It can explain result', 
    @InstructorID = 4, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Which of the following is not the promise of artificial neural network?', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It can explain result';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It can survive the failure of some nodes';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It has inherent parallelism';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'It can handle noise';

-- Question 50: Neural Networks are complex ______________ with many parameters. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'Multiple Choice', 
    @CorrectChoice = 'Linear Functions', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Neural Networks are complex ______________ with many parameters.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Linear Functions';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Nonlinear Functions';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Discrete Functions';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'Exponential Functions';



-- Question 1: Neural Networks are inspired by the human brain. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Neural Networks are inspired by the human brain.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 2: Convolutional Neural Networks (CNNs) are primarily used for natural language processing tasks. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'False', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Convolutional Neural Networks (CNNs) are primarily used for natural language processing tasks.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 3: Overfitting occurs when a model performs well on training data but poorly on new data. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Overfitting occurs when a model performs well on training data but poorly on new data.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 4: The activation function in neural networks introduces non-linearity. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'The activation function in neural networks introduces non-linearity.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 5: Dropout is a technique used to prevent overfitting in neural networks. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Dropout is a technique used to prevent overfitting in neural networks.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 6: Recurrent Neural Networks (RNNs) are suited for sequence data. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Recurrent Neural Networks (RNNs) are suited for sequence data.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 7: The learning rate controls how much to change the model in response to an estimated error each time the model weights are updated. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'The learning rate controls how much to change the model in response to an estimated error each time the model weights are updated.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 8: Neural networks can only be used for classification tasks. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'False', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Neural networks can only be used for classification tasks.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 9: The sigmoid function outputs values between 0 and 1. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'The sigmoid function outputs values between 0 and 1.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 10: Batch normalization helps to accelerate the training of deep neural networks. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Batch normalization helps to accelerate the training of deep neural networks.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 11: Neural networks are robust to noise in the input data. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'False', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Neural networks are robust to noise in the input data.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 12: A higher learning rate can sometimes cause the model to overshoot the optimal solution. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'A higher learning rate can sometimes cause the model to overshoot the optimal solution.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 13: Neural networks cannot be used for regression tasks. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'False', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Neural networks cannot be used for regression tasks.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 14: Training a neural network requires labeled data. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'True', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'Training a neural network requires labeled data.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';

-- Question 15: A feedforward neural network has cycles in its connections. (Instructor: Emily Davis)
EXEC InsertQuestion 
    @Type = 'TrueOrFalse', 
    @CorrectChoice = 'False', 
    @InstructorID = 11, 
    @CourseID = 18, -- Artificial Intelligence
    @QuestionText = 'A feedforward neural network has cycles in its connections.', 
    @QuestionID = @QuestionID OUTPUT;

EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'True';
EXEC insertQuestionBankChoice @questionID = @QuestionID, @choice = 'False';