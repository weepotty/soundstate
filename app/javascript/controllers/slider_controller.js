import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["sliderWrapper", "rangeBar", "minInput", "maxInput", "timeLabel"]

  connect() {
  }

  slide(event) {
    let rangeMin = 0.1;
    const index = this.sliderWrapperTargets.findIndex(element => element.id === event.target.id.substring(10));
    const range = this.rangeBarTargets[index];
    const rangeMinInput = this.minInputTargets[index];
    const rangeMaxInput = this.maxInputTargets[index];

    let minRange = parseFloat(rangeMinInput.value);
    let maxRange = parseFloat(rangeMaxInput.value);
    if (maxRange - minRange < rangeMin) {
      if (event.target.className === "min") {
        rangeMinInput.value = maxRange - rangeMin;
      } else {
        rangeMaxInput.value = minRange + rangeMin;
      }
    } else {
      range.style.left = (minRange / rangeMinInput.max) * 100 + "%";
      range.style.right = 100 - (maxRange / rangeMaxInput.max) * 100 + "%";
    }
  }

  displayLabel(event) {
    this.timeLabelTargets.forEach(element => element.classList.add("invisible"));
    this.timeLabelTargets[event.target.value].classList.remove("invisible");
  }
}
