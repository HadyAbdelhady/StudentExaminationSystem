using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class CourseTopic
{
    public int CourseId { get; set; }

    public string Topic { get; set; } = null!;

    public DateTime? CreationDate { get; set; }

    public bool? IsDeleted { get; set; }

    public virtual Course Course { get; set; } = null!;
}
