$(document).ready(function () {
  $('#examManagerTable').DataTable({
    responsive: true,
    pageLength: 20,
    lengthChange: false,
    ordering: false,
    searching: true,
    responsive: true,
    // autoWidth: false,
    info: false
  });

  $('#addExamBtn').on('click', function () {
    alert('Add Exam button clicked! Implement logic to add a new exam.');
  });
  
  //////////////////// VIEW CARD ////////////////////

  document.querySelectorAll(".toggle-view").forEach((button, index) => {
    button.addEventListener("click", function (event) {
      event.stopPropagation(); // Prevents click from immediately hiding the card
      const answerRow = document.querySelectorAll(".card-container")[index];
      const bodyContent = document.getElementById("body-content");

      if (
        answerRow.style.display === "none" ||
        answerRow.style.display === ""
      ) {
        answerRow.style.display = "block"; // Show the card
        bodyContent.style.filter = "blur(5px)"; // Apply blur to background
      } else {
        answerRow.style.display = "none"; // Hide the card
        bodyContent.style.filter = "none"; // Remove blur effect
      }
    });
  });

  // Hide the card and remove blur on click outside
  document.addEventListener("click", function (event) {
    document.querySelectorAll(".card-container").forEach((card) => {
      if (!card.contains(event.target)) {
        card.style.display = "none";
        document.getElementById("body-content").style.filter = "none";
      }
    });
  });



});




