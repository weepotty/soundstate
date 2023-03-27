import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share-button"
export default class extends Controller {
  static targets = ["share"]
  static values = {
    faris: String,
    shared: Boolean
   }

  connect() {
    console.log("Button controller connected");
  }

  share() {
    const url = `/playlists/toggle_shared`
    console.log(url);
    const lock = "<p class='m-0' style='$light-gray'>Playlist Hidden</p>"
    const unlock = "<p class='m-0' style='$light-gray'>Playlist Shared</p>"

    fetch(url, {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          playlist_id: this.farisValue
        })
    })
      .then(res => res.json())
      .then((data) => {
        if (data.playlist == true) {
          this.shareTarget.outerHTML = unlock
        }
        else {
          this.shareTarget.outerHTML = lock
        }
      })
  }
}
