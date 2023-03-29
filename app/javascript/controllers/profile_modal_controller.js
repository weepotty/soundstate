import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="profile-modal"
export default class extends Controller {
  static targets = [
    "modal",
    "overlay",
    "share",
    "card",
    "imagePreview",
    "iframe",
    "secretBox",
  ];
  static values = {
    image: String,
  };

  connect() {}
  open() {
    setTimeout((event) => {
      this.modalTarget.classList.remove("hidden");
    }, 500);
  }

  close() {
    // setTimeout(() => {
    //   this.modalTarget.classList.add("hidden");
    // }, 500);

    this.modalTarget.classList.add("hidden");
    this.cardTargets.forEach((c) => c.classList.remove("is-flipped"));
    this.closeImage();
  }

  showBigImage() {
    this.imagePreviewTarget.innerHTML = `<img src="${this.imageValue}">`;
    this.iframeTarget.classList.add("darken");
    this.iframeTarget.classList.add("pe-none");
  }

  closeImage(event) {
    console.log("click registered");
    if (event.target !== this.secretBoxTarget) {
      this.imagePreviewTarget.innerHTML = "";
      this.iframeTarget.classList.remove("darken");
      this.iframeTarget.classList.remove("pe-none");
    }
  }
}
