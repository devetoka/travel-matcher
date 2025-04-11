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

export {
    initFileUploadCheck
}