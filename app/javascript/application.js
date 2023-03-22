// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "bootstrap";

// require our custom JS. The Flickity library will be loaded
// from there.
// Webpack will automatically load an `index.js' file from the given
// directory: 'app/javascript/carousel/index.js'
import "./carousel";
import "./webplayer";
