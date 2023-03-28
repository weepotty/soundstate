import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-creation"
export default class extends Controller {
  connect() {
    console.log("connected");
  }
}
