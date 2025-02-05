using Azure.Core;
using Examination_System.Data;
using Examination_System.DTOs;
using Examination_System.Models;
using Examination_System.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Examination_System.Controllers
{
    [Authorize(Roles = "Admin , Instructor")]
    public class StudentController : Controller
    {
        private readonly StudentExaminationSystemContext _context;
        public StudentController(StudentExaminationSystemContext context, IConfiguration configuration)
        {
            _context = context;
        }
        public IActionResult Index(int? id)
        {
            try
            {

            if (id != null)
            {
                var studentInList = _context.Database.SqlQuery<GetAllStudents>($"GetStudentById @studentId = {id};").ToList();
                if(studentInList.Count  > 0 )
                {
                    var student = studentInList.First();
                    StudentDetailsViewModel studentDetails = new StudentDetailsViewModel();
                    studentDetails.Student = student;
                    studentDetails.CourseStudentInstructorDetails = _context.Database.SqlQuery<CourseStudentInstructorDetails>($"GetCoursesEnrolledByStudent @studentID = {id}").ToList();
                    studentDetails.AvilableCourses = _context.Database.SqlQuery<AvilableCourses>($"GetCoursesNotEnrolledByStudent @studentID = {id}").ToList();
                    studentDetails.AvilableInstructors = _context.Instructors.ToList();
                    return View("Student", studentDetails);
                } else
                {
                    return View("Error");
                }
            }
                var students = _context.Database.SqlQuery<GetAllStudents>($"GetAllStudents").ToList();
                ViewBag.Message = $"All students in all branches";
                return View("Students", students);
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }
        public IActionResult Department(int? id)
        {
            try
            {

                var students = _context.Database.SqlQuery<GetAllStudents>($"GetAllStudentsInDepartment @departmentID = {id};").ToList();
                string departmentName = _context.Departments.Where(dept => dept.Id == id).First().Name;
                ViewBag.Message = $"All students in {departmentName} department";
                return View("Students", students);
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }
        public IActionResult Track(int? id)
        {
            try
            {
                var students = _context.Database.SqlQuery<GetAllStudents>($"GetAllStudentsInTrack @trackID = {id};").ToList();
                string trackName = _context.Tracks.Where(track => track.Id == id).First().Name;
                ViewBag.Message = $"All students in {trackName} track";
                return View("Students", students);
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }
        public IActionResult Branch(int? id)
        {
            try
            {
                var students = _context.Database.SqlQuery<GetAllStudents>($"GetAllStudentsInBranch @branchID = {id};").ToList();
                string branchName = _context.Branches.Where(branch => branch.Id == id).First().Name;
                ViewBag.Message = $"All students in {branchName} branch";
                return View("Students", students);
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }
        public IActionResult Instructor(int id)
        {
            try
            {
                var students = _context.Database.SqlQuery<GetAllStudents>($"GetAllStudentsPerInstructor @instructorId = {id};").ToList();
                string instructorName = _context.Instructors.Where(inst => inst.Id == id).First().FirstName + " ";
                instructorName +=  _context.Instructors.Where(inst => inst.Id == id).First().LastName;
                ViewBag.Message = $"All students enrolled with {instructorName}.";
                return View("Students", students);
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        } 
        public IActionResult Course(int id)
        {
            var students = _context.Database.SqlQuery<GetAllStudents>($"GetAllStudentsInCourse @courseId = {id};").ToList();
            return View("Students", students);
        }
        [Route("Student/CourseInstructor/{CourseId}/{InstructorId}")]
        public IActionResult CourseInstructor(int CourseId , int InstructorId)
        {
            try
            {
                var students = _context.Database.SqlQuery<GetAllStudents>($"GetAllStudentsInCourseAndInstructor @courseId = {CourseId}, @instructorId = {InstructorId};").ToList();
                string instructorName = _context.Instructors.Where(inst => inst.Id == InstructorId).First().FirstName + " ";
                instructorName += _context.Instructors.Where(inst => inst.Id == InstructorId).First().LastName;
                string courseName = _context.Courses.Where(c => c.Id == CourseId).First().Name;
                ViewBag.Message = $"All students enrolled with {instructorName} in {courseName} course";
                return View("Students", students);
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }

        [Authorize(Roles = "Admin")]
        public IActionResult Create()
        {
            try
            {
                var BranchDepartmentTracks = _context.Database.SqlQuery<GetAllAvilableTracks>($"EXEC GetAllAvilableTracks;").ToList();
                InsertStudentViewModel student = new InsertStudentViewModel();
                student.BranchDepartmentTracks = BranchDepartmentTracks;
                return View("create", student);
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }
        
        [Authorize(Roles = "Admin")]
        public IActionResult SaveCreate(InsertStudentViewModel student)
        {
            //try
            //{
            //_context.Database.SqlQuery<int>(
            //    $" InsertStudent @firstName ={student.FirstName}, @lastName={student.LastName}, @gender ={student.Gender} ,@SSN = {student.Ssn}, @enrollmentDate = {student.EnrollmentDate} ,@Email = {student.Email}, @Phone = {student.Phone},@DateOfBirth = {student.DateOfBirth},@address = {student.Address}, @trackID = {student.TrackId}, @branchId = {student.BranchId}, @departmentID = {student.DepartmentId};").ToList();
            //return RedirectToAction(nameof(Index));
            //}
            //catch (Exception ex)
            //{
            //    return HandleError(ex);
            //}
            Student newStudent = new Student();
            newStudent.FirstName = student.FirstName;
            newStudent.LastName = student.LastName;
            newStudent.Email = student.Email;
            newStudent.Address = student.Address;
            newStudent.Ssn = student.Ssn;
            newStudent.BranchId = student.BranchId;
            newStudent.DepartmentId = student.DepartmentId;
            newStudent.TrackId = student.TrackId;
            newStudent.Gender = student.Gender;
            newStudent.DateOfBirth = student.DateOfBirth;
            newStudent.EnrollmentDate = student.EnrollmentDate;
            newStudent.Phone = student.Phone;
            _context.Students.Add(newStudent);

            _context.SaveChanges();
            return RedirectToAction(nameof(Index));
        }
        
        [Authorize(Roles = "Admin")]
        public IActionResult Update(int id)
        {
            try
            {
                var studentInList = _context.Database.SqlQuery<GetAllStudents>($"GetStudentById @studentId = {id};").ToList();
                if (studentInList.Count > 0)
                {
                    var student = studentInList.First();
                    StudentDetailsViewModel studentDetails = new StudentDetailsViewModel();
                    studentDetails.Student = student;
                    studentDetails.CourseStudentInstructorDetails = _context.Database.SqlQuery<CourseStudentInstructorDetails>($"GetCoursesEnrolledByStudent @studentID = {id}").ToList();
                    studentDetails.AvilableCourses = _context.Database.SqlQuery<AvilableCourses>($"GetCoursesNotEnrolledByStudent @studentID = {id}").ToList();
                    studentDetails.AvilableInstructors = _context.Instructors.ToList();
                    

                    var branchesDeptsTracks = _context.Database.SqlQuery<GetAllAvilableTracks>($"EXEC GetAllAvilableTracks;").ToList();

                    var viewModel = new UpdateStudentViewModel
                    {
                        Id = student.Id,
                        FirstName = student.FirstName,
                        LastName = student.LastName,
                        Gender = student.Gender,
                        Ssn = student.Ssn,
                        EnrollmentDate = student.EnrollmentDate,
                        Email = student.Email,
                        Phone = student.Phone,
                        DateOfBirth = student.DateOfBirth,
                        Address = student.Address,
                        TrackId = student.TrackId,
                        DepartmentId = student.DepartmentId,
                        BranchId = student.BranchId,
                        BranchDepartmentTracks = branchesDeptsTracks
                    };
                return View(viewModel);
                }
                else
                {
                    return View("Error");
                }
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }

        }

        [Authorize(Roles = "Admin")]
        public IActionResult saveUpdate(UpdateStudentViewModel student)
        {
            try
            {
                _context.Database.ExecuteSql(
                    $" UpdateStudent @studentId ={student.Id}, @firstName ={student.FirstName}, @lastName={student.LastName}, @gender ={student.Gender} ,@SSN = {student.Ssn} ,@Email = {student.Email}, @Phone = {student.Phone},@DateOfBirth = {student.DateOfBirth},@address = {student.Address}, @trackID = {student.TrackId}, @branchId = {student.BranchId}, @departmentID = {student.DepartmentId};");
                return RedirectToAction(nameof(Index), new {id = student.Id });
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }

        [Authorize(Roles = "Admin")]
        public IActionResult Delete(int id)
        {
            try
            {
                _context.Database.ExecuteSql($"DeleteStudent @studentId = {id};");
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }

        [Authorize(Roles = "Admin")]
        public IActionResult AddCourse(int studentId, int courseId, int instructorId)
        {
            try
            {
                _context.Database.ExecuteSql(
                        $"InsertStudentInCourse @courseId = {courseId}, @instructorId ={instructorId}, @studentId = {studentId}, @startDate = {DateTime.Now:yyyy-MM-dd HH:mm:ss}"
                );

                return RedirectToAction(nameof(Index), new { id = studentId });
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }
        
        [Authorize(Roles = "Admin")]
        public IActionResult RemoveCourse(int studentId, int courseId)
        {
            try
            {
                _context.Database.ExecuteSql($"EXEC DeleteCourseFromStudent @courseId = {courseId}, @studentId = {studentId};");
                return RedirectToAction(nameof(Index), new {id = studentId });
            }
            catch (Exception ex)
            {
                return HandleError(ex);
            }
        }

        private IActionResult HandleError(Exception ex)
        {
            var errorModel = new ErrorViewModel
            {
                RequestId = HttpContext.TraceIdentifier,
                ErrorMessage = ex.Message // Pass the error message
            };

            return View("Error", errorModel); // Directly return the error view with model
        }
    }
}
