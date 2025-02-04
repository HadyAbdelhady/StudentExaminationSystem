using Examination_System.Data;
using Examination_System.DTOs;
using Examination_System.Models;
using Examination_System.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System.Data;

namespace Examination_System.Controllers
{
    public class StudentSubmitController : Controller
    {
        private readonly StudentExaminationSystemContext _context;
        public StudentSubmitController(StudentExaminationSystemContext context, IConfiguration configuration)
        {
            _context = context;
        }
        public IActionResult Index(int? id)
        {
            var StudentSubmits = _context.Database.SqlQuery<StudentSubmitViewModel>($"EXEC getAllStudentSubmitions;").ToList();
            return View("Index",StudentSubmits);
        }

        public IActionResult Details(int studentId , int ExamModelId)
        {
            var submitionDetails = _context.Database.SqlQuery<StudentSubmitDetailsViewModel>($"Exec GetStudentAnswersPerExamWithReview @examModelId = {ExamModelId}, @studentId = {studentId}").ToList();
            ViewBag.examDetails = _context.Database.SqlQuery<GetExamModel>($"GetExamModel @examModelId = {ExamModelId};").ToList()[0];
            var examResult = _context.Database.SqlQuery <ExamResult>($"EXEC HELPER_calcStudentGrade @studentId={studentId}, @examModelID = {ExamModelId}").ToList()[0];
            ViewBag.Grade = examResult.Grade;
            return View("Details", submitionDetails);
        }

        [Route("StudentSubmit/Insert/{id}/{studentId}")]
        public IActionResult Insert(int id, int studentId = 10)
        {
            InsertStudentSubmitViewModel insertStudentSubmitViewModel = new InsertStudentSubmitViewModel();

            try
            {
                var examQuestions = _context.Database.SqlQuery<GetQuestionsWithOptions>($"GetExamModelQuestionsWithOptionsWithAnswer @examModelId = {id};").ToList();
                var studentAnswers = new List<string>(examQuestions.Count);

                insertStudentSubmitViewModel.StudentAnswers = studentAnswers;
                insertStudentSubmitViewModel.Questions = examQuestions;
                insertStudentSubmitViewModel.ExamModelId = id;
                insertStudentSubmitViewModel.StudentId = studentId;

                
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine($"Error in Insert action: {ex.Message}");
                return StatusCode(500, "An error occurred while fetching exam questions.");
            }

            return View("Insert", insertStudentSubmitViewModel);
        }
        
        public IActionResult SaveInsert(int ExamModelId, int StudentId, List<int> Questions, List<string> StudentAnswers)
        {
            if (Questions == null || StudentAnswers == null || Questions.Count != StudentAnswers.Count)
            {
                return BadRequest("Invalid data received. Questions and answers must be provided and have the same count.");
            }

            try
            {
                // Create a new StudentSubmit entry
                var studentSubmission = new StudentSubmit
                {
                    StudentId = StudentId,
                    ExamModelId = ExamModelId,
                    SubmitDate = DateTime.UtcNow,
                    //IsDeleted = false // Assuming new submissions are active
                };

                _context.StudentSubmits.Add(studentSubmission);
                _context.SaveChanges(); // Save to generate the ID

                int studentSubmitId = studentSubmission.Id;

                // Insert Student Answers
                var studentAnswersList = new List<StudentSubmitAnswer>();

                for (int i = 0; i < Questions.Count; i++)
                {
                    studentAnswersList.Add(new StudentSubmitAnswer
                    {
                        StudentSubmitId = studentSubmitId,
                        ExamModelId = ExamModelId,
                        QuestionId = Questions[i],
                        StudentAnswer = string.IsNullOrEmpty(StudentAnswers[i]) ? "" : StudentAnswers[i],
                        IsDeleted = false
                    });
                }

                _context.StudentSubmitAnswers.AddRange(studentAnswersList);
                _context.SaveChanges();

         

       

                return RedirectToAction("Index", "Student", new { id = StudentId });
            }
            catch (Exception ex)
            {
                

                // Log the error (consider using a logging framework like Serilog or NLog)
                Console.WriteLine($"Error: {ex.Message}");

                return StatusCode(500, "An error occurred while saving the student submission.");
            }
        }

        public IActionResult StudentCourse(int courseId, int studentId)
        {
            var StudentSubmits = _context.Database.SqlQuery<StudentSubmitViewModel>($"EXEC getStudentSubmitionPerStudentInCourse @studentId = {studentId}, @courseId = {courseId};").ToList();
            return View("Index", StudentSubmits);
        }
  
    }
    
}
