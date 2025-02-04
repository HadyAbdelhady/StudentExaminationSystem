namespace Examination_System.DTOs
{
    public class AssignUserRole
    {
        public List<string> Users { get; set; } // List of all users
        public List<string> Roles { get; set; } // List of all roles

        public string SelectedUser { get; set; } // User selected from dropdown
        public string SelectedRole { get; set; } // Role selected from dropdown

        public AssignUserRole()
        {
            Users = new List<string>();
            Roles = new List<string>();
        }
    }
}
