using System.ComponentModel.DataAnnotations;

namespace Examination_System.ViewModels
{
    public class RegisterUserViewModel
    {
        public string UserName { get; set; } = null!;
        [DataType(DataType.Password)]
        public string Password { get; set; } = null!;
        [ Compare("Password", ErrorMessage = "Password and Confirm Password must match")]
        [Display(Name = "Confirm Password")]
        [DataType(DataType.Password)]
        public string ConfirmPassword { get; set; } = null!;
        public string Email { get; set; } = null!;


    }
}
