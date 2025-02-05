using Examination_System.Data;
using Examination_System.DTOs;
using Examination_System.Models;
using Examination_System.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Examination_System.Controllers
{
    public class DocumentationController : Controller
    {
        private readonly StudentExaminationSystemContext _context;

        public DocumentationController(StudentExaminationSystemContext context)
        {
            _context = context;
        }
        [Authorize(Roles = "Admin , Instructor")]
        public IActionResult GetAllStudentsInDepartment(int id) 
        {
            List <GetAllStudents> Students = _context.Database.SqlQuery<GetAllStudents>($"Exec GetAllStudentsInDepartment @departmentId = {id}").ToList();
            ViewBag.Title = "All Students in the department";
            return View("Students",Students);
        }
        public IActionResult GetAllStudentsInTrack(int id)
        {
            ViewBag.Title = "All Students in the Track";
            List<GetAllStudents> Students = _context.Database.SqlQuery<GetAllStudents>($"Exec GetAllStudentsInTrack @trackId = {id}").ToList();
            return View("Students", Students);
        }
        public IActionResult GetAllStudentsPerInstructor(int id)
        {
            ViewBag.Title = "All Students per Instructor";
            List<GetAllStudents> Students = _context.Database.SqlQuery<GetAllStudents>($"Exec GetAllStudentsPerInstructor @instructorId = {id}").ToList();
            return View("Students", Students);
        }
        public IActionResult GetAllStudentsInBranch(int id)
        {
            ViewBag.Title = "All Students in the Branch";
            List<GetAllStudents> Students = _context.Database.SqlQuery<GetAllStudents>($"Exec GetAllStudentsInBranch @branchId = {id}").ToList();
            return View("Students", Students);
        }
        public IActionResult GetAllTopics(int id)
        {
            string courseName = _context.Courses.Where(c => c.Id == id).First().Name;
            ViewBag.Title = courseName;
            var topics = _context.Database.SqlQuery<CourseTopicViewModel>($"EXEC GetCourseTopics @courseId = {id}").ToList();
            return  View("Topics", topics);
        }
        public IActionResult GetCoursesPerInstructor(int id)
        {
            var instructorCourses = _context.Database
                    .SqlQuery<InstructorCourseInfo>($"EXEC GetInstructorCoursesWithStudentCount @instructorID= {id}")
                    .ToList();
            ViewBag.Title = _context.Instructors.Where(inst => inst.Id == id).First().FirstName + " " +
                _context.Instructors.Where(inst => inst.Id == id).First().LastName;
            return View("InstructorCourses", instructorCourses);
        }
        public IActionResult GetAllExamModelQuestions(int id)
        {
            return RedirectToAction(nameof(Index), "ExamModel", new { id });

        }
        [Route("Documentation/GetStudentExamReview/{examModelId}/{studentId}")]
        public IActionResult GetStudentExamReview(int examModelId , int studentId)
        {
            return RedirectToAction("Details", "StudentSubmit", new { studentId = studentId, ExamModelId = examModelId });
        }
        public IActionResult GetStudentCourseGrades(int id)
        {
            // Get all the courses assigned to the student
            var courses = _context.Courses
                                  .Where(course => course.CourseStudentInstructors
                                  .Any(CSI => CSI.StudentId == id))
                                  .ToList();

            // Get all the student's submitted exams
            var submits = _context.StudentSubmits
                                  .Where(submit => courses
                                  .Select(course => course.Id)
                                  .Contains(submit.ExamModel.CourseId))
                                  .Include(submit => submit.ExamModel)
                                  .Include(submit => submit.ExamModel.Instructor)
                                  .ToList();
            var submitsMarksDictionary = new Dictionary<StudentSubmit, (int, int)>();
            foreach (var submission in submits)
            {
                int mark = 0;
                int totalMark = 0;
                mark = _context.Database.SqlQuery<int>($"EXEC HELPER_calcStudentGrade @studentId = {id}, @examModelId = {submission.ExamModelId}")
                                        .ToList()[0];
                totalMark = _context.Database.SqlQuery<int>($"EXEC HELPER_calcTotalExamMark @examModelId = {submission.ExamModelId}")
                                        .ToList()[0];
                submitsMarksDictionary.Add(submission, (mark, totalMark));
            }
            // Get all the exams in the courses that haven't been assigned to him yet
            var exams = _context.ExamModels
                                .Where(exam => !submits
                                .Select(submit => submit.ExamModelId)
                                .Contains(exam.Id))
                                .Include(exam => exam.Instructor)
                                .ToList();

            StudentExamsSubmitsViewModel studentExamsSubmitsViewModel = new StudentExamsSubmitsViewModel();
            studentExamsSubmitsViewModel.Courses = courses;
            studentExamsSubmitsViewModel.Exams = exams;
            studentExamsSubmitsViewModel.Submits = submitsMarksDictionary;
            return View("Courses", studentExamsSubmitsViewModel);
        }
    }
}
