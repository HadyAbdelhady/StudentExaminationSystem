using Examination_System.DTOs;
using Examination_System.Models;

namespace Examination_System.ViewModels
{
    public class InstructorDetailsViewModel
    {
        public int Id { get; set; }

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string? Gender { get; set; }

        public string Ssn { get; set; } = null!;

        public DateTime EnrollmentDate { get; set; }

        public string Email { get; set; } = null!;

        public string Phone { get; set; } = null!;

        public DateOnly DateOfBirth { get; set; }

        public string Address { get; set; } = null!;

        public List<InstructorCourseInfo> Courses { get; set; } = new List<InstructorCourseInfo>();

        public List<Course> AvailableCourses { get; set; } = new List<Course>();





    }
}
