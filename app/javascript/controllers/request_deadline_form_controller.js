import { Controller } from "@hotwired/stimulus"
import { hideAll, showAll } from "../helpers/togglers.js";

export default class extends Controller {
  static targets = ["jsOnly", "noJs", "formElement", "jsAction"];
  static values = {
    showForm: Boolean
  }

  connect() {
    this.renderForm();
  }

  submitForm(event) {
    event.target.closest('form').requestSubmit();
  }

  submitFormIfClosed(event) {
    if(!this.showFormValue) {
      this.submitForm(event);
    }
  }

  renderForm() {
    this.showFormValue ?
      this.displayFormElements() :
      this.hideFormElements();
  }

  showForm() {
    this.showFormValue = true;
    this.renderForm();
  }

  hideForm() {
    this.showFormValue = false;
    this.renderForm();
  }

  displayFormElements() {
    showAll(this.formElementTargets);
    hideAll(this.jsActionTargets);
  }

  hideFormElements() {
    hideAll(this.formElementTargets);
    showAll(this.jsActionTargets);
  }
}
