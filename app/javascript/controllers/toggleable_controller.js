import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['body', 'togglers', 'opener', 'closer']

  static values = { opened: Boolean }

  connect() {
    this.init();
  }

  init() {
    this.togglersTarget.classList.remove('hidden');
    this.render();
  }

  render() {
    this.bodyTarget.classList.toggle('hidden', !this.openedValue);
    this.openerTarget.classList.toggle('hidden', this.openedValue);
    this.closerTarget.classList.toggle('hidden', !this.openedValue);
  }

  toggle() {
    this.openedValue = !this.openedValue;
    this.render();
  }
}
