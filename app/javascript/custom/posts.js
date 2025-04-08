const initPostDateToggler = () => {
    console.log("Initializing Post Date Toggler...");
    const exactDates = document.getElementById("exact-dates");
    const approxRange = document.getElementById("approx-range");
    const toggles = document.querySelectorAll("input[name='date_toggle']");

    toggles.forEach(toggle => {
        toggle.addEventListener("change", function() {
            if (this.value === "exact") {
                exactDates.classList.remove("hidden");
                approxRange.classList.add("hidden");
                document.getElementById("post_date_range").disabled = true;
                document.getElementById("post_start_date").disabled = false;
                document.getElementById("post_end_date").disabled = false;
            } else {
                exactDates.classList.add("hidden");
                approxRange.classList.remove("hidden");
                document.getElementById("post_date_range").disabled = false;
                document.getElementById("post_start_date").disabled = true;
                document.getElementById("post_end_date").disabled = true;
            }
        });
    });
}

const postCustomDateFilter = () => {
    const dateFilter = document.getElementById("date-filter");
    const customDates = document.getElementById("custom-dates");

    if (!dateFilter || !customDates) {
        return
    }

    dateFilter.addEventListener("change", function() {
        if (this.value === "custom") {
            customDates.classList.remove("hidden");
            customDates.classList.add("flex");
        } else {
            customDates.classList.add("hidden");
            customDates.classList.remove("flex");
        }
    });
}

const mobileFilter = () => {
    // Mobile Filter Toggle
    const filterToggle = document.getElementById("filter-toggle");
    const filterForm = document.getElementById("filter-form");
    const toggleIcon = document.getElementById("toggle-icon");

    if (!filterForm || !filterToggle || !toggleIcon) {
        return
    }
    filterToggle.addEventListener("click", function() {
        filterForm.classList.toggle("hidden");
        filterForm.classList.toggle("flex");
        toggleIcon.classList.toggle("rotate-180");
    });
}

const imagePreview = () => {
    const input = document.querySelector(".images");
    const previewContainer = document.getElementById("image-previews");
    const errorContainer = document.getElementById("image-errors");

    let selectedFiles = [];

    input?.addEventListener("change", function () {
        const newFiles = Array.from(input.files);
        const errors = [];

        newFiles.forEach(file => {
            if (!file.type.startsWith("image/")) {
                errors.push(`${file.name} is not a valid image file.`);
                return;
            }

            if (file.size > 5 * 1024 * 1024) {
                errors.push(`${file.name} is larger than 5MB.`);
                return;
            }

            if (selectedFiles.length >= 5) {
                errors.push(`Maximum of 5 images allowed.`);
                return;
            }

            // prevent duplicates by checking name and size
            const exists = selectedFiles.some(
                f => f.name === file.name && f.size === file.size
            );
            if (!exists) {
                selectedFiles.push(file);
                renderSinglePreview(file, selectedFiles.length - 1);
            }
        });

        errorContainer.textContent = errors.join(" ");
        updateInputFiles();
    });

    function renderSinglePreview(file, index) {
        const reader = new FileReader();

        reader.onload = function (e) {
            const wrapper = document.createElement("div");
            wrapper.className = "relative";

            const img = document.createElement("img");
            img.src = e.target.result;
            img.className = "h-24 w-24 object-cover rounded border border-gray-300";

            const removeBtn = document.createElement("button");
            removeBtn.textContent = "✕";
            removeBtn.type = "button";
            removeBtn.className = "absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center shadow";

            removeBtn.addEventListener("click", () => {
                selectedFiles.splice(index, 1);
                wrapper.remove();
                updateInputFiles();
            });

            wrapper.appendChild(img);
            wrapper.appendChild(removeBtn);
            previewContainer.appendChild(wrapper);
        };

        reader.readAsDataURL(file);
    }

    function updateInputFiles() {
        const dataTransfer = new DataTransfer();
        selectedFiles.forEach(file => dataTransfer.items.add(file));
        input.files = dataTransfer.files;
    }
}

const togglePostImageUpload = () => {
    const postType = document.querySelector('#post-type')
    const imageInput = document.querySelector('.images')
    const imageBlock = document.querySelector('#image-block')
    if (postType?.value === 'sender') {
        imageInput.required = true
        imageBlock.classList.add('block')
        imageBlock.classList.remove('hidden')
    } else {
        imageInput.required = false
        imageBlock.classList.add('hidden')
        imageBlock.classList.remove('block')
    }
}


export {
    initPostDateToggler,
    postCustomDateFilter,
    mobileFilter,
    imagePreview,
    togglePostImageUpload
}