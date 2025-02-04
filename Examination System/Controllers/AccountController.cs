using System.Security.Claims;
using Examination_System.Data;
using Examination_System.Models;
using Examination_System.ViewModels;
using Lec1_P2.ViewModel;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Examination_System.Controllers
{
    public class AccountController : Controller
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly StudentExaminationSystemContext _context;


        public AccountController(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager,StudentExaminationSystemContext context )
        {
            _context = context;
            _userManager = userManager;
            _signInManager = signInManager;
        }


        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Register(RegisterUserViewModel userViewModel)
        {
            if (ModelState.IsValid)
            {
                // Check if the email matches a student or instructor in the database
                var student = await _context.Students.FirstOrDefaultAsync(s => s.Email == userViewModel.Email);
                var instructor = await _context.Instructors.FirstOrDefaultAsync(i => i.Email == userViewModel.Email);

                if (student == null && instructor == null)
                {
                    ModelState.AddModelError("", "Email does not match any registered student or instructor.");
                    return View("Register", userViewModel);
                }

                // Mapping RegisterUserViewModel to ApplicationUser
                ApplicationUser user = new ApplicationUser
                {
                    UserName = userViewModel.UserName,
                    Email = userViewModel.Email
                };

                // Save to database
                IdentityResult result = await _userManager.CreateAsync(user, userViewModel.Password);
                if (!result.Succeeded)
                {
                    foreach (var error in result.Errors)
                    {
                        ModelState.AddModelError("", error.Description);
                    }
                    return View("Register", userViewModel);
                }

                // Assign role based on email match
                if (student != null)
                {
                    await _userManager.AddToRoleAsync(user, "Student");
                }
                else if (instructor != null)
                {
                    await _userManager.AddToRoleAsync(user, "Instructor");
                }

                return RedirectToAction("Login", "Account");
            }

            return View("Register", userViewModel);
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> SaveLogin(LoginUserViewModel loginViewModel)
        {
            if (ModelState.IsValid) 
            {
                // Check if the user exists
                ApplicationUser appUser = await _userManager.FindByEmailAsync(loginViewModel.Email);

                if (appUser != null)
                {
                    // Verify the password
                    bool found = await _userManager.CheckPasswordAsync(appUser, loginViewModel.Password);

                    Student? student = await _context.Students.FirstOrDefaultAsync(s => s.Email == loginViewModel.Email);
                    Instructor? instructor = await _context.Instructors.FirstOrDefaultAsync(i => i.Email == loginViewModel.Email);
                    if (found )
                    {
                        if(student?.IsDeleted==false || instructor?.IsDeleted==false)
                        {
                            List<Claim> claims = new List<Claim>();
                            claims.Add(new Claim("DatabaseUserId", appUser.Email));

                            if (student != null)
                            {
                                claims.Add(new Claim("StudentId", student.Id.ToString()));
                                claims.Add(new Claim("FirstName", student.FirstName)); // Add firstName claim
                            }
                            else if (instructor != null)
                            {
                                claims.Add(new Claim("InstructorId", instructor.Id.ToString()));
                                claims.Add(new Claim("FirstName", instructor.FirstName)); // Add firstName claim
                            }

                            // Sign in the user with the claims
                            await _signInManager.SignInWithClaimsAsync(appUser, isPersistent: false, claims);
                            return RedirectToAction("Index", "Home");

                        }
                        else
                        {
                            ModelState.AddModelError("","User Not Found");
                        }

                    }
                    else
                    {
                        ModelState.AddModelError("", "Invalid User Name or Password");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "User not found");
                }
            }

            // If we reach here, something went wrong; redisplay the form
            return View("Login", loginViewModel);
        }
        public async Task<IActionResult> SignOut()
        {
            await _signInManager.SignOutAsync();
            return RedirectToAction("Login", "Account");
        }

    }
}
