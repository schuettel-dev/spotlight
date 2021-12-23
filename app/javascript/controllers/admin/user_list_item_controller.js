import { Controller } from "@hotwired/stimulus";
import { show, hide, showAll } from "../../helpers/togglers.js";
import { listsStorage } from "../../storages/lists_storage.js";

export default class extends Controller {
  static targets = ['form'];
  static values = { userId: Number };

  connect() {
    this.openedFormsList = listsStorage('openedUserForms');
    this.render();
  }

  render() {
    if (this.openedFormsList.has(this.userIdValue)) {
      show(this.formTarget);
    } else {
      hide(this.formTarget);
    }
  }
}
