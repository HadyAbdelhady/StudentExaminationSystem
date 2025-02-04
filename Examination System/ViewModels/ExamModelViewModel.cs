using Examination_System.DTOs;
using Examination_System.Models;

namespace Examination_System.ViewModels
{
    public class ExamModelViewModel
    {
        public int Id { get; set; }

        public DateOnly Date { get; set; }

        public TimeOnly StartTime { get; set; }

        public TimeOnly EndTime { get; set; }

        public int CourseId { get; set; }

        public int InstructorId { get; set; }

        public DateTime? CreationDate { get; set; }

        public ICollection<GetQuestionsWithOptions> questions { get; set; } = new List<GetQuestionsWithOptions>();

        public ICollection<GetAllInstructors> instructors { get; set; }

        public int examModelId { get; set; }

        public List<int>? questionIdList { get; set; }

    }
}
