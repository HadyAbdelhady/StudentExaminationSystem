document.getElementById('examForm').addEventListener('submit', (event) => {
    event.preventDefault();
    alert('Exam Submitted!');
});

// Timer functionality
let examDuration = 7200; // 2 hours in seconds
let timer;

function startTimer(duration) {
    let timerDisplay = document.getElementById('countdown');

    function updateTimer() {
        let hours = Math.floor(duration / 3600);
        let minutes = Math.floor((duration % 3600) / 60);
        let seconds = duration % 60;

        hours = hours < 10 ? "0" + hours : hours;
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        timerDisplay.textContent = hours + ":" + minutes + ":" + seconds;

        if (--duration < 0) {
            clearInterval(timer);
            alert('Time is up! Submitting exam...');
            document.getElementById('examForm').submit();
        }
    }

    updateTimer();
    timer = setInterval(updateTimer, 1000);
}
startTimer(examDuration);