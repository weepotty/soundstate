import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-modal"
export default class extends Controller {
  static targets = ["modal", "overlay", "close", "open"]

  connect() {
    console.log("Connected");
  }
}
