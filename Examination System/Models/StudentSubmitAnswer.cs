using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class StudentSubmitAnswer
{
    public int StudentSubmitId { get; set; }

    public int ExamModelId { get; set; }

    public int QuestionId { get; set; }

    public string StudentAnswer { get; set; } = null!;

    public bool? IsDeleted { get; set; }

    public virtual ExamModelQuestion ExamModelQuestion { get; set; } = null!;

    public virtual StudentSubmit StudentSubmit { get; set; } = null!;
}
