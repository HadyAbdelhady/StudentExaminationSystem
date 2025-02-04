using System.ComponentModel.DataAnnotations;

namespace Lec1_P2.ViewModel
{
    public class RoleViewModel
    {
        [Display(Name ="Rule Name")]
        public string RoleName { get; set; }
    }
}
