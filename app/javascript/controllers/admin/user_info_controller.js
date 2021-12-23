import { Controller } from "@hotwired/stimulus";
import { show, hide, showAll, hideAll } from "../../helpers/togglers.js";
import { listsStorage } from "../../storages/lists_storage.js";

export default class extends Controller {
  static targets = ['jsOnly', 'openFormIcon', 'closeFormIcon'];
  static values = { userId: Number };

  connect() {
    this.openedFormsList = listsStorage('openedUserForms')
    showAll(this.jsOnlyTargets);
    this.render();
  }

  render() {
    if (this.openedFormsList.has(this.userIdValue)) {
      hideAll(this.openFormIconTargets);
      showAll(this.closeFormIconTargets);
    } else {
      showAll(this.openFormIconTargets);
      hideAll(this.closeFormIconTargets);
    }
  }

  toggleUserForm() {
    this.openedFormsList.toggle(this.userIdValue);
    this.notifyToggled();
    this.render();
  }

  notifyToggled() {
    window.dispatchEvent(
      new CustomEvent(
        'admin--user-form-toggled',
        {
          detail: {
            userId: this.userIdValue
          }
        }
      )
    );
  }
}
