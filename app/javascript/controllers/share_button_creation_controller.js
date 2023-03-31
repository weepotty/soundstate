import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share-button-creation"
export default class extends Controller {
  static targets = ["share"]
  static values = {
    id: String,
    shared: Boolean
  }

  share() {
    const url = `/playlists/toggle_shared`
    const lock = "<p class='m-0' style='$light-gray'><i class='red-lock fa-solid fa-lock' style='padding-top: 0.2em;'></i> Playlist Hidden</p>";
    const unlock = "<p class='m-0' style='$light-gray'><i class='green-lock fa-solid fa-lock-open' style='padding-top: 0.2em;'></i> Playlist Shared</p>"

    fetch(url, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        playlist_id: this.idValue
      })
  })
    .then(res => res.json())
    .then((data) => {
      if (data.playlist) {
        this.shareTarget.outerHTML = unlock;
      } else {
        this.shareTarget.outerHTML = lock;
      }
      if (window.location.href.includes("playlist")) {
        this.thumbnailTarget.remove();
      }
  })
}
}
