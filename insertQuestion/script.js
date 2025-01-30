        // Toggle between True/False and Multiple Choice
        const tfToggle = document.getElementById('tfToggle');
        const multipleChoice = document.getElementById('multipleChoice');
        const trueFalse = document.getElementById('trueFalse');

        tfToggle.addEventListener('change', function () {
            if (this.checked) {
                multipleChoice.style.display = 'none';
                trueFalse.style.display = 'flex';
            } 
          
        });
        mcqToggle.addEventListener('change', function () {
            if (this.checked) {
                multipleChoice.style.display = 'flex';
                trueFalse.style.display = 'none';
                // Reset columns layout
                document.querySelectorAll('.radio-column').forEach(col => {
                    col.style.display = 'flex';
                });
            } 
        });

        // Auto-expanding textareas (updated for columns)
        function autoResize() {
            this.style.height = 'auto';
            this.style.height = this.scrollHeight + 'px';
        }

        // Initialize for all textareas
        document.querySelectorAll('.form-control').forEach(textarea => {
            textarea.addEventListener('input', autoResize);
            autoResize.call(textarea);
        });