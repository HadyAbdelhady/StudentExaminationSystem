using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class ExamModelQuestion
{
    public int ExamModelId { get; set; }

    public int QuestionId { get; set; }

    public int Mark { get; set; }

    public string CorrectChoice { get; set; } = null!;

    public virtual ExamModel ExamModel { get; set; } = null!;

    public virtual QuestionBank Question { get; set; } = null!;

    public virtual ICollection<StudentSubmitAnswer> StudentSubmitAnswers { get; set; } = new List<StudentSubmitAnswer>();
}
