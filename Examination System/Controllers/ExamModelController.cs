using Examination_System.Data;
using Examination_System.DTOs;
using Examination_System.Models;
using Examination_System.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Text;

namespace Examination_System.Controllers
{
    public class ExamModelController : Controller
    {
        private readonly StudentExaminationSystemContext _context;
        public ExamModelController(StudentExaminationSystemContext context, IConfiguration configuration)
        {
            _context = context;
        }
        public IActionResult Index(int? id)
        {
            if (id == null)
            {
                var examModels = _context.Database.SqlQuery<GetExamModel>($"EXEC GetAllExamModels;").ToList();
                return View("Index", examModels);
            } 
            
                var examModelData = _context.Database.SqlQuery<GetExamModel>($"EXEC GetExamModel @examModelId = {id};").ToList()[0];
                var examModelQuestions = _context.Database.SqlQuery<GetQuestionsWithOptions>($"EXEC GetExamModelQuestionsWithOptionsWithAnswer @examModelId = {id};").ToList();
                var examModelDetails = new ExamModelDetailsViewModel();
                examModelDetails.examModelQuestions = examModelQuestions;
                examModelDetails.examModelData = examModelData;

                return View("Details", examModelDetails);
            
        }
        
        public IActionResult Create(int id)
        {
            ExamModelViewModel examModelViewModel = new ExamModelViewModel();

            examModelViewModel.instructors = _context.Database.SqlQueryRaw<GetAllInstructors>
                ("EXEC GetAllInstructorsInCourse @courseId", new SqlParameter("@courseId", id))
                .ToList();

            examModelViewModel.questions = _context.Database.SqlQuery<GetQuestionsWithOptions>
                ($"EXEC GetQuestionDetailsWithOptionsInCourse @courseId = {id}").ToList();


            examModelViewModel.CourseId = id;

            return View("Create", examModelViewModel);
        }

        public IActionResult SaveCreate(ExamModelViewModel examModelViewModel)
        {
            var examModelIdParam = new SqlParameter
            {
                ParameterName = "@examModelID",
                SqlDbType = System.Data.SqlDbType.Int,
                Direction = System.Data.ParameterDirection.Output
            };

            _context.Database.ExecuteSqlRaw(
                "DECLARE @newExamModelID INT; " +
                "EXEC InsertExamModel @date = @date, @startTime = @startTime, @endTime = @endTime, " +
                "@CourseID = @CourseID, @instructorID = @instructorID, @examModelID = @examModelID OUTPUT; ",
                new SqlParameter("@date", examModelViewModel.Date),
                new SqlParameter("@startTime", examModelViewModel.StartTime),
                new SqlParameter("@endTime", examModelViewModel.EndTime),
                new SqlParameter("@CourseID", examModelViewModel.CourseId),
                new SqlParameter("@instructorID", examModelViewModel.InstructorId),
                examModelIdParam
            );

            int examModelId = (int)examModelIdParam.Value;

            if (examModelViewModel.questionIdList != null)
            {
                foreach (var questionId in examModelViewModel.questionIdList)
                {
                    _context.Database.ExecuteSqlRaw(
                        "EXEC InsertIntoExamModel_Question @examModelID, @questionId, @mark",
                        new SqlParameter("@examModelID", examModelId),
                        new SqlParameter("@questionId", questionId),
                        new SqlParameter("@mark", 1)
                    );
                }
            }

            return RedirectToAction("Index", new { id = examModelId });
        }


    }
}
