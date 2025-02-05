using Examination_System.DTOs;
using Examination_System.Models;

namespace Examination_System.ViewModels
{
    public class StudentDetailsViewModel
    {
        public GetAllStudents? Student {  get; set; }
        public List<CourseStudentInstructorDetails>? CourseStudentInstructorDetails { get; set; }
        public List<AvilableCourses>? AvilableCourses { get; set; }
        public List <Instructor>? AvilableInstructors {  get; set; } 
    }
    public class CourseStudentInstructorDetails
    {
        public int InstructorId { get; set; }
        public int StudentId { get; set; }
        public int courseId { get; set; }
        public string? CourseName { get; set; }
        public string? firstName { get; set; } // Instructor First Name
        public string? lastName { get; set; } // Instructor Last Name
        public DateTime? StartDate { get; set; }
    }
    public class AvilableCourses
    {
        public int? CourseId { get; set; }
        public string? CourseName { get; set; }
    }
    
}
