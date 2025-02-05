using System.Data;
using Examination_System.Data;
using Examination_System.DTOs;
using Examination_System.Models;
using Examination_System.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.Blazor;

namespace Examination_System.Controllers
{
    [Authorize(Roles = "Instructor , Admin")]
    public class InstructorController : Controller
    {

        private readonly StudentExaminationSystemContext _context;

        public InstructorController(StudentExaminationSystemContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Index(int? id)
        {
            if (id != null)
            {
                var instructorDetails = _context.Instructors
                    .FromSqlRaw("EXEC selectInstructor @inputID", new SqlParameter("@inputID", id))
                    .AsEnumerable()
                    .FirstOrDefault();

                if (instructorDetails == null)
                {
                    return NotFound();
                }

                var instructorCourses = _context.Database
                    .SqlQuery<InstructorCourseInfo>($"EXEC GetInstructorCoursesWithStudentCount @instructorID= {id}")
                    .ToList();

                var getAllCourses = _context.Courses
                    .FromSqlRaw("EXEC GetCourse")
                    .ToList();

                var availableCourses = getAllCourses.Where(c => instructorCourses.All(ic => ic.CourseId != c.Id)).ToList();

                // Create the view model
                var viewModel = new InstructorDetailsViewModel
                {
                    Id = instructorDetails.Id,
                    FirstName = instructorDetails.FirstName,
                    LastName = instructorDetails.LastName,
                    Gender = instructorDetails.Gender,
                    Ssn = instructorDetails.Ssn,
                    EnrollmentDate = instructorDetails.EnrollmentDate,
                    Email = instructorDetails.Email,
                    Phone = instructorDetails.Phone,
                    DateOfBirth = instructorDetails.DateOfBirth,
                    Address = instructorDetails.Address,
                    Courses = instructorCourses,
                    AvailableCourses = availableCourses
                };

                return View("Details", viewModel);
            }

            var GetAllInstracturs = _context.Database.SqlQuery<GetAllInstructors>($"GetAllInstructors").ToList();

            return View(GetAllInstracturs);
        }
        
        [Authorize(Roles = "Admin")]
        public IActionResult Update(int id)
        {
            Instructor instructor = _context.Instructors.FirstOrDefault(i => i.Id == id);
            return View("Update",instructor);
        }
        [Authorize(Roles = "Admin")]
        public IActionResult SaveUpdate(Instructor instructors)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // Define the stored procedure name and parameters
                    string storedProcedure = "updateInstructorData";
                    var parameters = new[]
                    {
                        new SqlParameter("@Id", instructors.Id),
                        new SqlParameter("@fName", instructors.FirstName),
                        new SqlParameter("@lName", instructors.LastName),
                        new SqlParameter("@Gender", instructors.Gender),
                        new SqlParameter("@ssn", instructors.Ssn),
                        new SqlParameter("@mail", instructors.Email),
                        new SqlParameter("@mobilePhone", instructors.Phone),
                        new SqlParameter("@enrollDate", instructors.EnrollmentDate),
                        new SqlParameter("@DOB", instructors.DateOfBirth.ToDateTime(TimeOnly.MinValue)), // Convert DateOnly to DateTime
                        new SqlParameter("@homeAt", instructors.Address)
                    };

                    _context.Database.ExecuteSqlRaw($"EXEC {storedProcedure} @Id, @fName, @lName, @Gender, @ssn, @mail, @mobilePhone, @enrollDate, @DOB, @homeAt", parameters);

                    return RedirectToAction(nameof(Index));
                }
                catch (SqlException ex)
                {

                    ModelState.AddModelError("", "An error occurred while saving the instructor: " + ex.Message);
                    return View("Update", instructors);
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "An unexpected error occurred: " + ex.Message);
                    return View("Update", instructors);
                }
            }

            return View("Update", instructors);

        }

        [Authorize(Roles = "Admin")]
        public IActionResult Create()
        {
            return View();
        }

        // POST: Instructor/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public IActionResult Create(Instructor instructors)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string storedProcedure = "insertInstructor";
                    var parameters = new[]
                    {
                        new SqlParameter("@fName", instructors.FirstName),
                        new SqlParameter("@lName", instructors.LastName),
                        new SqlParameter("@Gender", instructors.Gender),
                        new SqlParameter("@ssn", instructors.Ssn),
                        new SqlParameter("@mail", instructors.Email),
                        new SqlParameter("@mobilePhone", instructors.Phone),
                        new SqlParameter("@enrollDate", instructors.EnrollmentDate),
                        new SqlParameter("@DOB", instructors.DateOfBirth.ToDateTime(TimeOnly.MinValue)),
                        new SqlParameter("@homeAt", instructors.Address)
                    };

                    _context.Database.ExecuteSqlRaw($"EXEC {storedProcedure} @fName, @lName, @Gender, @ssn, @mail, @mobilePhone, @enrollDate, @DOB, @homeAt", parameters);

                    return RedirectToAction(nameof(Index));
                }
                catch (SqlException ex)
                {
                    
                    ModelState.AddModelError("", "An error occurred while saving the instructor: " + ex.Message);
                    return View("Create", instructors);
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "An unexpected error occurred: " + ex.Message);
                    return View("Create", instructors);
                }
            }

            return View("Create", instructors);
        }

        [Authorize(Roles = "Admin")]
        public IActionResult Delete(int id)
        {
            try
            {
                string storedProcedure = "deleteInstructor";
                var parameters = new[] { new SqlParameter("@Id", id) };

                _context.Database.ExecuteSqlRaw($"EXEC {storedProcedure} @Id", parameters);

                return RedirectToAction(nameof(Index));
            }
            catch (SqlException ex)
            {
                ModelState.AddModelError("", "An error occurred while deleting the instructor: " + ex.Message);
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An unexpected error occurred: " + ex.Message);
                return RedirectToAction(nameof(Index));
            }
        }



        [HttpPost]
        [Authorize(Roles = "Admin")]
        public IActionResult AssignToCourse(  int Id,int courseId)
        {
           
                try
                {                    
                        var instructor = _context.Instructors
                                                .Include(i => i.Courses) 
                                                .FirstOrDefault(i => i.Id == Id);

                        if (instructor == null)
                        {
                            ModelState.AddModelError("", "Instructor not found.");
                            return RedirectToAction("Index", new { id = Id });
                        }

                        var course = _context.Courses
                                            .FirstOrDefault(c => c.Id == courseId);

                        if (course == null)
                        {
                            ModelState.AddModelError("", "Course not found.");
                            return RedirectToAction("Index", new { id = Id });
                        }

                        if (instructor.Courses.Any(c => c.Id == courseId))
                        {
                            ModelState.AddModelError("", "Instructor is already assigned to this course.");
                            return RedirectToAction("Index", new { id = Id });
                        }

                        instructor.Courses.Add(course);
                        _context.SaveChanges();

                    return RedirectToAction("Index", new { id = Id });
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "An unexpected error occurred: " + ex.Message);
                    return RedirectToAction("Index", new { id = Id });
                }

        }
        [Authorize(Roles = "Admin")]
        public IActionResult RemoveCourse(int Id, int courseId)
        {
            try
            {
                var instructor = _context.Instructors
                                     .Include(i => i.Courses)
                                     .FirstOrDefault(i => i.Id == Id);

                if (instructor == null)
                {
                    ModelState.AddModelError("", "Instructor not found.");
                    return RedirectToAction("Index", new { id = Id });
                }

                
                var course = _context.Courses
                                    .FirstOrDefault(c => c.Id == courseId);

                if (course == null)
                {
                    ModelState.AddModelError("", "Course not found.");
                    return RedirectToAction("Index", new { id = Id });
                }

                if (!instructor.Courses.Any(c => c.Id == courseId))
                {
                    ModelState.AddModelError("", "Instructor is not assigned to this course.");
                    return RedirectToAction("Index", new { id = Id });
                }

              
                instructor.Courses.Remove(course);
                _context.SaveChanges();

                return RedirectToAction("Index", new { id = Id });
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An unexpected error occurred: " + ex.Message);
                return RedirectToAction("Index", new { id = Id });
            }
        }


    }

}
