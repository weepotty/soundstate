window.onSpotifyIframeApiReady = (IFrameAPI) => {
  let element = document.getElementById("embed-iframe");
  let options = {
    width: "75%",
    height: "400px",
    uri: document.getElementById("first-song").getAttribute("value"),
  };
  let callback = (EmbedController) => {
    document
      .querySelectorAll("ul#episodes > li > button")
      .forEach((episode) => {
        episode.addEventListener("click", () => {
          EmbedController.loadUri(episode.dataset.spotifyId);
        });
      });
  };
  IFrameAPI.createController(element, options, callback);
};
