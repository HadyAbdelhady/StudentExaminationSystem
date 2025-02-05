namespace Examination_System.ViewModels
{
    public class StudentSubmitViewModel
    {
        public int StudentSubmitId { get; set; }
        public int StudentId { get; set; }
        public int InstructorId { get; set; }   
        public string? StudentName { get; set; }
        public string? InstructorName {  get; set; }
        public DateTime? submitDate {get; set; }
        public string? CourseName { get; set; }
        public int ExamModelId { get; set; }
    }
}
