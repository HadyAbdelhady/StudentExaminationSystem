namespace Examination_System.ViewModels
{
    public class QuestionBankViewModel
    {
        public Question QuestionData { get; set; } = new Question(); // Set to public

        public List<QuestionChoice> Choices { get; set; } = new List<QuestionChoice>(); // Set to public

        public class Question
        {
            public int Id { get; set; }
            public string Type { get; set; } = null!;

            public string CorrectChoice { get; set; } = null!;

            public int instructorId { get; set; }

            public string InstructorName { get; set; }
            public int courseId { get; set; }

            public string CourseName { get; set; }

            public DateTime? InsertionDate { get; set; }

            public string QuestionText { get; set; } = null!;
        }

        public class QuestionChoice
        {
            public string Choice { get; set; } = null!;
        }



    }
}