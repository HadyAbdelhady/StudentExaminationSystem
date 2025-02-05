using Examination_System.Data;
using Examination_System.DTOs;
using Examination_System.Models;
using Examination_System.ViewModels;
using Humanizer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace Examination_System.Controllers
{
    public class QuestionBankController : Controller
    {
        private readonly StudentExaminationSystemContext _context;
        public QuestionBankController(StudentExaminationSystemContext context )
        {
            _context = context;
        }
        public IActionResult Index(int? id, int? CourseId)
        {
            var query = _context.QuestionBanks
                .Include(q => q.Course)
                .Include(q => q.Instructor)
                .Include(q => q.QuestionBankChoices)
                .Where(q => q.IsDeleted == false);

            if (id.HasValue && CourseId.HasValue)
            {
                query = query.Where(q => q.InstructorId == id && q.CourseId == CourseId);
            }

            var questionsData = query.ToList();

            var questions = questionsData.Select(q => new QuestionBankViewModel
            {
                QuestionData = new QuestionBankViewModel.Question
                {
                    Id = q.Id,
                    Type = q.Type,
                    CorrectChoice = q.CorrectChoice,
                    instructorId = q.InstructorId,
                    InstructorName = q.Instructor.FirstName + " " + q.Instructor.LastName,
                    courseId = q.CourseId,
                    CourseName = q.Course.Name,
                    InsertionDate = q.InsertionDate,
                    QuestionText = q.QuestionText
                },
                Choices = q.QuestionBankChoices.Select(c => new QuestionBankViewModel.QuestionChoice
                {
                    Choice = c.Choice
                }).ToList()
            }).ToList();

            ViewBag.InstructorId = id;
            ViewBag.CourseId = CourseId;

            if (questions.Count() > 0)
            {
                return View(questions);
            }else
            {
                
                return RedirectToAction("Index");
                
            }
        }

        [HttpGet]
        public IActionResult Create(int? instructorId, int courseId)
        {
            instructorId = instructorId ?? int.Parse(User.FindFirst("InstructorId").Value);
            var model = new InsertQuestion
            {
                QuestionData = new InsertQuestion.Question
                {
                    InstructorId = 0,
                    CourseId = courseId
                }
            };

            ViewBag.Instructor = _context.Instructors.Where(inst => inst.Id == instructorId).Include(inst => inst.Courses).First();
            return View(model);
        }

        [HttpPost]
        public IActionResult Create (InsertQuestion question)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string storedProcedure = "InsertQuestion";

                    var outputQuestionId = new SqlParameter
                    {
                        ParameterName = "@QuestionId",
                        SqlDbType = System.Data.SqlDbType.Int,
                        Direction = System.Data.ParameterDirection.Output
                    };

                    var parameters = new[]
                    {
                        new SqlParameter("@Type", question.QuestionData.Type),
                        new SqlParameter("@CorrectChoice", question.QuestionData.CorrectChoice),
                        new SqlParameter("@InstructorID", question.QuestionData.InstructorId),
                        new SqlParameter("@CourseID", question.QuestionData.CourseId),
                        new SqlParameter("@QuestionText", question.QuestionData.QuestionText),
                        outputQuestionId  //OP 
                    };

                    _context.Database.ExecuteSqlRaw
                        ($"EXEC {storedProcedure} @Type, @CorrectChoice, @InstructorID, @CourseID, @QuestionText, @QuestionID OUTPUT", parameters);

                    int questionID = (int)outputQuestionId.Value;

                    foreach (var choice in question.Choices)
                    {
                        _context.Database.ExecuteSqlRaw
                            ($"EXEC insertQuestionBankChoice @QuestionID, @Choice",
                            new SqlParameter("@QuestionID", questionID),
                            new SqlParameter("@Choice", choice.Choice));
                    }



                    return RedirectToAction(nameof(Index), new { id = question.QuestionData.InstructorId, courseId = question.QuestionData.CourseId });

                }
                catch (SqlException ex)
                {

                    ModelState.AddModelError("", "An error occurred while saving the instructor: " + ex.Message);
                    return View("Create", question);
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "An unexpected error occurred: " + ex.Message);
                    return View("Create", question);
                }
            }

            return View("Create", question);




        }

        [HttpGet]
        public IActionResult Delete(int questionId)
        {
            string deleteStoredProcedure = "DeleteQuestion";
            string getQuestionStoredProcedure = "SelectQuestion";

            // Use FromSqlRaw to execute the stored procedure
            var question = _context.QuestionBanks
                .FromSqlRaw($"EXEC {getQuestionStoredProcedure} @questionID", new SqlParameter("@questionID", questionId))
                .AsEnumerable() // Execute the query and bring results into memory
                .FirstOrDefault();

            if (question == null)
            {
                return NotFound();
            }

            // Execute the delete stored procedure
            _context.Database.ExecuteSqlRaw($"EXEC {deleteStoredProcedure} @questionID", new SqlParameter("@questionID", questionId));

            return RedirectToAction(nameof(Index),new {id=question.InstructorId ,courseId=question.CourseId});
        }

    }
}
