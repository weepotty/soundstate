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
    "enlargedImage",
  ];
  static values = {
    image: String,
  };

  connect() {}
  open() {
    document.body.style.overflow = "hidden";
    setTimeout((event) => {
      this.modalTarget.classList.remove("hidden");
    }, 500);
  }

  close() {
    document.body.style.overflow = "unset";

    this.modalTarget.classList.add("hidden");
    this.cardTargets.forEach((c) => c.classList.remove("is-flipped"));
    this.closeImage();
  }

  showBigImage() {
    this.imagePreviewTarget.innerHTML = `<img src="${this.imageValue}" data-profile-modal-target="enlargedImage">`;
    this.iframeTarget.classList.add("darken");
    this.iframeTarget.classList.add("pe-none");
  }

  closeImage(event) {
    if (
      event.target !== this.secretBoxTarget &&
      event.target !== this.enlargedImageTarget
    ) {
      this.imagePreviewTarget.innerHTML = "";
      this.iframeTarget.classList.remove("darken");
      this.iframeTarget.classList.remove("pe-none");
    }
  }
}
