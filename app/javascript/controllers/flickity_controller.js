import { Controller } from "@hotwired/stimulus"
// Import the Flickity library
import Flickity from "flickity";

// Connects to data-controller="flickity"
export default class extends Controller {
  connect() {
    // Initialise Flickity
    var flkty = new Flickity(this.element, {
      "wrapAround": true,
      "pageDots": false,
      "prevNextButtons": false
    });

    // Due to the implementation of Flickity, a resize is required.
    // This can be accomplished by manually resizing the browser viewport
    // or do it here with JS see: https://github.com/metafizzy/flickity/issues/205
    flkty.resize();
  }
}
