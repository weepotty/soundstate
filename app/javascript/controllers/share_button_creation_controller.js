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
    const unlock = "<p class='m-0' style='color: $light-gray; padding-top: 1em; padding-left: 1em;'>Playlist Shared</p>"


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
      this.shareTarget.outerHTML = unlock
      console.log(this.shareTarget);
  })
}
}
