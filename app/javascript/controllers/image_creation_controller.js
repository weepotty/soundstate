import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-creation"
export default class extends Controller {
  static targets = [
    "playlist",
    "image",
    "imageWrapper",
    "generateImageButton",
    "createPlaylistButton",
  ];

  static values = {
    eventid: String,
  };

  connect() {}

  async showImage() {
    await this.generateImage();

    this.playlistTarget.classList.add("d-none");
    this.imageWrapperTarget.classList.remove("d-none");
    this.generateImageButtonTarget.classList.add("d-none");
    this.createPlaylistButtonTarget.classList.remove("d-none");
  }

  generateImage() {
    this.imageWrapperTarget.innerHTML = "<div style='my-4'>Loading...</div>";

    fetch(`/events/${this.eventidValue}/image`, {
      headers: {
        Accept: "text/plain",
      },
    })
      .then((res) => res.text())
      .then((url) => {
        this.imageWrapperTarget.innerHTML = `<img src="${url}" />`;
      });
  }
}
