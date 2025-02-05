using System;
using System.Collections.Generic;

namespace Examination_System.Models;

public partial class Course
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public bool? IsDeleted { get; set; }

    public DateTime? CreationDate { get; set; }

    public virtual ICollection<CourseField> CourseFields { get; set; } = new List<CourseField>();

    public virtual ICollection<CourseStudentInstructor> CourseStudentInstructors { get; set; } = new List<CourseStudentInstructor>();

    public virtual ICollection<CourseTopic> CourseTopics { get; set; } = new List<CourseTopic>();

    public virtual ICollection<ExamModel> ExamModels { get; set; } = new List<ExamModel>();

    public virtual ICollection<QuestionBank> QuestionBanks { get; set; } = new List<QuestionBank>();

    public virtual ICollection<Instructor> Instructors { get; set; } = new List<Instructor>();

    public virtual ICollection<Track> Tracks { get; set; } = new List<Track>();
}
