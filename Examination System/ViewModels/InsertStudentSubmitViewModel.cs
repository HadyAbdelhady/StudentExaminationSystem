using Examination_System.DTOs;

namespace Examination_System.ViewModels
{
    public class InsertStudentSubmitViewModel
    {
        public List<GetQuestionsWithOptions>? Questions;
        public List<string>? StudentAnswers;
        public int ExamModelId { get; set; } = 0;
        public int StudentId { get; set; } = 0;
    }
}
