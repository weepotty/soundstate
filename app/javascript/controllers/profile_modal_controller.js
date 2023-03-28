import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-modal"
export default class extends Controller {
  static targets = ["modal", "overlay", "share"]

  open() {
    setTimeout((event) => {
      this.modalTarget.classList.remove("hidden")
    }, 500);
    console.log(this.event);
  }

  close() {
    setTimeout(() => {
      this.modalTarget.classList.add("hidden")
    }, 500);
  }
}
