let rangeMin = 0.01;
const range = document.querySelector(".range-selected");
const rangeInput = document.querySelectorAll(".range-input input");

rangeInput.forEach((input) => {
  input.addEventListener("input", (e) => {
    let minRange = parseFloat(rangeInput[0].value);
    let maxRange = parseFloat(rangeInput[1].value);
    if (maxRange - minRange < rangeMin) {
      if (e.target.className === "min") {
        rangeInput[0].value = maxRange - rangeMin;
      } else {
        rangeInput[1].value = minRange + rangeMin;
      }
    } else {
      range.style.left = (minRange / rangeInput[0].max) * 100 + "%";
      range.style.right = 100 - (maxRange / rangeInput[1].max) * 100 + "%";
    }
  });
});
