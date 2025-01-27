using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class QuestionBank
{
    public int Id { get; set; }

    public string Type { get; set; } = null!;

    public string CorrectChoice { get; set; } = null!;

    public int InstructorId { get; set; }

    public int CourseId { get; set; }

    public DateTime? InsertionDate { get; set; }

    public string QuestionText { get; set; } = null!;

    public bool? IsDeleted { get; set; }

    public virtual Course Course { get; set; } = null!;

    public virtual ICollection<ExamModelQuestion> ExamModelQuestions { get; set; } = new List<ExamModelQuestion>();

    public virtual Instructor Instructor { get; set; } = null!;

    public virtual ICollection<QuestionBankChoice> QuestionBankChoices { get; set; } = new List<QuestionBankChoice>();
}
