const initNavbar = () => {
  console.log("Initializing Navbar...");

  const profileButton = document.getElementById('user-menu-button');
  const profileDropdown = document.querySelector('[aria-labelledby="user-menu-button"]');

  if (profileButton && profileDropdown) {
    profileButton.addEventListener('click', function () {
      console.log(window.Turbo && window.Turbo.version);
      const isOpen = profileDropdown.getAttribute('aria-expanded') === 'true';
      profileDropdown.setAttribute('aria-expanded', !isOpen);
      profileDropdown.classList.toggle('hidden', isOpen);
    });
  }

  // Toggle mobile menu
  const mobileMenuButton = document.querySelector('[aria-controls="mobile-menu"]');
  const mobileMenu = document.getElementById('mobile-menu');

  if (mobileMenuButton && mobileMenu) {
    mobileMenuButton.addEventListener('click', function () {
      const isOpen = mobileMenu.classList.contains('hidden');
      mobileMenu.classList.toggle('hidden', !isOpen);
    });
  }

  // Close dropdowns when clicking outside
  document.addEventListener('click', function (event) {
    if (profileButton && profileDropdown && !profileButton.contains(event.target)) {
      profileDropdown.setAttribute('aria-expanded', 'false');
      profileDropdown.classList.add('hidden');
    }
    if (mobileMenuButton && mobileMenu && !mobileMenuButton.contains(event.target)) {
      mobileMenu.classList.add('hidden');
    }
  });
};

const initFileUploadCheck = () => {
  console.log("Initializing File Upload Check...");

  document.querySelectorAll(".valid-image").forEach(input => {
    input.addEventListener("change", function(event) {
      const file = event.target.files[0];
      if (file && !["image/png", "image/jpg", "image/jpeg"].includes(file.type)) {
        alert("Invalid file type! Only PNG, JPG, and JPEG are allowed.");
        event.target.value = ""; // Clear the file input
      }
    });
  });
};

// Ensure scripts run on both initial load and Turbo navigation
const initializeScripts = () => {
  initNavbar();
  initFileUploadCheck();
};

// Use turbo:load for both initial and subsequent loads
document.addEventListener('turbo:load', initializeScripts);
