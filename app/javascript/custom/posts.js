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

export {
    initPostDateToggler,
    postCustomDateFilter,
    mobileFilter
}