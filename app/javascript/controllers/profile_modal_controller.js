import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-modal"
export default class extends Controller {
  static targets = ["modal", "overlay"]

  connect() {
    console.log("Connected");
  }

  open() {
    console.log("Open modal");
    this.modalTarget.classList.remove("hidden")
    this.overlayTarget.classList.remove("hidden")
  }

  close() {
    console.log("Close modal");
    this.modalTarget.classList.add("hidden")
    this.overlayTarget.classList.add("hidden")
  }
}
