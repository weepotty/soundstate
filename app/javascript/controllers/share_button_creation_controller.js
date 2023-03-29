import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share-button-creation"
export default class extends Controller {
  static targets = ["share"]

  share() {
    const url = `/playlists/toggle_shared`
    const unlock = "<p class='m-0' style='$light-gray'>Playlist Shared</p>"


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
