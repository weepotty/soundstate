// Import the Flickity library
import Flickity from "flickity";

// Wait for content load
window.addEventListener("load", function() {

// Initialise Flickity
var flkty = new Flickity(".carousel", {
  wrapAround: true,
  pageDots: false,
  prevNextButtons: false
});

// Due to the implementation of Flickity, a resize is required.
// This can be accomplished by manually resizing the browser viewport
// or do it here with JS see: https://github.com/metafizzy/flickity/issues/205
flkty.resize();
});