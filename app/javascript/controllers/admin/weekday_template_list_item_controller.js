import { Controller } from "@hotwired/stimulus"
import { show, hide, showAll, hideAll } from "../../helpers/togglers.js";
import { listsStorage } from "../../storages/lists_storage.js";

export default class extends Controller {
  static targets = ['form', 'openFormIcon', 'closeFormIcon'];
  static values = { requestDeadlineId: Number };

  connect() {
    this.openedFormsList = listsStorage('openedWeekdayTemplateForms');
    this.render();
  }

  render() {
    if (this.openedFormsList.has(this.requestDeadlineIdValue)) {
      showAll(this.formTargets);
      hideAll(this.openFormIconTargets);
      showAll(this.closeFormIconTargets);
    } else {
      hideAll(this.formTargets);
      showAll(this.openFormIconTargets);
      hideAll(this.closeFormIconTargets);
    }
  }

  submitForm(event) {
    event.target.closest('form').requestSubmit();
  }

  toggleWeekdayTemplateForm() {
    this.openedFormsList.toggle(this.requestDeadlineIdValue)
    this.render();
  }
}
