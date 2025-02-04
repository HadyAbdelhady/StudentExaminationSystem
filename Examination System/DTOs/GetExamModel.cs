namespace Examination_System.DTOs
{
    public class GetExamModel
    {
        public int? Id { get; set; }

        public DateOnly Date { get; set; }

        public TimeOnly StartTime { get; set; }

        public TimeOnly EndTime { get; set; }

        public int CourseId { get; set; }

        public int InstructorId { get; set; }

        public string firstName { get; set; }

        public string lastName { get; set; }

        public string courseName { get; set; }

        public DateTime? CreationDate { get; set; }
    }
}
