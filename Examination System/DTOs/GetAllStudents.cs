using Examination_System.Models;

namespace Examination_System.DTOs
{
    public class GetAllStudents
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

        public int TrackId { get; set; }

        public int BranchId { get; set; }

        public int DepartmentId { get; set; }
        public string BranchName { get; set; }
        public string TrackName { get; set; }
        public string DepartmentName { get; set; }
    }
}
