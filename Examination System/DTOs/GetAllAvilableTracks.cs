namespace Examination_System.DTOs
{
    public class GetAllAvilableTracks
    {
        public int BranchId { get; set; }

        public int TrackId { get; set; }

        public int DepartmentId { get; set; }

        public DateTime CreationDate { get; set; }

        public int DepartmentManagerId { get; set; }

        public int TrackManagerId { get; set; }

        public DateTime DepartementManagerJoinDate { get; set; }

        public DateTime TrackManagerJoinDate { get; set; }

        public string? TrackName { get; set; }

        public string? BranchName { get; set; }

        public string? DepartmentName { get; set;}
    }
}
