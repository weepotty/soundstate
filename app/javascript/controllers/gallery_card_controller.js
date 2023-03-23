import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery-card"
export default class extends Controller {
  static targets = ["card"]

  click (e) {
    const all_cards = document.querySelectorAll('[data-gallery-card-target="card"]')
    all_cards.forEach((c)=>c.classList.remove("is-flipped"))

    this.cardTarget.classList.add("is-flipped")
  }
}
