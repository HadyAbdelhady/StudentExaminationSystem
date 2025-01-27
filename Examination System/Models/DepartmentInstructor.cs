using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class DepartmentInstructor
{
    public int DepartmentId { get; set; }

    public int InstructorId { get; set; }

    public DateTime JoinDate { get; set; }

    public virtual Department Department { get; set; } = null!;

    public virtual Instructor Instructor { get; set; } = null!;
}
