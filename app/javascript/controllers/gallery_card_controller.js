import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="gallery-card"
export default class extends Controller {
  static targets = ["card", "modal", "playlistLink", "playlistIframe"];

  connect() {}

  open(event) {
    const playlistSpotifyId = event.currentTarget.dataset.playlistSpotifyId;
    this.playlistIframeTarget.src = `https://open.spotify.com/embed/playlist/${playlistSpotifyId}?utm_source=generator&theme=0`;
    this.playlistLinkTarget.href = `https://open.spotify.com/playlist/${playlistSpotifyId}`;

    event.currentTarget.classList.add("is-flipped");

    document.body.style.overflow = "hidden";
    setTimeout((event) => {
      this.modalTarget.classList.remove("invisible");
    }, 1000);
  }

  close() {
    document.body.style.overflow = "unset";

    this.modalTarget.classList.add("invisible");
    this.cardTargets.forEach((c) => c.classList.remove("is-flipped"));
  }
}
