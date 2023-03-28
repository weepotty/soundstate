import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-picture-upload"
export default class extends Controller {
  static targets = ["profilePicture", "fileInput"];
  
  connect() {
  }

  uploadPicture(event) {
    console.log(this.fileInputTarget)
    this.fileInputTarget.click()
  }

  changePicture(event) {
    this.profilePictureTarget.src = URL.createObjectURL(event.target.files[0]);
  }
}
