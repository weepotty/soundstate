import { Controller } from "@hotwired/stimulus"
import { Tooltip } from "bootstrap/dist/js/bootstrap.bundle.js";

// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
    new Tooltip(this.element);
  }
}
