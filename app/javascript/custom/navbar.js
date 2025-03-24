const initNavbar = () => {
    console.log("Initializing Navbar...");

    const profileButton = document.getElementById('user-menu-button');
    const profileDropdown = document.querySelector('[aria-labelledby="user-menu-button"]');

    if (profileButton && profileDropdown) {
        profileButton.addEventListener('click', function () {
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

export {
    initNavbar
}