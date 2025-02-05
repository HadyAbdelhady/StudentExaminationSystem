namespace Examination_System.DTOs
{
    public class GetTracksPerBranch
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public int DepartmentId { get; set; }

        public DateTime CreationDate { get; set; }
    }
}
