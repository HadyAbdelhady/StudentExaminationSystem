// Toggle sidebar
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('active');
}

// Close sidebar when clicking outside
document.addEventListener('click', function (event) {
    const sidebar = document.querySelector('.sidebar');
    const sidebarToggle = document.querySelector('.sidebar-toggle');

    if (!sidebar.contains(event.target) && !sidebarToggle.contains(event.target)) {
        sidebar.classList.remove('active');
    }
});

// Search functionality
document.getElementById('searchForm').addEventListener('submit', function (event) {
    event.preventDefault(); // Prevent form submission

    const searchTerm = document.getElementById('searchInput').value.trim().toLowerCase();
    const searchMappings = {
        'home': '/Home/Index',
        'branches': '/Branch/Index',
        'courses': '#', // Replace 
        'departments': '/Department/Index',
        'instructors': '/Instructor/Index'
    };

    if (searchMappings[searchTerm]) {
        window.location.href = searchMappings[searchTerm];
    } else {
        alert('No matching page found for your search term.');
    }
});