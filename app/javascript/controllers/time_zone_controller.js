import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time-zone"
export default class extends Controller {
  static targets = ["dayPeriod"]

  connect() {
    const date = new Date();
    const hour = date.getHours();

    let period = "evening";
    if (hour >= 5 && hour < 12) {
    period = "morning";
    } else if (hour >= 12 && hour < 17) {
      period = "afternoon";
    }
    this.dayPeriodTarget.innerText = period;
  }
}
