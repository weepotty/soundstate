import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="homepage"
export default class extends Controller {
  static targets = ['hide']
  connect() {

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('active');
        } else {
          entry.target.classList.remove('active');
        }
      })
    });

    this.hideTargets.forEach((el) => observer.observe(el));
  }
}
