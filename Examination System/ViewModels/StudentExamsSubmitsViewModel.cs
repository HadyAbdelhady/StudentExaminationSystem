using Examination_System.Models;

namespace Examination_System.ViewModels
{
    public class StudentExamsSubmitsViewModel
    {
        public List <Course>? Courses {  get; set; }
        public List <ExamModel>? Exams { get; set; }
        public Dictionary<StudentSubmit,(int,int)>? Submits { get; set; }
    }
}
