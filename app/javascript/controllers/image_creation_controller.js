import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-creation"
export default class extends Controller {
  static targets = [
    "playlist",
    "image",
    "generateImageButton",
    "createPlaylistButton",
  ];

  connect() {
    console.log("connected");
    console.log(this.playlistTarget);
    console.log(this.imageTarget);
    console.log(this.generateImageButtonTarget);
    console.log(this.createPlaylistButtonTarget);
  }

  showImage() {
    this.playlistTarget.classList.add("d-none");
    this.imageTarget.classList.remove("d-none");
    this.generateImageButtonTarget.classList.add("d-none");
    this.createPlaylistButtonTarget.classList.remove("d-none");
  }
}
