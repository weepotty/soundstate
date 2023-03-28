import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="load-songs"
export default class extends Controller {
  connect() {
    window.location.replace(this.element.href);
  }
}
