import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery-card"
export default class extends Controller {
  static targets = ["card"]

  click () {
    this.cardTarget.classList.toggle('is-flipped');
  }
}
