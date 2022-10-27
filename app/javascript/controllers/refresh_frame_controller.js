import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    window.addEventListener('focus', this.refresh.bind(this))
  }

  refresh() {
    console.log('reloading')
    this.element.reload();
  }
}


