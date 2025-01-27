using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class Instructor
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

    public bool? IsDeleted { get; set; }

    public virtual Branch? Branch { get; set; }

    public virtual ICollection<BranchDepartmentTrack> BranchDepartmentTrackDepartmentManagers { get; set; } = new List<BranchDepartmentTrack>();

    public virtual ICollection<BranchDepartmentTrack> BranchDepartmentTrackTrackManagers { get; set; } = new List<BranchDepartmentTrack>();

    public virtual ICollection<CourseStudentInstructor> CourseStudentInstructors { get; set; } = new List<CourseStudentInstructor>();

    public virtual ICollection<DepartmentInstructor> DepartmentInstructors { get; set; } = new List<DepartmentInstructor>();

    public virtual ICollection<ExamModel> ExamModels { get; set; } = new List<ExamModel>();

    public virtual ICollection<QuestionBank> QuestionBanks { get; set; } = new List<QuestionBank>();

    public virtual ICollection<Course> Courses { get; set; } = new List<Course>();
}
