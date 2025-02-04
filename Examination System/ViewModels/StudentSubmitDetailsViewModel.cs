using Examination_System.DTOs;

namespace Examination_System.ViewModels
{
    public class StudentSubmitDetailsViewModel
    {
            public int QuestionID { get; set; }
            public string? QuestionText { get; set; }
            public string? StudentAnswer { get; set; }
            public string? CorrectChoice { get; set; }
            public int Mark { get; set; }
            public string? OptionOne { get; set; }
            public string? OptionTwo { get; set; }
            public string? OptionThree { get; set; }
            public string? OptionFour { get; set; }
            public string? AnswerStatus { get; set; }
    }
}
