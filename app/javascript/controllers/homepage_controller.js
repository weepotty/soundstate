import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="homepage"
export default class extends Controller {
  static targets = ['hidden']
  connect() {
    console.log('test');
    console.log(this.hiddenTargets);

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

    this.hiddenTargets.forEach((el) => observer.observe(el));
  }
}
