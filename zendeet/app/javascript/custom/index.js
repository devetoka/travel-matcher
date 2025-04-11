
// Ensure scripts run on both initial load and Turbo navigation
import {initNavbar} from "./navbar";
import {initFormSubmission} from "./form";
import {initPostDateToggler, mobileFilter, postCustomDateFilter, imagePreview, togglePostImageUpload} from "./posts";
import {initFileUploadCheck} from "./file";
import {showModal, hideModal, init, showImageModal, hideImageModal,} from "./request";

window.showModal = showModal;
window.showImageModal = showImageModal;
window.hideModal = hideModal;
window.hideImageModal = hideImageModal;
window.togglePostImageUpload = togglePostImageUpload;

const initializeScripts = () => {
  initNavbar();
  initFileUploadCheck();
  initPostDateToggler();
  initFormSubmission();
  postCustomDateFilter();
  mobileFilter();
  showModal();
  hideModal();
  init();
  imagePreview();
  showImageModal()
  hideImageModal()

};

// Use turbo:load for both initial and subsequent loads
document.addEventListener('turbo:load', initializeScripts);
// document.addEventListener('turbo:render', initializeScripts);