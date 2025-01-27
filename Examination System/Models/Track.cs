using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class Track
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public bool? IsDeleted { get; set; }

    public int DepartmentId { get; set; }

    public DateTime CreationDate { get; set; }

    public virtual ICollection<BranchDepartmentTrack> BranchDepartmentTracks { get; set; } = new List<BranchDepartmentTrack>();

    public virtual Department Department { get; set; } = null!;

    public virtual ICollection<Course> Courses { get; set; } = new List<Course>();
}
