import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="share-button"
export default class extends Controller {
  static targets = ["share", "thumbnail"];
  static values = {
    id: String,
    shared: Boolean,
  };

  connect() {}

  share() {
    const url = `/playlists/toggle_shared`;
    const lock = "<p class='m-0' style='$light-gray'>Playlist Hidden</p>";
    const unlock = "<p class='m-0' style='$light-gray'>Playlist Shared</p>";

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
          this.shareTarget.outerHTML = unlock;
        } else {
          this.shareTarget.outerHTML = lock;
        }
        this.thumbnailTarget.remove();
      });
  }
}
