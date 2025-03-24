const initFormSubmission = () => {
    // Prevent double submission
    const form = document.querySelector(".form-handler");
    const submitBtn = document.querySelector(".submit-handler");

    if (!form || !submitBtn) {
        return
    }

    form.addEventListener("submit", function() {
        submitBtn.disabled = true;
        submitBtn.value = "Creating..."; // Matches data-disable-with
    });
}

export {
    initFormSubmission
}