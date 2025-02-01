$(document).ready(function () {
    $('#examManagerTable').DataTable({
      responsive: true,
      pageLength: 20,
      lengthChange: false,
      ordering: true,
      searching: true,
    });

    $('#addExamBtn').on('click', function () {
      alert('Add Exam button clicked! Implement logic to add a new exam.');
    });
  });