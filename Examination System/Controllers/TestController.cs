using Microsoft.AspNetCore.Mvc;

namespace Examination_System.Controllers
{
    public class TestController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
