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
      .then(data => console.log(data))
  }
}
