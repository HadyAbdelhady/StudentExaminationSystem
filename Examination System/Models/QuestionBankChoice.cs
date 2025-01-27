using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class QuestionBankChoice
{
    public int QuestionId { get; set; }

    public string Choice { get; set; } = null!;

    public bool? IsDeleted { get; set; }

    public virtual QuestionBank Question { get; set; } = null!;
}
