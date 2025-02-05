using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class Branch
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Location { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public DateTime? EstablishmentDate { get; set; }

    public int ManagerId { get; set; }

    public bool? IsDeleted { get; set; }

    public virtual ICollection<BranchDepartmentTrack> BranchDepartmentTracks { get; set; } = new List<BranchDepartmentTrack>();

    public virtual Instructor Manager { get; set; } = null!;
}
