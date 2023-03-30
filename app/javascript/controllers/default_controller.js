import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="default"
export default class extends Controller {
  static targets = ['eventOne', 'eventTwo','eventThree', 'form', 'selectedDefault'];

  connect() {
  }

  // Getting Ready default
  renderFirstDefault(event) {
    event.preventDefault();
    if(event.target.classList.contains('is-selected')) {
      fetch('/events/new', {
        method: "GET",
        headers: {
          Accept: "application/json"
        }
      })
        .then(response => response.json())
        .then((data) => {
          this.formTarget.outerHTML = data.insert_new_form;
        })

      event.target.classList.remove('is-selected');
    } else {
      fetch(this.eventOneTarget.href, {
        method: "GET",
        headers: {
          Accept: "application/json"
        }
      })
        .then(response => response.json())
        .then((data) => {
          this.formTarget.outerHTML = data.insert_edit_form;
        })

      event.target.classList.add('is-selected');
    }

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
