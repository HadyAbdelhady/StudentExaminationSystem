using Examination_System.Data;
using Examination_System.DTOs;

using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

using System.Data;
using System.Threading.Tasks;

namespace Examination_System.Controllers
{
    public class BranchController : Controller
    {
        private readonly StudentExaminationSystemContext _context;

        public BranchController(StudentExaminationSystemContext context)
        {
            _context = context;
        }

        // GET: BranchController
        public async Task<IActionResult> Index()
        {
            var branches = await _context.Database.SqlQueryRaw<GetAllBranches>("EXEC GetAllBranches").ToListAsync();
            return View(branches);
        }

        // GET: BranchController/Details/5
        public async Task<IActionResult> Details(int id)
        {
            var branches = await _context.Database
        .SqlQuery<GetAllBranches>($"EXEC GetBranchByID @BranchID = {id} ")
        .ToListAsync(); // Materialize the query results asynchronously

            var branch = branches.FirstOrDefault();
            if (branch == null)
            {
                return NotFound();
            }

            // Fetch department details
            var departments = await _context.Database
                .SqlQuery<GetDepartmentData>($"EXEC GetDepartmentsBranchData @BranchID={id} ")
                .ToListAsync();

            var tracks = await _context.Database
                .SqlQuery<GetTracksPerBranch>($"EXEC GetTracksPerBranch @BranchID={id} ")
                .ToListAsync();

            // Pass the tuple directly to the view
            return View((branch, departments,tracks));
        }

        // GET: BranchController/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: BranchController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(GetAllBranches branchDto)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    await _context.Database.ExecuteSqlRawAsync(
                        "EXEC InsertBranch @Name, @Location, @Phone, @EstablishmentDate, @ManagerID",
                        new SqlParameter("@Name", branchDto.Name),
                        new SqlParameter("@Location", branchDto.Location),
                        new SqlParameter("@Phone", branchDto.Phone),
                        new SqlParameter("@EstablishmentDate", branchDto.EstablishmentDate),
                        new SqlParameter("@ManagerID", branchDto.ManagerId)
                    );
                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "An error occurred while saving the branch. Please try again.");
                }
            }
            // If we got this far, something failed; redisplay the form
            return View(branchDto);
        }

        // GET: BranchController/Edit/5
        public async Task<IActionResult> Edit(int id)
        {
            var branches = await _context.Database
        .SqlQueryRaw<GetAllBranches>("EXEC GetBranchByID @BranchID", new SqlParameter("@BranchID", id))
        .ToListAsync(); // Materialize the query results asynchronously

            var branch = branches.FirstOrDefault(); 
            if (branch == null)
            {
                return NotFound();
            }
            return View(branch);
        }

        // POST: BranchController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, GetAllBranches branchDto)
        {
            if (ModelState.IsValid)
            {
                await _context.Database.ExecuteSqlRawAsync("EXEC UpdateBranch @BranchID, @Name, @Location, @Phone, @EstablishmentDate, @ManagerID",
                    new SqlParameter("@BranchID", id),
                    new SqlParameter("@Name", branchDto.Name),
                    new SqlParameter("@Location", branchDto.Location),
                    new SqlParameter("@Phone", branchDto.Phone),
                    new SqlParameter("@EstablishmentDate", branchDto.EstablishmentDate),
                    new SqlParameter("@ManagerID", branchDto.ManagerId));

                return RedirectToAction(nameof(Index));
            }
            return View(branchDto);
        }

        // GET: BranchController/Delete/5
        public async Task<IActionResult> Delete(int id)
        {
            var branches = await _context.Database
                .SqlQueryRaw<GetAllBranches>("EXEC GetBranchByID @BranchID", new SqlParameter("@BranchID", id))
                .ToListAsync(); // Materialize the query results asynchronously

            var branch = branches.FirstOrDefault(); // Use FirstOrDefault on the materialized list

            if (branch == null)
            {
                return NotFound();
            }
            return View(branch);
        }

        // POST: BranchController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ConfirmDelete(int id)
        {
            try { 
            await _context.Database.ExecuteSqlRawAsync("EXEC DeleteBranch @BranchID", new SqlParameter("@BranchID", id));
            return RedirectToAction(nameof(Index));

            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occurred while deleting the department. Please try again.");
                return View();
            }
        }

       
        public async Task<IActionResult> AssignTrack(int branchId)
        {
            var branch = await _context.Branches
                .Where(b => b.Id == branchId)
                .Select(b => new GetAllBranches
                {
                    Id = b.Id,
                    Name = b.Name,
                    Location = b.Location,
                    Phone = b.Phone,
                    EstablishmentDate = b.EstablishmentDate,
                    ManagerId = b.ManagerId
                }).FirstOrDefaultAsync();

            if (branch == null)
            {
                return NotFound();
            }

            var departments = await _context.Departments
                .Where(d => _context.BranchDepartmentTracks.Any(bdt => bdt.BranchId == branchId && bdt.DepartmentId == d.Id))
                .Select(d => new GetDepartmentData
                {
                    Id = d.Id,
                    Name = d.Name,
                    CreationDate = d.CreationDate
                }).ToListAsync();

            var tracks = await _context.Tracks
                .Where(t => (bool)!t.IsDeleted)
                .Select(t => new GetTracksPerBranch
                {
                    Id = t.Id,
                    Name = t.Name,
                    DepartmentId = t.DepartmentId,
                    CreationDate = t.CreationDate
                }).ToListAsync();

            return View((branch, departments, tracks));
        }

        [HttpPost]
        public async Task<IActionResult> AssignTrack(int branchId, int trackId, int departmentManagerId, int trackManagerId)
        {
            try
            {
                using (var command = _context.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "InsertTrackIntoBranch";
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add(new SqlParameter("@branchID", SqlDbType.Int) { Value = branchId });
                    command.Parameters.Add(new SqlParameter("@trackID", SqlDbType.Int) { Value = trackId });
                    command.Parameters.Add(new SqlParameter("@departmentManagerID", SqlDbType.Int) { Value = departmentManagerId });
                    command.Parameters.Add(new SqlParameter("@DepartementManagerJoinDate", SqlDbType.DateTime) { Value = DateTime.Now });
                    command.Parameters.Add(new SqlParameter("@trackManagerID", SqlDbType.Int) { Value = trackManagerId });
                    command.Parameters.Add(new SqlParameter("@TrackManagerJoinDate", SqlDbType.DateTime) { Value = DateTime.Now });

                    _context.Database.OpenConnection();
                    await command.ExecuteNonQueryAsync();
                    _context.Database.CloseConnection();
                }

                return RedirectToAction("Details", new { id = branchId });
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, "Error assigning track: " + ex.Message);
                return RedirectToAction("AssignTrack", new { branchId });
            }
        }

        [HttpPost]
        public IActionResult DeleteTrack(int trackId, int branchId)
        {
            var track = _context.BranchDepartmentTracks
                        .FirstOrDefault(t => t.TrackId == trackId && t.BranchId == branchId);

            if (track == null)
                return NotFound();

            // Soft delete by setting IsDeleted flag
            track.IsDeleted = true;
            _context.SaveChanges();

            return RedirectToAction("Details", new { id = branchId });
        }

    }
}