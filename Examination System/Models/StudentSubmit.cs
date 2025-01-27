using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class StudentSubmit
{
    public int Id { get; set; }

    public int StudentId { get; set; }

    public int ExamModelId { get; set; }

    public bool? IsDeleted { get; set; }

    public DateTime? SubmitDate { get; set; }

    public virtual ExamModel ExamModel { get; set; } = null!;

    public virtual Student Student { get; set; } = null!;

    public virtual ICollection<StudentSubmitAnswer> StudentSubmitAnswers { get; set; } = new List<StudentSubmitAnswer>();
}
