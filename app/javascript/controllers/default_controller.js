import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="default"
export default class extends Controller {
  static targets = ['events', 'form']
  connect() {
    console.log(this.eventsTarget, this.formTarget);
  }

  renderDefault(event) {
    event.preventDefault()

    // console.log(this.formTarget)
    fetch(this.eventsTarget.href, {
      method: "GET",
      headers: {
        Accept: "application/json"
      }
    })
      .then(response => response.text())
      .then((data) => {
        this.formTarget.outerHTML = data
      })
  }
}
