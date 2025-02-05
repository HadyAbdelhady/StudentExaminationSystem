using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class Department
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public DateTime? CreationDate { get; set; }

    public bool? IsDeleted { get; set; }

    public virtual ICollection<BranchDepartmentTrack> BranchDepartmentTracks { get; set; } = new List<BranchDepartmentTrack>();

    public virtual ICollection<DepartmentInstructor> DepartmentInstructors { get; set; } = new List<DepartmentInstructor>();

    public virtual ICollection<Track> Tracks { get; set; } = new List<Track>();
}
