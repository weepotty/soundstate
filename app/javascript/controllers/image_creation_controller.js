import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-creation"
export default class extends Controller {
  static targets = ["playlist", "image"];

  connect() {
    console.log("connected");
    console.log(this.playlistTarget);
    console.log(this.imageTarget);
  }

  showImage() {
    this.playlistTarget.classList.add("d-none");
    this.imageTarget.classList.remove("d-none");
    this.generateImageButton.classList.add("d-none");
  }
}
