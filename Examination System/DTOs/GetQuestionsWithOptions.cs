namespace Examination_System.DTOs
{
    public class GetQuestionsWithOptions
    {
        public int QuestionId { get; set; }
        public string? QuestionText { get; set; }
        public string? ModelAnswer { get; set; } = null;
        public string? OptionOne { get; set; }
        public string? OptionTwo { get; set; }
        public string? OptionThree { get; set; }
        public string? OptionFour { get; set; }
    }
}
