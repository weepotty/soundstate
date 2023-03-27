import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="homepage"
export default class extends Controller {
  static targets = ['hide']
  connect() {
    console.log('test');
    console.log(this.hideTargets);

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        console.log(entry);
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
