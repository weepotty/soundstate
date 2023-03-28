import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-creation"
export default class extends Controller {
  static targets = [
    "playlist",
    "image",
    "imageWrapper",
    "generateImageButton",
    "createPlaylistButton",
    "photo",
    "regenerateButton",
  ];

  static values = {
    eventid: String,
  };

  connect() {}

  async showImage() {
    this.imageTarget.classList.remove("d-none");
    this.playlistTarget.classList.add("d-none");
    this.generateImageButtonTarget.classList.add("d-none");
    await this.generateImage();
    this.regenerateButtonTarget.classList.remove("d-none");
    this.createPlaylistButtonTarget.classList.remove("d-none");
  }

  generateImage() {
    return new Promise((resolve, reject) => {
      this.imageTarget.innerHTML =
        "<div class='playlist-loader'></div><div>Generating AI Art...</div>";

      fetch(`/events/${this.eventidValue}/image`, {
        headers: {
          Accept: "text/plain",
        },
      })
        .then((res) => res.text())
        .then((url) => {
          this.imageTarget.innerHTML = `<img src="${url}" />`;
          this.photoTarget.value = url;
          resolve();
        })
        .catch((error) => {
          reject(error);
        });
    });
  }
}
