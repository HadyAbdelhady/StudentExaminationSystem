$(document).ready(function () {
    $('#examManagerTable').DataTable({
      responsive: true,
      pageLength: 20,
      lengthChange: false,
      ordering: false,
      searching: true,
      responsive: true,
      // autoWidth: false,
      info:false
    });

    $('#addExamBtn').on('click', function () {
      alert('Add Exam button clicked! Implement logic to add a new exam.');
    });
  });

  document.querySelectorAll(".toggle-view").forEach((button, index) => {
    button.addEventListener("click", function () {
      const answerRow = document.querySelectorAll(".answer-row")[index];
      if (answerRow.style.display === "none" || !answerRow.style.display) {
        answerRow.style.display = "table-row";
        button.textContent = "Hide";
      } else {
        answerRow.style.display = "none";
        button.textContent = "View";
      }
    });
  });