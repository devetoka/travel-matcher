
// Ensure scripts run on both initial load and Turbo navigation
import {initNavbar} from "./navbar";
import {initFormSubmission} from "./form";
import {initPostDateToggler, mobileFilter, postCustomDateFilter} from "./posts";
import {initFileUploadCheck} from "./file";
import {showModal, hideModal, init} from "./request";

const initializeScripts = () => {
  initNavbar();
  initFileUploadCheck();
  initPostDateToggler();
  initFormSubmission()
  postCustomDateFilter()
  mobileFilter()
  showModal()
  hideModal()
  init()
};

// Use turbo:load for both initial and subsequent loads
document.addEventListener('turbo:load', initializeScripts);
// document.addEventListener('turbo:render', initializeScripts);