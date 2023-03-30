import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="default"
export default class extends Controller {
  static targets = ['defaultEvent', 'form', 'selectedDefault'];

  connect() {
  }

  // Getting Ready default
  renderDefault(event) {
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
      fetch(event.target.href, {
        method: "GET",
        headers: {
          Accept: "application/json"
        }
      })
        .then(response => response.json())
        .then((data) => {
          this.formTarget.outerHTML = data.insert_edit_form;
        })

      this.defaultEventTargets.forEach(element => element.classList.remove('is-selected'));
      event.target.classList.add('is-selected');
    }
  }
}
