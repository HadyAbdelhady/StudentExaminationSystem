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
