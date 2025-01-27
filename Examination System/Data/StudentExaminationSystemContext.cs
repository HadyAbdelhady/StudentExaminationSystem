using System;
using System.Collections.Generic;
using Examination_System.Models;
using Microsoft.EntityFrameworkCore;

namespace Examination_System.Data;

public partial class StudentExaminationSystemContext : DbContext
{
    public StudentExaminationSystemContext()
    {
    }

    public StudentExaminationSystemContext(DbContextOptions<StudentExaminationSystemContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Branch> Branches { get; set; }

    public virtual DbSet<BranchDepartmentTrack> BranchDepartmentTracks { get; set; }

    public virtual DbSet<Course> Courses { get; set; }

    public virtual DbSet<CourseField> CourseFields { get; set; }

    public virtual DbSet<CourseStudentInstructor> CourseStudentInstructors { get; set; }

    public virtual DbSet<CourseTopic> CourseTopics { get; set; }

    public virtual DbSet<Department> Departments { get; set; }

    public virtual DbSet<DepartmentInstructor> DepartmentInstructors { get; set; }

    public virtual DbSet<ExamModel> ExamModels { get; set; }

    public virtual DbSet<ExamModelQuestion> ExamModelQuestions { get; set; }

    public virtual DbSet<Instructor> Instructors { get; set; }

    public virtual DbSet<QuestionBank> QuestionBanks { get; set; }

    public virtual DbSet<QuestionBankChoice> QuestionBankChoices { get; set; }

    public virtual DbSet<Student> Students { get; set; }

    public virtual DbSet<StudentSubmit> StudentSubmits { get; set; }

    public virtual DbSet<StudentSubmitAnswer> StudentSubmitAnswers { get; set; }

    public virtual DbSet<Track> Tracks { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=StudentExaminationSystem;Integrated Security=True;Encrypt=False;Trust Server Certificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Branch>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Branch__3214EC27006B4EAE");

            entity.ToTable("Branch");

            entity.HasIndex(e => e.ManagerId, "UQ__Branch__3BA2AA8068ED412E").IsUnique();

            entity.HasIndex(e => e.Name, "UQ__Branch__737584F6716EF5C9").IsUnique();

            entity.HasIndex(e => e.Phone, "UQ__Branch__B43B145FED3E75ED").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.EstablishmentDate)
                .HasColumnType("datetime")
                .HasColumnName("establishmentDate");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.Location).HasMaxLength(500);
            entity.Property(e => e.ManagerId).HasColumnName("ManagerID");
            entity.Property(e => e.Name).HasMaxLength(200);
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .HasColumnName("phone");

            entity.HasOne(d => d.Manager).WithOne(p => p.Branch)
                .HasForeignKey<Branch>(d => d.ManagerId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Branch__ManagerI__4222D4EF");
        });

        modelBuilder.Entity<BranchDepartmentTrack>(entity =>
        {
            entity.HasKey(e => new { e.TrackId, e.DepartmentId, e.BranchId }).HasName("PK__Branch_D__A45B644BF51F4CEB");

            entity.ToTable("Branch_Department_Track");

            entity.Property(e => e.TrackId).HasColumnName("trackID");
            entity.Property(e => e.DepartmentId).HasColumnName("departmentID");
            entity.Property(e => e.BranchId).HasColumnName("branchID");
            entity.Property(e => e.CreationDate)
                .HasColumnType("datetime")
                .HasColumnName("creationDate");
            entity.Property(e => e.DepartementManagerJoinDate).HasColumnType("datetime");
            entity.Property(e => e.DepartmentManagerId).HasColumnName("departmentManagerID");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.TrackManagerId).HasColumnName("trackManagerID");
            entity.Property(e => e.TrackManagerJoinDate).HasColumnType("datetime");

            entity.HasOne(d => d.Branch).WithMany(p => p.BranchDepartmentTracks)
                .HasForeignKey(d => d.BranchId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Branch_De__branc__5070F446");

            entity.HasOne(d => d.Department).WithMany(p => p.BranchDepartmentTracks)
                .HasForeignKey(d => d.DepartmentId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Branch_De__depar__52593CB8");

            entity.HasOne(d => d.DepartmentManager).WithMany(p => p.BranchDepartmentTrackDepartmentManagers)
                .HasForeignKey(d => d.DepartmentManagerId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Branch_De__depar__534D60F1");

            entity.HasOne(d => d.Track).WithMany(p => p.BranchDepartmentTracks)
                .HasForeignKey(d => d.TrackId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Branch_De__track__5165187F");

            entity.HasOne(d => d.TrackManager).WithMany(p => p.BranchDepartmentTrackTrackManagers)
                .HasForeignKey(d => d.TrackManagerId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Branch_De__track__5441852A");
        });

        modelBuilder.Entity<Course>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Course__3214EC275B31593B");

            entity.ToTable("Course");

            entity.HasIndex(e => e.Name, "UQ__Course__737584F61367C110").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CreationDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("creationDate");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.Name).HasMaxLength(100);

            entity.HasMany(d => d.Instructors).WithMany(p => p.Courses)
                .UsingEntity<Dictionary<string, object>>(
                    "CourseInstructor",
                    r => r.HasOne<Instructor>().WithMany()
                        .HasForeignKey("InstructorId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .HasConstraintName("FK__Course_In__instr__10566F31"),
                    l => l.HasOne<Course>().WithMany()
                        .HasForeignKey("CourseId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .HasConstraintName("FK__Course_In__cours__0F624AF8"),
                    j =>
                    {
                        j.HasKey("CourseId", "InstructorId").HasName("PK__Course_I__7AAB5053D51FA578");
                        j.ToTable("Course_Instructor");
                        j.IndexerProperty<int>("CourseId").HasColumnName("courseID");
                        j.IndexerProperty<int>("InstructorId").HasColumnName("instructorID");
                    });
        });

        modelBuilder.Entity<CourseField>(entity =>
        {
            entity.HasKey(e => new { e.CourseId, e.Field }).HasName("PK__Course_F__FA0A049F1690AEBE");

            entity.ToTable("Course_Field");

            entity.Property(e => e.CourseId).HasColumnName("courseID");
            entity.Property(e => e.Field)
                .HasMaxLength(200)
                .HasColumnName("field");
            entity.Property(e => e.CreationDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("creationDate");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");

            entity.HasOne(d => d.Course).WithMany(p => p.CourseFields)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Course_Fi__cours__797309D9");
        });

        modelBuilder.Entity<CourseStudentInstructor>(entity =>
        {
            entity.HasKey(e => new { e.CourseId, e.StudentId, e.InstructorId }).HasName("PK__Course_S__DB79636E7F0F3647");

            entity.ToTable("Course_Student_Instructor");

            entity.Property(e => e.CourseId).HasColumnName("courseID");
            entity.Property(e => e.StudentId).HasColumnName("studentID");
            entity.Property(e => e.InstructorId).HasColumnName("instructorID");
            entity.Property(e => e.StartDate)
                .HasColumnType("datetime")
                .HasColumnName("startDate");

            entity.HasOne(d => d.Course).WithMany(p => p.CourseStudentInstructors)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Course_St__cours__0A9D95DB");

            entity.HasOne(d => d.Instructor).WithMany(p => p.CourseStudentInstructors)
                .HasForeignKey(d => d.InstructorId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Course_St__instr__0C85DE4D");

            entity.HasOne(d => d.Student).WithMany(p => p.CourseStudentInstructors)
                .HasForeignKey(d => d.StudentId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Course_St__stude__0B91BA14");
        });

        modelBuilder.Entity<CourseTopic>(entity =>
        {
            entity.HasKey(e => new { e.CourseId, e.Topic }).HasName("PK__Course_T__5613C55F38A13EE0");

            entity.ToTable("Course_Topic");

            entity.Property(e => e.CourseId).HasColumnName("courseID");
            entity.Property(e => e.Topic)
                .HasMaxLength(200)
                .HasColumnName("topic");
            entity.Property(e => e.CreationDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("creationDate");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");

            entity.HasOne(d => d.Course).WithMany(p => p.CourseTopics)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Course_To__cours__74AE54BC");
        });

        modelBuilder.Entity<Department>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Departme__3214EC27F1174726");

            entity.ToTable("Department");

            entity.HasIndex(e => e.Name, "UQ__Departme__737584F653CD3C1A").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CreationDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("creationDate");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.Name).HasMaxLength(100);
        });

        modelBuilder.Entity<DepartmentInstructor>(entity =>
        {
            entity.HasKey(e => new { e.DepartmentId, e.InstructorId }).HasName("PK__Departme__A9BB2BEFC5DA4CD5");

            entity.ToTable("Department_Instructor");

            entity.Property(e => e.DepartmentId).HasColumnName("departmentID");
            entity.Property(e => e.InstructorId).HasColumnName("instructorID");
            entity.Property(e => e.JoinDate)
                .HasColumnType("datetime")
                .HasColumnName("joinDate");

            entity.HasOne(d => d.Department).WithMany(p => p.DepartmentInstructors)
                .HasForeignKey(d => d.DepartmentId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Departmen__depar__17036CC0");

            entity.HasOne(d => d.Instructor).WithMany(p => p.DepartmentInstructors)
                .HasForeignKey(d => d.InstructorId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Departmen__instr__17F790F9");
        });

        modelBuilder.Entity<ExamModel>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ExamMode__3214EC27B24958E0");

            entity.ToTable("ExamModel");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.CreationDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("creationDate");
            entity.Property(e => e.Date).HasColumnName("date");
            entity.Property(e => e.EndTime).HasColumnName("endTime");
            entity.Property(e => e.InstructorId).HasColumnName("instructorID");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.StartTime).HasColumnName("startTime");

            entity.HasOne(d => d.Course).WithMany(p => p.ExamModels)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__ExamModel__Cours__6B24EA82");

            entity.HasOne(d => d.Instructor).WithMany(p => p.ExamModels)
                .HasForeignKey(d => d.InstructorId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__ExamModel__instr__6C190EBB");
        });

        modelBuilder.Entity<ExamModelQuestion>(entity =>
        {
            entity.HasKey(e => new { e.ExamModelId, e.QuestionId }).HasName("PK__ExamMode__35117C44B0348E50");

            entity.ToTable("ExamModel_Question");

            entity.Property(e => e.ExamModelId).HasColumnName("examModelID");
            entity.Property(e => e.QuestionId).HasColumnName("questionID");
            entity.Property(e => e.CorrectChoice)
                .HasMaxLength(200)
                .HasColumnName("correctChoice");
            entity.Property(e => e.Mark).HasColumnName("mark");

            entity.HasOne(d => d.ExamModel).WithMany(p => p.ExamModelQuestions)
                .HasForeignKey(d => d.ExamModelId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__ExamModel__examM__02084FDA");

            entity.HasOne(d => d.Question).WithMany(p => p.ExamModelQuestions)
                .HasForeignKey(d => d.QuestionId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__ExamModel__quest__02FC7413");
        });

        modelBuilder.Entity<Instructor>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Instruct__3214EC27615FFC41");

            entity.ToTable("Instructor");

            entity.HasIndex(e => e.Email, "UQ__Instruct__AB6E6164FDC0C5F7").IsUnique();

            entity.HasIndex(e => e.Phone, "UQ__Instruct__B43B145F2BC98A4C").IsUnique();

            entity.HasIndex(e => e.Ssn, "UQ__Instruct__CA1E8E3CD05AFC45").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Address)
                .HasMaxLength(200)
                .HasColumnName("address");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("email");
            entity.Property(e => e.EnrollmentDate)
                .HasColumnType("datetime")
                .HasColumnName("enrollmentDate");
            entity.Property(e => e.FirstName)
                .HasMaxLength(20)
                .HasColumnName("firstName");
            entity.Property(e => e.Gender)
                .HasMaxLength(1)
                .HasColumnName("gender");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.LastName)
                .HasMaxLength(20)
                .HasColumnName("lastName");
            entity.Property(e => e.Phone)
                .HasMaxLength(15)
                .HasColumnName("phone");
            entity.Property(e => e.Ssn)
                .HasMaxLength(20)
                .HasColumnName("SSN");
        });

        modelBuilder.Entity<QuestionBank>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Question__3214EC27602A1141");

            entity.ToTable("QuestionBank");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CorrectChoice)
                .HasMaxLength(200)
                .HasColumnName("correctChoice");
            entity.Property(e => e.CourseId).HasColumnName("courseID");
            entity.Property(e => e.InsertionDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("insertionDate");
            entity.Property(e => e.InstructorId).HasColumnName("instructorID");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.QuestionText)
                .HasMaxLength(200)
                .HasColumnName("questionText");
            entity.Property(e => e.Type)
                .HasMaxLength(50)
                .HasColumnName("type");

            entity.HasOne(d => d.Course).WithMany(p => p.QuestionBanks)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__QuestionB__cours__656C112C");

            entity.HasOne(d => d.Instructor).WithMany(p => p.QuestionBanks)
                .HasForeignKey(d => d.InstructorId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__QuestionB__instr__6477ECF3");
        });

        modelBuilder.Entity<QuestionBankChoice>(entity =>
        {
            entity.HasKey(e => new { e.QuestionId, e.Choice }).HasName("PK__Question__90F6A66A39E34133");

            entity.ToTable("QuestionBank_Choice");

            entity.Property(e => e.QuestionId).HasColumnName("questionID");
            entity.Property(e => e.Choice).HasMaxLength(200);
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");

            entity.HasOne(d => d.Question).WithMany(p => p.QuestionBankChoices)
                .HasForeignKey(d => d.QuestionId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__QuestionB__quest__7F2BE32F");
        });

        modelBuilder.Entity<Student>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Student__3214EC270133B1E4");

            entity.ToTable("Student");

            entity.HasIndex(e => e.Email, "UQ__Student__AB6E6164EA4F3A50").IsUnique();

            entity.HasIndex(e => e.Phone, "UQ__Student__B43B145F789254A2").IsUnique();

            entity.HasIndex(e => e.Ssn, "UQ__Student__CA1E8E3CC2644154").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Address)
                .HasMaxLength(200)
                .HasColumnName("address");
            entity.Property(e => e.BranchId).HasColumnName("branchID");
            entity.Property(e => e.DepartmentId).HasColumnName("departmentID");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("email");
            entity.Property(e => e.EnrollmentDate)
                .HasColumnType("datetime")
                .HasColumnName("enrollmentDate");
            entity.Property(e => e.FirstName)
                .HasMaxLength(20)
                .HasColumnName("firstName");
            entity.Property(e => e.Gender)
                .HasMaxLength(10)
                .HasColumnName("gender");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.LastName)
                .HasMaxLength(20)
                .HasColumnName("lastName");
            entity.Property(e => e.Phone)
                .HasMaxLength(15)
                .HasColumnName("phone");
            entity.Property(e => e.Ssn)
                .HasMaxLength(20)
                .HasColumnName("SSN");
            entity.Property(e => e.TrackId).HasColumnName("trackID");

            entity.HasOne(d => d.BranchDepartmentTrack).WithMany(p => p.Students)
                .HasForeignKey(d => new { d.TrackId, d.DepartmentId, d.BranchId })
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Student__5AEE82B9");
        });

        modelBuilder.Entity<StudentSubmit>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__StudentS__3214EC2765B8348D");

            entity.ToTable("StudentSubmit");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.ExamModelId).HasColumnName("examModelID");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.StudentId).HasColumnName("studentID");
            entity.Property(e => e.SubmitDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("submitDate");

            entity.HasOne(d => d.ExamModel).WithMany(p => p.StudentSubmits)
                .HasForeignKey(d => d.ExamModelId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__StudentSu__examM__70DDC3D8");

            entity.HasOne(d => d.Student).WithMany(p => p.StudentSubmits)
                .HasForeignKey(d => d.StudentId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__StudentSu__stude__6FE99F9F");
        });

        modelBuilder.Entity<StudentSubmitAnswer>(entity =>
        {
            entity.HasKey(e => new { e.StudentSubmitId, e.StudentAnswer }).HasName("PK__StudentS__660F8DE877CAD984");

            entity.ToTable("StudentSubmit_Answer");

            entity.Property(e => e.StudentSubmitId).HasColumnName("StudentSubmitID");
            entity.Property(e => e.StudentAnswer)
                .HasMaxLength(200)
                .HasColumnName("studentAnswer");
            entity.Property(e => e.ExamModelId).HasColumnName("examModelID");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.QuestionId).HasColumnName("questionID");

            entity.HasOne(d => d.StudentSubmit).WithMany(p => p.StudentSubmitAnswers)
                .HasForeignKey(d => d.StudentSubmitId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__StudentSu__Stude__06CD04F7");

            entity.HasOne(d => d.ExamModelQuestion).WithMany(p => p.StudentSubmitAnswers)
                .HasForeignKey(d => new { d.ExamModelId, d.QuestionId })
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__StudentSubmit_An__07C12930");
        });

        modelBuilder.Entity<Track>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Track__3214EC27FD2C4C89");

            entity.ToTable("Track");

            entity.HasIndex(e => e.Name, "UQ__Track__737584F6EBD40B58").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CreationDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("creationDate");
            entity.Property(e => e.DepartmentId).HasColumnName("departmentID");
            entity.Property(e => e.IsDeleted)
                .HasDefaultValue(false)
                .HasColumnName("isDeleted");
            entity.Property(e => e.Name).HasMaxLength(100);

            entity.HasOne(d => d.Department).WithMany(p => p.Tracks)
                .HasForeignKey(d => d.DepartmentId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("FK__Track__departmen__4BAC3F29");

            entity.HasMany(d => d.Courses).WithMany(p => p.Tracks)
                .UsingEntity<Dictionary<string, object>>(
                    "TrackCourse",
                    r => r.HasOne<Course>().WithMany()
                        .HasForeignKey("CourseId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .HasConstraintName("FK__Track_Cou__cours__14270015"),
                    l => l.HasOne<Track>().WithMany()
                        .HasForeignKey("TrackId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .HasConstraintName("FK__Track_Cou__track__1332DBDC"),
                    j =>
                    {
                        j.HasKey("TrackId", "CourseId").HasName("PK__Track_Co__571F7D4D247BC863");
                        j.ToTable("Track_Course");
                        j.IndexerProperty<int>("TrackId").HasColumnName("trackID");
                        j.IndexerProperty<int>("CourseId").HasColumnName("courseID");
                    });
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
