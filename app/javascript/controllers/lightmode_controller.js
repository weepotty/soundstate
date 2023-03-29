import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="lightmode"
export default class extends Controller {
  static targets = ["toggle"];
  connect() {
    if (localStorage.getItem("light-mode") === "true") {
      this.element.classList.add("light-mode");
      this.toggleTarget.checked = true;
    } else {
      this.toggleTarget.checked = false;
      this.element.classList.remove("light-mode");
    }
    // localStorage.clear()
  }

  lightMode() {
    if (this.toggleTarget.checked === true) {
      this.element.classList.add("light-mode");
      localStorage.setItem("light-mode", this.toggleTarget.checked);
    } else {
      this.element.classList.remove("light-mode");
      localStorage.setItem("light-mode", false);
    }
  }
}
