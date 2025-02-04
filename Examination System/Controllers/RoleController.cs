using Examination_System.DTOs;
using Examination_System.Models;
using Lec1_P2.ViewModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Lec1_P2.Controllers
{
    [Authorize(Roles= "Admin")]
    public class RoleController : Controller
    {
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly UserManager<ApplicationUser> _userManager;
        public RoleController(RoleManager<IdentityRole> roleManager,UserManager<ApplicationUser> userManager )
        {
            _userManager = userManager;
            _roleManager = roleManager;
        }
        [HttpGet]
        public IActionResult AddRole()
        {

            return View("AddRole");
        }

        public async Task<IActionResult> SaveRole(RoleViewModel ruleViewModel)
        {
            if (ModelState.IsValid)
            {

                IdentityRole role = new IdentityRole();
                role.Name = ruleViewModel.RoleName;
                // Save to database
                IdentityResult result = await _roleManager.CreateAsync(role);

                if (result.Succeeded)
                {
                    ViewBag.Message = "Role Created Successfully";
                    return View("AddRole");
                }
                foreach (var error in result.Errors)
                {
                    ModelState.AddModelError("", error.Description);
                }
            }
            return View("AddRole", ruleViewModel);

        }


        public IActionResult AssignRole()
        {
            var users = _userManager.Users.ToList();
            var roles = _roleManager.Roles.ToList();
            AssignUserRole assignUserRole = new AssignUserRole();
            foreach (var user in users)
            {
                assignUserRole.Users.Add(user.UserName);
            }
            foreach (var role in roles)
            {
                assignUserRole.Roles.Add(role.Name);
            }
            return View("AssignRole",assignUserRole);
        }

        [HttpPost]
        public IActionResult AssignRole(AssignUserRole model)
        {
            if (!ModelState.IsValid)
            {
                return View("AssignRole", model); // Return the view with the same model to display errors
            }

            var user = _userManager.FindByNameAsync(model.SelectedUser).Result;
            if (user == null)
            {
                ModelState.AddModelError("", "User not found");
                return View("AssignRole", model);
            }

            var result = _userManager.AddToRoleAsync(user, model.SelectedRole).Result;
            if (result.Succeeded)
            {
                ViewBag.Message = "Role Assigned Successfully";
                return RedirectToAction("AssignRole"); // Redirect to refresh the form
            }

            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error.Description);
            }

            return View("AssignRole", model);
        }



    }
}
