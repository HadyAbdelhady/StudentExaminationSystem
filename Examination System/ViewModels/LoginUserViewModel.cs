using System.ComponentModel.DataAnnotations;

namespace Lec1_P2.ViewModel
{
    public class LoginUserViewModel
    {
        [Required(ErrorMessage ="*")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        [Required(ErrorMessage = "*")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        [Display(Name = "Remember Me!")]
        public bool RememberMe { get; set; }
    }
}
