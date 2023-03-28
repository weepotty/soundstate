import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lightmode"
export default class extends Controller {
  connect() {
    console.log("connected to lightmode controller");
  }

  lightMode() {
    this.element.classList.toggle("light-mode")
  }
}
