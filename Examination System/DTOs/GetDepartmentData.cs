using System.ComponentModel.DataAnnotations.Schema;

namespace Examination_System.DTOs
{
    public class GetDepartmentData
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public DateTime? CreationDate { get; set; }
    }
}
