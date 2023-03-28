import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-modal"
export default class extends Controller {
  static targets = ["modal", "overlay", "share"]

  open() {
    setTimeout(() => {
      this.modalTarget.classList.remove("hidden")
    }, 500);
  }

  close() {
    setTimeout(() => {
      this.modalTarget.classList.add("hidden")
    }, 500);
  }
}
