using Examination_System.Data;
using Examination_System.DTOs;
using Examination_System.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace Examination_System.Controllers
{
    [Authorize(Roles = "Admin , Instructor")]
    public class CourseController : Controller
    {
        private readonly StudentExaminationSystemContext _context;

        public CourseController(StudentExaminationSystemContext context)
        {
            _context = context;
        }

        // GET: CourseController
        public ActionResult Index()
        {
            return View();
        }

        // GET: CourseController/Details/5
        public async Task<IActionResult> Details(int id, int trackId)
        {
            try
            {
                // Call the GetCourseByID stored procedure to retrieve course details
                var courses = await _context.Database
                    .SqlQuery<GetCoursesInTrack>($"EXEC GetCourseByID @CourseID={id}")
                    .ToListAsync();

                var course = courses.FirstOrDefault();

                if (course == null)
                {
                    return NotFound("Course not found or has been deleted.");
                }

                // Retrieve the topics for the course
                var topics = await _context.Database
                    .SqlQuery<GetCourseTopics>($"EXEC GetCourseTopics @CourseID={id}")
                    .ToListAsync();

                // Pass the course, topics, and trackId to the view
                var tuple = (Course: course, Topics: topics, TrackId: trackId);

                return View(tuple);
            }
            catch (Exception ex)
            {
                // Log the error and display a user-friendly message
                ModelState.AddModelError("", "An error occurred while retrieving the course: " + ex.Message);
                return View("Error");
            }
        }

        // GET: CourseController/Create
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(int trackId)
        {
            // Fetch the list of available courses
            var courses = await _context.Database
                .SqlQuery<GetCoursesInTrack>($"EXEC GetCourse")
                .ToListAsync();

            // Pass the TrackId and the list of courses to the view
            var tuple = (TrackId: trackId, Courses: courses);

            return View(tuple);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(int trackId, string courseName, int? selectedCourseId)
        {
            if (trackId == 0)
            {
                ModelState.AddModelError("", "Track ID is missing.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    int courseId;

                    if (selectedCourseId.HasValue)
                    {
                        // Use the selected course ID
                        courseId = selectedCourseId.Value;
                    }
                    else
                    {
                        // Check if the course already exists (including deleted courses)
                        var existingCourse = await _context.Courses
                            .FirstOrDefaultAsync(c => c.Name == courseName);

                        if (existingCourse != null)
                        {
                            if ((bool)existingCourse.IsDeleted)
                            {
                                // Reactivate the deleted course
                                existingCourse.IsDeleted = false;
                                existingCourse.CreationDate = DateTime.Now;
                                await _context.SaveChangesAsync();

                                courseId = existingCourse.Id;

                                return RedirectToAction("Details", "Track", new { id = trackId });
                            }
                            else
                            {
                                // Course already exists and is active
                                ModelState.AddModelError("", "This course already exists and is active.");
                                var courses = await _context.Database
                                    .SqlQuery<GetCoursesInTrack>($"EXEC GetCourse")
                                    .ToListAsync();

                                var tuple = (TrackId: trackId, Courses: courses);
                                return View(tuple);
                            }
                        }
                        else
                        {
                            // Create a new course
                            var newCourse = new Course
                            {
                                Name = courseName,
                                CreationDate = DateTime.Now,
                                IsDeleted = false
                            };

                            _context.Courses.Add(newCourse);
                            await _context.SaveChangesAsync();

                            courseId = newCourse.Id;
                        }
                    }

                    // Check if the course is already assigned to the track
                    var existingAssignment = await _context.Database
                        .SqlQuery<GetCoursesInTrack>($"EXEC GetCoursesInTrack @TrackID={trackId}")
                        .ToListAsync();

                    if (existingAssignment.Any(c => c.Id == courseId))
                    {
                        ModelState.AddModelError("", "This course is already assigned to the selected track.");

                        // Re-fetch the data and return the view with the error
                        var courses = await _context.Database
                            .SqlQuery<GetCoursesInTrack>($"EXEC GetCourse")
                            .ToListAsync();

                        var tuple = (TrackId: trackId, Courses: courses);
                        return View(tuple);
                    }

                    // Assign the course to the track
                    await _context.Database.ExecuteSqlRawAsync(
                        "EXEC InsertCourseInTrack @TrackID, @CourseID",
                        new SqlParameter("@TrackID", trackId),
                        new SqlParameter("@CourseID", courseId));

                    return RedirectToAction("Details", "Track", new { id = trackId });
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "An error occurred while assigning the course to the track: " + ex.Message);
                }
            }

            // If we got this far, something failed; re-fetch the data and redisplay the form
            var coursesList = await _context.Database
                .SqlQuery<GetCoursesInTrack>($"EXEC GetCourse")
                .ToListAsync();

            var tupleList = (TrackId: trackId, Courses: coursesList);
            return View(tupleList);
        }

        // GET: CourseController/Edit/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(int id, int trackId)
        {
            try
            {
                // Call the GetCourseByID stored procedure to retrieve course details
                var courses = await _context.Database
                    .SqlQuery<GetCoursesInTrack>($"EXEC GetCourseByID @CourseID={id}")
                    .ToListAsync();

                var course = courses.FirstOrDefault();

                if (course == null)
                {
                    return NotFound("Course not found or has been deleted.");
                }

                // Pass the course and TrackId to the view
                var tuple = (Course: course, TrackId: trackId);

                return View(tuple);
            }
            catch (Exception ex)
            {
                // Log the error and display a user-friendly message
                ModelState.AddModelError("", "An error occurred while retrieving the course: " + ex.Message);
                return View("Error");
            }
        }

        // POST: TrackController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(int id,  GetCoursesInTrack courseDto, int trackId)
        {
            if (id != courseDto.Id)
            {
                return NotFound("Course ID mismatch.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Call the UpdateCourse stored procedure to update the course
                    await _context.Database.ExecuteSqlRawAsync(
                        "EXEC UpdateCourse @CourseID, @CourseName",
                        new SqlParameter("@CourseID", courseDto.Id),
                        new SqlParameter("@CourseName", courseDto.Name));

                    // Redirect to the details page with the TrackId
                    return RedirectToAction("Details", new { id = courseDto.Id, trackId = trackId });
                }
                catch (Exception ex)
                {
                    // Log the error and display a user-friendly message
                    ModelState.AddModelError("", "An error occurred while updating the course: " + ex.Message);
                }
            }

            // If the model state is invalid, return to the edit view with validation errors
            var tuple = (Course: courseDto, TrackId: trackId);
            return View(tuple);
        }

        // GET: CourseController/Delete/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> DeleteConfirmation(int id, int trackId)
        {
            // Pass the course id and track id to the view
            var tuple = (CourseId: id, TrackId: trackId);
            return View(tuple);
        }

        // POST: CourseController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(int id, int trackId)
        {
            try
            {
                // Call the stored procedure to delete the course by ID
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC DeleteCourseByID @CourseID",
                    new SqlParameter("@CourseID", id));

                // Redirect to the track details page after deletion
                return RedirectToAction("Details", "Track", new { id = trackId });
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occurred while deleting the course: " + ex.Message);
                return RedirectToAction("Details", "Track", new { id = trackId });
            }
        }

    }
}
