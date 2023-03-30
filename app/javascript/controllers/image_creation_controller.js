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

  connect() {
    // function to reload page to make webplayer SDK show up
    let currentDocumentTimestamp = new Date(
      performance.timing.domLoading
    ).getTime();
    // current time
    let now = Date.now();
    let oneSec = 1 * 1000;
    // reload if >1s since last load
    let plusOneSec = currentDocumentTimestamp + oneSec;
    if (now > plusOneSec) {
      location.reload();
    }
  }

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
        "<div class='playlist-loader'></div><div class='playlist-loader-text'>Generating AI Art...</div>";

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
