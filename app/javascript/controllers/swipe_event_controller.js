import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="swipe-event"
export default class extends Controller {
  static values = {
    eventid: String,
  };

  connect() {
    console.log("hello from swipe controller");
  }

  start(event) {
    this.startY = event.touches[0].clientY;
  }

  end(event) {
    const endY = event.changedTouches[0].clientY;
    const distance = this.startY - endY;
    const eventElement = event.target.closest(".vault-event");

    // checks distance between touch start and end points, detects a swipe if more than 50 px
    if (distance > 50) {
      this.deleteEvent(this.eventidValue, eventElement);
    }
  }

  async deleteEvent(eventId, eventElement) {
    const url = `/events/${eventId}`;
    await fetch(url, {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
    });
    eventElement.remove();
  }
}
