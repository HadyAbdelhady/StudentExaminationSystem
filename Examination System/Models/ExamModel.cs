using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class ExamModel
{
    public int Id { get; set; }

    public DateOnly Date { get; set; }

    public TimeOnly StartTime { get; set; }

    public TimeOnly EndTime { get; set; }

    public int CourseId { get; set; }

    public int InstructorId { get; set; }

    public DateTime? CreationDate { get; set; }

    public bool? IsDeleted { get; set; }

    public virtual Course Course { get; set; } = null!;

    public virtual ICollection<ExamModelQuestion> ExamModelQuestions { get; set; } = new List<ExamModelQuestion>();

    public virtual Instructor Instructor { get; set; } = null!;

    public virtual ICollection<StudentSubmit> StudentSubmits { get; set; } = new List<StudentSubmit>();
}
