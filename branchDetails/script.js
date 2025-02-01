document.querySelectorAll('.toggle-tracks').forEach(button => {
    button.addEventListener('click', function () {
        const trackRow = this.closest('tr').nextElementSibling;
        if (trackRow.style.display === "none") {
            trackRow.style.display = "table-row";
            this.textContent = "Hide Tracks";
        } else {
            trackRow.style.display = "none";
            this.textContent = "Show Tracks";
        }
    });
});