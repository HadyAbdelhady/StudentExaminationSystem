using Examination_System.Data;
using Examination_System.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

using System;
using System.Linq;
using System.Threading.Tasks;

namespace Examination_System.Controllers
{
    [Authorize(Roles = "Admin , Instructor")]
    public class DepartmentController : Controller
    {
        private readonly StudentExaminationSystemContext _context;

        public DepartmentController(StudentExaminationSystemContext context)
        {
            _context = context;
        }

        // GET: DepartmentController
        public async Task<IActionResult> Index()
        {
            var departments = await _context.Database
                .SqlQueryRaw<GetDepartmentData>("EXEC GetDepartmentData")
                .ToListAsync();
            return View(departments);
        }
        

        // GET: DepartmentController/Details/5
        public async Task<IActionResult> Details(int id)
        {
            var departments = await _context.Database
                .SqlQuery<GetDepartmentData>($"EXEC GetDepartmentByID @DepartmentID={id}")
                .ToListAsync();

            var department = departments.FirstOrDefault();
            if (department == null)
            {
                return NotFound();
            }

            var tracks = await _context.Database
                .SqlQuery<GetTracksPerBranch>($"EXEC GetTracksByDepartment @DepartmentID={id}")
                .ToListAsync();
            return View((department ,tracks));
        }

        // GET: DepartmentController/Create
        [Authorize(Roles = "Admin")]
        public IActionResult Create()
        {
            return View();
        }

        // POST: DepartmentController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(GetDepartmentData departmentDto)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var outputParam = new SqlParameter("@NewDepartmentID", System.Data.SqlDbType.Int)
                    {
                        Direction = System.Data.ParameterDirection.Output
                    };

                    await _context.Database.ExecuteSqlRawAsync(
                        "EXEC InsertDepartment @DEPTNAME, @NewDepartmentID OUTPUT",
                        new SqlParameter("@DEPTNAME", departmentDto.Name),
                        outputParam);

                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "An error occurred while creating the department. Please try again.");
                }
            }
            return View(departmentDto);
        }

        // GET: DepartmentController/Edit/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(int id)
        {
            var departments = await _context.Database
                .SqlQuery<GetDepartmentData>($"EXEC GetDepartmentByID @DepartmentID={id}")
                .ToListAsync();

            var department = departments.FirstOrDefault();
            if (department == null)
            {
                return NotFound();
            }
            return View(department);
        }

        // POST: DepartmentController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(int id, GetDepartmentData departmentDto)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    await _context.Database.ExecuteSqlRawAsync(
                        "EXEC UpdateDepartment @DepartmentID, @NewName",
                        new SqlParameter("@DepartmentID", id),
                        new SqlParameter("@NewName", departmentDto.Name));

                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "An error occurred while updating the department. Please try again.");
                }
            }
            return View(departmentDto);
        }

        // GET: DepartmentController/Delete/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(int id)
        {
            var department = await _context.Database
                .SqlQueryRaw<GetDepartmentData>("EXEC GetDepartmentById @DeptID", new SqlParameter("@DeptID", id))
                .FirstOrDefaultAsync();

            if (department == null)
            {
                return NotFound();
            }
            return View(department);
        }

        // POST: DepartmentController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            try
            {
                await _context.Database.ExecuteSqlAsync($"EXEC DeleteDepartment @DEPTID={id}");
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occurred while deleting the department. Please try again.");
                return View();
            }
        }

    }
}
