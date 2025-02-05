using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Examination_System.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Course",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    creationDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Course__3214EC275B31593B", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Department",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Departme__3214EC27F1174726", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Instructor",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    firstName = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    lastName = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    gender = table.Column<string>(type: "nvarchar(1)", maxLength: 1, nullable: true),
                    SSN = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    enrollmentDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    phone = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    DateOfBirth = table.Column<DateOnly>(type: "date", nullable: false),
                    address = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Instruct__3214EC27615FFC41", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Course_Field",
                columns: table => new
                {
                    courseID = table.Column<int>(type: "int", nullable: false),
                    field = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Course_F__FA0A049F1690AEBE", x => new { x.courseID, x.field });
                    table.ForeignKey(
                        name: "FK__Course_Fi__cours__797309D9",
                        column: x => x.courseID,
                        principalTable: "Course",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Course_Topic",
                columns: table => new
                {
                    courseID = table.Column<int>(type: "int", nullable: false),
                    topic = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Course_T__5613C55F38A13EE0", x => new { x.courseID, x.topic });
                    table.ForeignKey(
                        name: "FK__Course_To__cours__74AE54BC",
                        column: x => x.courseID,
                        principalTable: "Course",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Track",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    departmentID = table.Column<int>(type: "int", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime", nullable: false, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Track__3214EC27FD2C4C89", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Track__departmen__4BAC3F29",
                        column: x => x.departmentID,
                        principalTable: "Department",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Branch",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Location = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    phone = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    establishmentDate = table.Column<DateTime>(type: "datetime", nullable: true),
                    ManagerID = table.Column<int>(type: "int", nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Branch__3214EC27006B4EAE", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Branch__ManagerI__4222D4EF",
                        column: x => x.ManagerID,
                        principalTable: "Instructor",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Course_Instructor",
                columns: table => new
                {
                    courseID = table.Column<int>(type: "int", nullable: false),
                    instructorID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Course_I__7AAB5053D51FA578", x => new { x.courseID, x.instructorID });
                    table.ForeignKey(
                        name: "FK__Course_In__cours__0F624AF8",
                        column: x => x.courseID,
                        principalTable: "Course",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Course_In__instr__10566F31",
                        column: x => x.instructorID,
                        principalTable: "Instructor",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Department_Instructor",
                columns: table => new
                {
                    departmentID = table.Column<int>(type: "int", nullable: false),
                    instructorID = table.Column<int>(type: "int", nullable: false),
                    joinDate = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Departme__A9BB2BEFC5DA4CD5", x => new { x.departmentID, x.instructorID });
                    table.ForeignKey(
                        name: "FK__Departmen__depar__17036CC0",
                        column: x => x.departmentID,
                        principalTable: "Department",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Departmen__instr__17F790F9",
                        column: x => x.instructorID,
                        principalTable: "Instructor",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "ExamModel",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    date = table.Column<DateOnly>(type: "date", nullable: false),
                    startTime = table.Column<TimeOnly>(type: "time", nullable: false),
                    endTime = table.Column<TimeOnly>(type: "time", nullable: false),
                    CourseID = table.Column<int>(type: "int", nullable: false),
                    instructorID = table.Column<int>(type: "int", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ExamMode__3214EC27B24958E0", x => x.ID);
                    table.ForeignKey(
                        name: "FK__ExamModel__Cours__6B24EA82",
                        column: x => x.CourseID,
                        principalTable: "Course",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__ExamModel__instr__6C190EBB",
                        column: x => x.instructorID,
                        principalTable: "Instructor",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "QuestionBank",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    type = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    correctChoice = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    instructorID = table.Column<int>(type: "int", nullable: false),
                    courseID = table.Column<int>(type: "int", nullable: false),
                    insertionDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    questionText = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Question__3214EC27602A1141", x => x.ID);
                    table.ForeignKey(
                        name: "FK__QuestionB__cours__656C112C",
                        column: x => x.courseID,
                        principalTable: "Course",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__QuestionB__instr__6477ECF3",
                        column: x => x.instructorID,
                        principalTable: "Instructor",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Track_Course",
                columns: table => new
                {
                    trackID = table.Column<int>(type: "int", nullable: false),
                    courseID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Track_Co__571F7D4D247BC863", x => new { x.trackID, x.courseID });
                    table.ForeignKey(
                        name: "FK__Track_Cou__cours__14270015",
                        column: x => x.courseID,
                        principalTable: "Course",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Track_Cou__track__1332DBDC",
                        column: x => x.trackID,
                        principalTable: "Track",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Branch_Department_Track",
                columns: table => new
                {
                    branchID = table.Column<int>(type: "int", nullable: false),
                    trackID = table.Column<int>(type: "int", nullable: false),
                    departmentID = table.Column<int>(type: "int", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    departmentManagerID = table.Column<int>(type: "int", nullable: false),
                    trackManagerID = table.Column<int>(type: "int", nullable: false),
                    DepartementManagerJoinDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    TrackManagerJoinDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Branch_D__A45B644BF51F4CEB", x => new { x.trackID, x.departmentID, x.branchID });
                    table.ForeignKey(
                        name: "FK__Branch_De__branc__5070F446",
                        column: x => x.branchID,
                        principalTable: "Branch",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Branch_De__depar__52593CB8",
                        column: x => x.departmentID,
                        principalTable: "Department",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Branch_De__depar__534D60F1",
                        column: x => x.departmentManagerID,
                        principalTable: "Instructor",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Branch_De__track__5165187F",
                        column: x => x.trackID,
                        principalTable: "Track",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Branch_De__track__5441852A",
                        column: x => x.trackManagerID,
                        principalTable: "Instructor",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "ExamModel_Question",
                columns: table => new
                {
                    examModelID = table.Column<int>(type: "int", nullable: false),
                    questionID = table.Column<int>(type: "int", nullable: false),
                    mark = table.Column<int>(type: "int", nullable: false),
                    correctChoice = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ExamMode__35117C44B0348E50", x => new { x.examModelID, x.questionID });
                    table.ForeignKey(
                        name: "FK__ExamModel__examM__02084FDA",
                        column: x => x.examModelID,
                        principalTable: "ExamModel",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__ExamModel__quest__02FC7413",
                        column: x => x.questionID,
                        principalTable: "QuestionBank",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "QuestionBank_Choice",
                columns: table => new
                {
                    questionID = table.Column<int>(type: "int", nullable: false),
                    Choice = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Question__90F6A66A39E34133", x => new { x.questionID, x.Choice });
                    table.ForeignKey(
                        name: "FK__QuestionB__quest__7F2BE32F",
                        column: x => x.questionID,
                        principalTable: "QuestionBank",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Student",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    firstName = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    lastName = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    gender = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    SSN = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    enrollmentDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    phone = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    DateOfBirth = table.Column<DateOnly>(type: "date", nullable: false),
                    address = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    trackID = table.Column<int>(type: "int", nullable: false),
                    branchID = table.Column<int>(type: "int", nullable: false),
                    departmentID = table.Column<int>(type: "int", nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Student__3214EC270133B1E4", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Student__5AEE82B9",
                        columns: x => new { x.trackID, x.departmentID, x.branchID },
                        principalTable: "Branch_Department_Track",
                        principalColumns: new[] { "trackID", "departmentID", "branchID" });
                });

            migrationBuilder.CreateTable(
                name: "Course_Student_Instructor",
                columns: table => new
                {
                    courseID = table.Column<int>(type: "int", nullable: false),
                    studentID = table.Column<int>(type: "int", nullable: false),
                    instructorID = table.Column<int>(type: "int", nullable: false),
                    startDate = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Course_S__DB79636E7F0F3647", x => new { x.courseID, x.studentID, x.instructorID });
                    table.ForeignKey(
                        name: "FK__Course_St__cours__0A9D95DB",
                        column: x => x.courseID,
                        principalTable: "Course",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Course_St__instr__0C85DE4D",
                        column: x => x.instructorID,
                        principalTable: "Instructor",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Course_St__stude__0B91BA14",
                        column: x => x.studentID,
                        principalTable: "Student",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "StudentSubmit",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    studentID = table.Column<int>(type: "int", nullable: false),
                    examModelID = table.Column<int>(type: "int", nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    submitDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__StudentS__3214EC2765B8348D", x => x.ID);
                    table.ForeignKey(
                        name: "FK__StudentSu__examM__70DDC3D8",
                        column: x => x.examModelID,
                        principalTable: "ExamModel",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__StudentSu__stude__6FE99F9F",
                        column: x => x.studentID,
                        principalTable: "Student",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "StudentSubmit_Answer",
                columns: table => new
                {
                    StudentSubmitID = table.Column<int>(type: "int", nullable: false),
                    studentAnswer = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    examModelID = table.Column<int>(type: "int", nullable: false),
                    questionID = table.Column<int>(type: "int", nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__StudentS__660F8DE877CAD984", x => new { x.StudentSubmitID, x.studentAnswer });
                    table.ForeignKey(
                        name: "FK__StudentSu__Stude__06CD04F7",
                        column: x => x.StudentSubmitID,
                        principalTable: "StudentSubmit",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__StudentSubmit_An__07C12930",
                        columns: x => new { x.examModelID, x.questionID },
                        principalTable: "ExamModel_Question",
                        principalColumns: new[] { "examModelID", "questionID" });
                });

            migrationBuilder.CreateIndex(
                name: "UQ__Branch__3BA2AA8068ED412E",
                table: "Branch",
                column: "ManagerID",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "UQ__Branch__737584F6716EF5C9",
                table: "Branch",
                column: "Name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "UQ__Branch__B43B145FED3E75ED",
                table: "Branch",
                column: "phone",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Branch_Department_Track_branchID",
                table: "Branch_Department_Track",
                column: "branchID");

            migrationBuilder.CreateIndex(
                name: "IX_Branch_Department_Track_departmentID",
                table: "Branch_Department_Track",
                column: "departmentID");

            migrationBuilder.CreateIndex(
                name: "IX_Branch_Department_Track_departmentManagerID",
                table: "Branch_Department_Track",
                column: "departmentManagerID");

            migrationBuilder.CreateIndex(
                name: "IX_Branch_Department_Track_trackManagerID",
                table: "Branch_Department_Track",
                column: "trackManagerID");

            migrationBuilder.CreateIndex(
                name: "UQ__Course__737584F61367C110",
                table: "Course",
                column: "Name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Course_Instructor_instructorID",
                table: "Course_Instructor",
                column: "instructorID");

            migrationBuilder.CreateIndex(
                name: "IX_Course_Student_Instructor_instructorID",
                table: "Course_Student_Instructor",
                column: "instructorID");

            migrationBuilder.CreateIndex(
                name: "IX_Course_Student_Instructor_studentID",
                table: "Course_Student_Instructor",
                column: "studentID");

            migrationBuilder.CreateIndex(
                name: "UQ__Departme__737584F653CD3C1A",
                table: "Department",
                column: "Name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Department_Instructor_instructorID",
                table: "Department_Instructor",
                column: "instructorID");

            migrationBuilder.CreateIndex(
                name: "IX_ExamModel_CourseID",
                table: "ExamModel",
                column: "CourseID");

            migrationBuilder.CreateIndex(
                name: "IX_ExamModel_instructorID",
                table: "ExamModel",
                column: "instructorID");

            migrationBuilder.CreateIndex(
                name: "IX_ExamModel_Question_questionID",
                table: "ExamModel_Question",
                column: "questionID");

            migrationBuilder.CreateIndex(
                name: "UQ__Instruct__AB6E6164FDC0C5F7",
                table: "Instructor",
                column: "email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "UQ__Instruct__B43B145F2BC98A4C",
                table: "Instructor",
                column: "phone",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "UQ__Instruct__CA1E8E3CD05AFC45",
                table: "Instructor",
                column: "SSN",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_QuestionBank_courseID",
                table: "QuestionBank",
                column: "courseID");

            migrationBuilder.CreateIndex(
                name: "IX_QuestionBank_instructorID",
                table: "QuestionBank",
                column: "instructorID");

            migrationBuilder.CreateIndex(
                name: "IX_Student_trackID_departmentID_branchID",
                table: "Student",
                columns: new[] { "trackID", "departmentID", "branchID" });

            migrationBuilder.CreateIndex(
                name: "UQ__Student__AB6E6164EA4F3A50",
                table: "Student",
                column: "email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "UQ__Student__B43B145F789254A2",
                table: "Student",
                column: "phone",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "UQ__Student__CA1E8E3CC2644154",
                table: "Student",
                column: "SSN",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_StudentSubmit_examModelID",
                table: "StudentSubmit",
                column: "examModelID");

            migrationBuilder.CreateIndex(
                name: "IX_StudentSubmit_studentID",
                table: "StudentSubmit",
                column: "studentID");

            migrationBuilder.CreateIndex(
                name: "IX_StudentSubmit_Answer_examModelID_questionID",
                table: "StudentSubmit_Answer",
                columns: new[] { "examModelID", "questionID" });

            migrationBuilder.CreateIndex(
                name: "IX_Track_departmentID",
                table: "Track",
                column: "departmentID");

            migrationBuilder.CreateIndex(
                name: "UQ__Track__737584F6EBD40B58",
                table: "Track",
                column: "Name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Track_Course_courseID",
                table: "Track_Course",
                column: "courseID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Course_Field");

            migrationBuilder.DropTable(
                name: "Course_Instructor");

            migrationBuilder.DropTable(
                name: "Course_Student_Instructor");

            migrationBuilder.DropTable(
                name: "Course_Topic");

            migrationBuilder.DropTable(
                name: "Department_Instructor");

            migrationBuilder.DropTable(
                name: "QuestionBank_Choice");

            migrationBuilder.DropTable(
                name: "StudentSubmit_Answer");

            migrationBuilder.DropTable(
                name: "Track_Course");

            migrationBuilder.DropTable(
                name: "StudentSubmit");

            migrationBuilder.DropTable(
                name: "ExamModel_Question");

            migrationBuilder.DropTable(
                name: "Student");

            migrationBuilder.DropTable(
                name: "ExamModel");

            migrationBuilder.DropTable(
                name: "QuestionBank");

            migrationBuilder.DropTable(
                name: "Branch_Department_Track");

            migrationBuilder.DropTable(
                name: "Course");

            migrationBuilder.DropTable(
                name: "Branch");

            migrationBuilder.DropTable(
                name: "Track");

            migrationBuilder.DropTable(
                name: "Instructor");

            migrationBuilder.DropTable(
                name: "Department");
        }
    }
}
