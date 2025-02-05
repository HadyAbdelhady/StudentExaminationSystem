namespace Examination_System.DTOs
{
    public class InsertQuestion
    {
        public Question QuestionData { get; set; } = new Question(); // Set to public

        public List<QuestionChoice> Choices { get; set; } = new List<QuestionChoice>(); // Set to public

        public class Question
        {
            public string Type { get; set; } = null!;

            public string CorrectChoice { get; set; } = null!;

            public int InstructorId { get; set; }

            public int CourseId { get; set; }

            public string QuestionText { get; set; } = null!;
        }

        public class QuestionChoice
        {
            public string Choice { get; set; } = null!;
        }
    }
}
