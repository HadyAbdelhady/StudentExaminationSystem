namespace Examination_System.DTOs
{
    public class GetAllBranches
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string Location { get; set; } = null!;

        public string Phone { get; set; } = null!;

        public DateTime? EstablishmentDate { get; set; }

        public int ManagerId { get; set; }
    }
}
