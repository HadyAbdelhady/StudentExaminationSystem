using Examination_System.Data;
using Examination_System.Models;
using Examination_System.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Examination_System.Controllers
{
    public class StudentProfileController : Controller
    {
        private readonly StudentExaminationSystemContext _context;

        public StudentProfileController(StudentExaminationSystemContext context)
        {
            _context = context;
        }
        public IActionResult Index(int id)
        {
            var student = _context.Students.Where(std => std.Id == id).FirstOrDefault();
            if(student == null)
            {
                return NotFound();
            }
            return View("Profile", student);  
        }
        public IActionResult Courses(int id)
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
                                  .Include(submit =>submit.ExamModel)
                                  .Include(submit =>submit.ExamModel.Instructor)
                                  .ToList();
            var submitsMarksDictionary =  new Dictionary<StudentSubmit, (int,int)>();
            foreach (var submission in submits)
            {
                int mark = 0;
                int totalMark = 0;
                mark = _context.Database.SqlQuery<int>($"EXEC HELPER_calcStudentGrade @studentId = {id}, @examModelId = {submission.ExamModelId}")
                                        .ToList()[0];
                totalMark = _context.Database.SqlQuery<int>($"EXEC HELPER_calcTotalExamMark @examModelId = {submission.ExamModelId}")
                                        .ToList()[0];
                submitsMarksDictionary.Add(submission, (mark,totalMark));
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
