window.onSpotifyIframeApiReady = (IFrameAPI) => {
  const element = document.getElementById("embed-iframe");
  const options = {
    width: "75%",
    height: "400px",
    uri: document.getElementById("first-song").getAttribute("value"),
  };
  const callback = (EmbedController) => {
    document
      .querySelectorAll(".episode")
      .forEach((episode) => {
        episode.addEventListener("click", () => {
          EmbedController.loadUri(episode.dataset.spotifyId);
        });
      });
  };
  IFrameAPI.createController(element, options, callback);
};
