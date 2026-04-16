<script>
  function showSection(id) {
    document.querySelectorAll('section').forEach(function(sec) {
      sec.style.display = 'none';
    });
    document.getElementById(id).style.display = 'block';

    // Reset job forms when entering career
    if (id === 'career') {
      document.querySelectorAll('.job-form').forEach(function(form) {
        form.style.display = 'none';
      });
    }
  }

  function openJob(role) {
    document.querySelectorAll('.job-form').forEach(function(form) {
      form.style.display = 'none';
    });

    document.getElementById(role).style.display = 'block';
  }
</script>