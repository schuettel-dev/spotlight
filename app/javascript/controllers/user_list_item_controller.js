import { Controller } from "@hotwired/stimulus";
import { show, hide, showAll } from "../helpers/togglers.js";
import { userFormOpened } from "../storages/opened_user_forms_storage.js";

export default class extends Controller {
  static targets = ['form'];
  static values = { userId: Number };

  connect() {
    this.render();
  }

  render() {
    if (userFormOpened(this.userIdValue)) {
      show(this.formTarget);
    } else {
      hide(this.formTarget);
    }
  }
}
