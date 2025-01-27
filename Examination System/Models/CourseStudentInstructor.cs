using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class CourseStudentInstructor
{
    public int CourseId { get; set; }

    public int StudentId { get; set; }

    public int InstructorId { get; set; }

    public DateTime StartDate { get; set; }

    public virtual Course Course { get; set; } = null!;

    public virtual Instructor Instructor { get; set; } = null!;

    public virtual Student Student { get; set; } = null!;
}
