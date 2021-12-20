import { Controller } from "@hotwired/stimulus";
import { show, hide, showAll } from "../helpers/togglers.js";

export default class extends Controller {
  static targets = ['form', 'jsOnly', 'openFormIcon', 'closeFormIcon'];
  static values = { userId: Number };

  connect() {
    showAll(this.jsOnlyTargets);
    this.renderForm();
  }

  render() {
    this.renderForm();
  }

  renderForm() {
    if (this.formOpened()) {
      show(this.formTarget);
      hide(this.openFormIconTarget);
      show(this.closeFormIconTarget);
    } else {
      hide(this.formTarget);
      show(this.openFormIconTarget);
      hide(this.closeFormIconTarget);
    }
  }

  get getOpenedUserForms() {
    return JSON.parse(window.localStorage.getItem('openedUserForms') || "[]");
  }

  addToOpenedUserForms() {
    if (!this.userIdIncludedInOpenedUserForms()) {
      const newOpenedUserForms = this.getOpenedUserForms;
      newOpenedUserForms.push(this.userIdValue)
      window.localStorage.setItem('openedUserForms', JSON.stringify(newOpenedUserForms))
    }
  }

  removeFromOpenedUserForms() {
    if (this.userIdIncludedInOpenedUserForms()) {
      const newOpenedUserForms = this.getOpenedUserForms.filter((userId) => userId != this.userIdValue);

      window.localStorage.setItem('openedUserForms', JSON.stringify(newOpenedUserForms));
    }
  }

  formOpened() {
    return this.userIdIncludedInOpenedUserForms();
  }

  userIdIncludedInOpenedUserForms() {
    return this.getOpenedUserForms.includes(this.userIdValue);
  }

  toggleForm() {
    if (this.formOpened()) {
      this.removeFromOpenedUserForms();
    } else {
      this.addToOpenedUserForms();
    }
    this.render();
  }
}
