import { Controller } from "@hotwired/stimulus"
import { show, hide, showAll, hideAll } from "../../helpers/togglers.js";
import { requestDeadlineFormOpened, toggleRequestDeadlineForm } from "../../storages/opened_request_deadline_forms_storage.js";

export default class extends Controller {
  static targets = ['form', 'openFormIcon', 'closeFormIcon'];
  static values = { requestDeadlineId: Number };

  connect() {
    this.render();
  }

  render() {
    if (requestDeadlineFormOpened(this.requestDeadlineIdValue)) {
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

  toggleRequestDeadlineForm() {
    toggleRequestDeadlineForm(this.requestDeadlineIdValue);
    this.render();
  }
}
