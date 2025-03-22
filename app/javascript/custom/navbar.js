// app/javascript/navbar.js
const navbar = () => document.addEventListener('DOMContentLoaded', function () {
  
  // Toggle profile dropdown
  const profileButton = document.getElementById('user-menu-button');
  const profileDropdown = document.querySelector('[aria-labelledby="user-menu-button"]');

  profileButton.addEventListener('click', function () {
    console.log(window.Turbo && window.Turbo.version);
    const isOpen = profileDropdown.getAttribute('aria-expanded') === 'true';
    profileDropdown.setAttribute('aria-expanded', !isOpen);
    profileDropdown.classList.toggle('hidden', isOpen);
  });

  // Toggle mobile menu
  const mobileMenuButton = document.querySelector('[aria-controls="mobile-menu"]');
  const mobileMenu = document.getElementById('mobile-menu');

  mobileMenuButton.addEventListener('click', function () {
    const isOpen = mobileMenu.classList.contains('hidden');
    mobileMenu.classList.toggle('hidden', !isOpen);
  });

  // Close dropdowns when clicking outside
  document.addEventListener('click', function (event) {
    if (!profileButton.contains(event.target)) {
      profileDropdown.setAttribute('aria-expanded', 'false');
      profileDropdown.classList.add('hidden');
    }
    if (!mobileMenuButton.contains(event.target)) {
      mobileMenu.classList.add('hidden');
    }
  });
});

navbar()