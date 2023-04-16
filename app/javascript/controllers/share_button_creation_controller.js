import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="share-button-creation"
export default class extends Controller {
  static targets = ["share", "lock", "action"];
  static values = {
    id: String,
    shared: Boolean,
  };

  share() {
    const url = `/playlists/toggle_shared`;
    const lockShare =
      "<i data-share-button-creation-target='lock' class='green-lock fa-solid fa-lock-open' style='padding-top: 0.2em;'></i>";
    const lockHide =
      "<i data-share-button-creation-target='lock' class='red-lock fa-solid fa-lock' style='padding-top: 0.2em;'></i>";
    const actionHide =
      "<p data-share-button-creation-target='action'> Hidden in Vault</p>";
    const actionShare =
      "<p data-share-button-creation-target='action'> Shared to Gallery</p>";

    fetch(url, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        playlist_id: this.idValue,
      }),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.playlist) {
          this.lockTarget.outerHTML = lockShare;
          this.actionTarget.outerHTML = actionShare;
        } else {
          this.lockTarget.outerHTML = lockHide;
          this.actionTarget.outerHTML = actionHide;
        }
        if (window.location.href.includes("playlist")) {
          this.thumbnailTarget.remove();
        }
      });
  }
}
