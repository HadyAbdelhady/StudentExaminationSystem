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
    public class TrackController : Controller
    {
        private readonly StudentExaminationSystemContext _context;

        public TrackController(StudentExaminationSystemContext context)
        {
            _context = context;
        }

        // GET: TrackController
        public ActionResult Index()
        {
            return View();
        }


        // GET: TrackController/Create
        // GET: Track/Create
        [Authorize(Roles = "Admin")]
        public IActionResult Create(int departmentId)
        {
            var trackDto = new GetTracksPerBranch { DepartmentId = departmentId };
            return View(trackDto);
        }

        // POST: Track/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(GetTracksPerBranch trackDto)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // Define the output parameter for @NewTrackID
                    var newTrackIdParam = new SqlParameter
                    {
                        ParameterName = "@NewTrackID",
                        SqlDbType = SqlDbType.Int,
                        Direction = ParameterDirection.Output // Mark it as an output parameter
                    };

                    // Call the stored procedure with all required parameters
                    await _context.Database.ExecuteSqlRawAsync(
                        "EXEC InsertTrack @Name, @DepartmentID, @NewTrackID OUTPUT",
                        new SqlParameter("@Name", trackDto.Name),
                        new SqlParameter("@DepartmentID", trackDto.DepartmentId),
                        newTrackIdParam);

                    // Retrieve the value of the output parameter
                    int newTrackId = (int)newTrackIdParam.Value;

                    // Optionally, you can log or use the newTrackId
                    Console.WriteLine($"New Track ID: {newTrackId}");

                    // Redirect to the department details page after successful insertion
                    return RedirectToAction("Details", "Department", new { id = trackDto.DepartmentId });
                }
                catch (Exception ex)
                {
                    // Log the error and display a user-friendly message
                    ModelState.AddModelError("", "An error occurred while inserting the track: " + ex.Message);
                }
            }

            // If the model state is invalid, return to the create view with validation errors
            return View(trackDto);
        }

        // GET: TrackController/Details/5
        public async Task<IActionResult> Details(int id)
        {
            try
            {
                // Call the GetTrack stored procedure to retrieve track details
                var tracks = await _context.Database
                .SqlQuery<GetTracksPerBranch>($"EXEC GetTrack @ID={id}")
                .ToListAsync();

                var track = tracks.FirstOrDefault();

                if (track == null)
                {
                    return NotFound("Track not found or has been deleted.");
                }
                // Map the track entity to a DTO for editing
                var courses = await _context.Database
                    .SqlQuery<GetCoursesInTrack>($"EXEC GetCoursesInTrack @TrackID={id}")
                    .ToListAsync();

                return View((track, courses));
            }
            catch (Exception ex)
            {
                // Log the error and display a user-friendly message
                ModelState.AddModelError("", "An error occurred while retrieving the track: " + ex.Message);
                return View("Error");
            }
        }

        // GET: TrackController/Edit/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(int id)
        {
            try
            {
                // Call the GetTrack stored procedure to retrieve track details
                var tracks = await _context.Database
                .SqlQuery<GetTracksPerBranch>($"EXEC GetTrack @ID={id}")
                .ToListAsync();

                var track = tracks.FirstOrDefault();

                if (track == null)
                {
                    return NotFound("Track not found or has been deleted.");
                }

          

                return View(track);
            }
            catch (Exception ex)
            {
                // Log the error and display a user-friendly message
                ModelState.AddModelError("", "An error occurred while retrieving the track: " + ex.Message);
                return View("Error");
            }
        }

        // POST: TrackController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(int id, GetTracksPerBranch trackDto)
        {
            if (id != trackDto.Id)
            {
                return NotFound("Track ID mismatch.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Call the UpdateTrack stored procedure to update the track
                    await _context.Database.ExecuteSqlRawAsync(
                        "EXEC UpdateTrack @ID, @Name, @DepartmentID",
                        new SqlParameter("@ID", trackDto.Id),
                        new SqlParameter("@Name", trackDto.Name),
                        new SqlParameter("@DepartmentID", trackDto.DepartmentId));

                    // Redirect to the details page after successful update
                    return RedirectToAction("Details", new { id = trackDto.Id });
                }
                catch (Exception ex)
                {
                    // Log the error and display a user-friendly message
                    ModelState.AddModelError("", "An error occurred while updating the track: " + ex.Message);
                }
            }

            // If the model state is invalid, return to the edit view with validation errors
            return View(trackDto);
        }

        // GET: TrackController/Delete/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                // Call the GetTrack stored procedure to retrieve track details
                var track = await _context.Database.SqlQueryRaw<GetTracksPerBranch>
                    ("EXEC GetTrack @ID", new SqlParameter("@ID", id))
                    .FirstOrDefaultAsync();

                if (track == null)
                {
                    return NotFound("Track not found or has been deleted.");
                }

                return View(track);
            }
            catch (Exception ex)
            {
                // Log the error and display a user-friendly message
                ModelState.AddModelError("", "An error occurred while retrieving the track: " + ex.Message);
                return View("Error");
            }
        }

        // POST: TrackController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(int departmentId, int trackId)
        {
            try
            {
                // Call the DeleteTrack stored procedure to soft delete the track
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC DeleteTrack @ID",
                    new SqlParameter("@ID", trackId));

                // Redirect to the index page after successful deletion
                return RedirectToAction("Details", "Department", new { id = departmentId });
            }
            catch (Exception ex)
            {
                // Log the error and display a user-friendly message
                ModelState.AddModelError("", "An error occurred while deleting the track: " + ex.Message);
                return View("Error");
            }
        }
    }
}
