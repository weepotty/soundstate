import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery-card"
export default class extends Controller {
  static targets = ["card", "iframeCard"]

  click (e) {
    const all_cards = document.querySelectorAll('[data-gallery-card-target="card"]')
    all_cards.forEach((c)=>c.classList.remove("is-flipped"))
    const iframeCards = document.querySelectorAll('[data-gallery-card-target="iframeCard"]')
    iframeCards.forEach((iframe)=>iframe.classList.add("d-none"))

    this.cardTarget.classList.add("is-flipped")
    this.iframeCardTarget.classList.remove("d-none")
  }
}
