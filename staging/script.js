function showSection(id) {
  document.querySelectorAll('section').forEach(function(sec) {
    sec.style.display = 'none';
  });

  document.getElementById(id).style.display = 'block';

  // Reset job forms when opening career
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

  var selected = document.getElementById(role);
  if (selected) {
    selected.style.display = 'block';
  }
}