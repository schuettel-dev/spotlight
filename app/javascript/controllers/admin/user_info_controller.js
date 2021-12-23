import { Controller } from "@hotwired/stimulus";
import { show, hide, showAll, hideAll } from "../../helpers/togglers.js";
import { userFormOpened, toggleUserForm } from "../../storages/opened_user_forms_storage.js"

export default class extends Controller {
  static targets = ['jsOnly', 'openFormIcon', 'closeFormIcon'];
  static values = { userId: Number };

  connect() {
    showAll(this.jsOnlyTargets);
    this.render();
  }

  render() {
    if (userFormOpened(this.userIdValue)) {
      hideAll(this.openFormIconTargets);
      showAll(this.closeFormIconTargets);
    } else {
      showAll(this.openFormIconTargets);
      hideAll(this.closeFormIconTargets);
    }
  }

  toggleUserForm() {
    toggleUserForm(this.userIdValue);
    this.render();
  }
}
