using Examination_System.Data;
using Examination_System.DTOs;
using Examination_System.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

using System.Data;

namespace Examination_System.Controllers
{
    [Authorize(Roles = "Admin , Instructor")]
    public class TopicController : Controller
    {
        private readonly StudentExaminationSystemContext _context;

        public TopicController(StudentExaminationSystemContext context)
        {
            _context = context;
        }

        // GET: TopicController
        public ActionResult Index()
        {
            return View();
        }

        // GET: TopicController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }


        // GET: TopicController/Create
        [Authorize(Roles = "Admin")]
        public IActionResult Create(int courseId, int trackId)
        {
            // Pass the CourseId and TrackId to the view to ensure they're included in the form submission
            var model = new CourseTopicDTO { CourseId = courseId };
            ViewBag.TrackId = trackId; // Pass TrackId to the view
            return View(model);
        }

        // POST: TopicController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(CourseTopicDTO courseTopicDto, int trackId)
        {
            ModelState.Remove("OldTopic");
            if (ModelState.IsValid)
            {
                try
                {
                    // Call the stored procedure to insert the topic
                    await _context.Database.ExecuteSqlInterpolatedAsync(
                        $"EXEC InsertTopicIntoCourse @courseID = {courseTopicDto.CourseId}, @topic = {courseTopicDto.Topic}"
                    );

                    // Redirect back to the course details page with the TrackId
                    return RedirectToAction("Details", "Course", new { id = courseTopicDto.CourseId, trackId = trackId });
                }
                catch (SqlException ex)
                {
                    // Handle SQL exceptions (e.g., duplicate topic, invalid course ID)
                    ModelState.AddModelError(string.Empty, ex.Message);
                }
                catch (Exception ex)
                {
                    // Handle other exceptions
                    ModelState.AddModelError(string.Empty, "An error occurred while creating the topic.");
                }
            }

            // If we got this far, something failed; redisplay form
            ViewBag.TrackId = trackId; // Pass TrackId back to the view in case of errors
            return View(courseTopicDto);
        }



        // GET: Topic/Edit/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(int courseId, string topic, int trackId)
        {
            var courseTopic = await _context.CourseTopics
                .FirstOrDefaultAsync(ct => ct.CourseId == courseId && ct.Topic == topic);

            if (courseTopic == null)
            {
                return NotFound();
            }

            var dto = new CourseTopicDTO
            {
                CourseId = courseTopic.CourseId,
                Topic = courseTopic.Topic,
                OldTopic = courseTopic.Topic // Store original topic
            };

            ViewBag.TrackId = trackId; // Pass TrackId to the view
            return View(dto);
        }

        // POST: TopicController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(int courseId, string oldTopic, CourseTopicDTO dto, int trackId)
        {
            if (courseId != dto.CourseId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                var courseTopic = await _context.CourseTopics
                    .FirstOrDefaultAsync(ct => ct.CourseId == courseId && ct.Topic == oldTopic); // Use OldTopic to find record

                if (courseTopic == null)
                {
                    return NotFound();
                }

                // Check if the topic name has changed
                if (courseTopic.Topic != dto.Topic)
                {
                    // Remove the old topic and insert a new one (since EF Core does not support PK updates)
                    _context.CourseTopics.Remove(courseTopic);
                    await _context.SaveChangesAsync();

                    var newTopic = new CourseTopic
                    {
                        CourseId = dto.CourseId,
                        Topic = dto.Topic
                    };

                    _context.CourseTopics.Add(newTopic);
                }
                else
                {
                    // If only other fields were changed, update the entity
                    courseTopic.Topic = dto.Topic;
                }

                await _context.SaveChangesAsync();

                // Redirect back to the course details page with the TrackId
                return RedirectToAction("Details", "Course", new { id = courseId, trackId = trackId });
            }

            // If we got this far, something failed; redisplay form
            ViewBag.TrackId = trackId; // Pass TrackId back to the view in case of errors
            return View(dto);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(int topicId, int courseId, string topicName, int trackId)
        {
            try
            {
                // Execute stored procedure using SqlQuery
                await _context.Database.ExecuteSqlAsync($"EXEC DeleteSpecificTopicFromCourse @courseID = {courseId}, @Topic = {topicName}");

                TempData["SuccessMessage"] = "Topic deleted successfully!";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Error: " + ex.Message;
            }

            // Redirect to Course/Details with courseId and trackId in the URL
            return RedirectToAction("Details", "Course", new { id = courseId, trackId = trackId });
        }

    }
}
