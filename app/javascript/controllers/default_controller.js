import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="default"
export default class extends Controller {
  static targets = ['eventOne', 'eventTwo','eventThree', 'form']
  connect() {
    console.log(this.eventOneTarget, this.eventTwoTarget, this.eventThreeTarget, this.formTarget);
  }

  // Getting Ready default
  renderFirstDefault(event) {
    event.preventDefault()

    fetch(this.eventOneTarget.href, {
      method: "GET",
      headers: {
        Accept: "application/json"
      }
    })
      .then(response => response.json())
      .then((data) => {
        this.formTarget.outerHTML = data.insert_edit_form
      })
  }

  // Acoustic default
  renderSecondDefault(event) {
    event.preventDefault()

    fetch(this.eventTwoTarget.href, {
      method: "GET",
      headers: {
        Accept: "application/json"
      }
    })
      .then(response => response.json())
      .then((data) => {
        this.formTarget.outerHTML = data.insert_edit_form
      })
  }

  // Sleep default
  renderThirdDefault(event) {
    event.preventDefault()

    fetch(this.eventThreeTarget.href, {
      method: "GET",
      headers: {
        Accept: "application/json"
      }
    })
      .then(response => response.json())
      .then((data) => {
        this.formTarget.outerHTML = data.insert_edit_form
      })
  }
}
