using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class BranchDepartmentTrack
{
    public int BranchId { get; set; }

    public int TrackId { get; set; }

    public int DepartmentId { get; set; }

    public DateTime CreationDate { get; set; }

    public int DepartmentManagerId { get; set; }

    public int TrackManagerId { get; set; }

    public DateTime DepartementManagerJoinDate { get; set; }

    public DateTime TrackManagerJoinDate { get; set; }

    public bool? IsDeleted { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual Department Department { get; set; } = null!;

    public virtual Instructor DepartmentManager { get; set; } = null!;

    public virtual ICollection<Student> Students { get; set; } = new List<Student>();

    public virtual Track Track { get; set; } = null!;

    public virtual Instructor TrackManager { get; set; } = null!;
}
