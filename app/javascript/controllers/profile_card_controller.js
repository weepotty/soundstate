import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-card"
export default class extends Controller {
  static targets = ["card"]

  connect () {
    console.log("connected");
  }

  click (e) {
    const all_cards = document.querySelectorAll('[data-profile-card-target="card"]')
    all_cards.forEach((c)=>c.classList.remove("is-flipped"))

    this.cardTarget.classList.add("is-flipped")
  }
}
