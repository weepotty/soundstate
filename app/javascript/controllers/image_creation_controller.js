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
    "title",
    "regenerateButton",
  ];

  static values = {
    eventid: String,
  };

  connect() {}

  async showImage() {
    await this.generateImage();

    this.playlistTarget.classList.add("d-none");
    this.imageTarget.classList.remove("d-none");
    this.regenerateButtonTarget.classList.remove("d-none");
    this.generateImageButtonTarget.classList.add("d-none");
    this.createPlaylistButtonTarget.classList.remove("d-none");
  }

  generateImage() {
    this.imageTarget.innerHTML =
      "<div class='playlist-loader'></div><div>Generating AI Art...</div>";

    fetch(`/events/${this.eventidValue}/image`, {
      headers: {
        Accept: "text/plain",
      },
    })
      .then((res) => res.text())
      .then((url) => {
        this.imageTarget.innerHTML = `<img src="${url}" /><div style='cursor: pointer' class='d-flex justify-content-center py-4' data-image-creation-target='regenerateButton'><i class='fa-solid fa-arrows-rotate' data-action='click->image-creation#generateImage'></i></div>`;
        this.photoTarget.value = url;
      });
  }
}
