namespace Examination_System.DTOs
{
    public class GetCoursesInTrack
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public DateTime? CreationDate { get; set; }
    }
}
