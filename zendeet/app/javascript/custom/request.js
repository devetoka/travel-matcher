const showModal = (element = null) => {
    if (!element) return

    const modal = document.getElementById('request-modal');
    const content = document.getElementById('modal-content');

    // Populate modal with data from the clicked element
    document.getElementById('modal-type').textContent = element.dataset.postType.capitalize();
    document.getElementById('modal-route').textContent = `${element.dataset.postOrigin} to ${element.dataset.postDestination}`;
    document.getElementById('modal-dates').textContent = element.dataset.postDates;
    document.getElementById('modal-description').textContent = element.dataset.postDescription || 'None';
    document.getElementById('modal-user').textContent = element.dataset.postUser;
    document.getElementById('modal-user').href = element.dataset.postUserPath;

    // Show modal
    modal?.classList.remove('hidden');
    modal.querySelector('.modal-open')?.classList.remove('scale-95');
    modal.querySelector('.modal-open')?.classList?.add('scale-100');
}

function hideModal() {
    const modal = document.getElementById('request-modal');
    modal?.classList?.add('hidden');
}

function showImageModal(imageUrl) {
    if (!document.getElementById('full-image')) return
    const modal = document.getElementById('image-modal');
    document.getElementById('full-image').src = imageUrl;
    modal.classList.remove('hidden');
}

function hideImageModal() {
    if (!document.getElementById('image-modal')) return
    document.getElementById('image-modal').classList.add('hidden');
}

function init() {

    document.addEventListener('click', (e) => {
        const modal = document.getElementById('request-modal');
        if (e.target === modal && !modal.classList?.contains('hidden')) {
            hideModal();
        }
    });
}

// Capitalize helper (since dataset values aren't capitalized)
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
};


export {
    showModal,
    hideModal,
    init,
    showImageModal,
    hideImageModal
}