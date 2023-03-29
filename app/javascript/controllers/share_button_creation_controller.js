import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share-button-creation"
export default class extends Controller {
  connect() {
    console.log("Share button connected");
  }
}
