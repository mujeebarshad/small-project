// Copied from: https://stackoverflow.com/a/49071358/79677
export function sendBrowserAgnosticEvent(elem, eventName, bubbles = false) {
  let event;
  if (typeof Event === "function") {
    event = new Event(eventName, { bubbles: bubbles });
  } else {
    event = document.createEvent("Event");
    event.initEvent(eventName, bubbles, true);
  }
  elem.dispatchEvent(event);

  return event;
}
