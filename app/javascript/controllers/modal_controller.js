import { Controller } from "stimulus";
import { sendBrowserAgnosticEvent } from "../lib/events.js";
import { responsiveBreakpoints } from "../lib/browser_helpers";
import ScrollLock from "../lib/scroll-lock.js";

export default class extends Controller {
  static targets = ["content", "autoFocus"];

  show(onHide) {
    this.onHide = onHide;
    this.element.classList.add("modal--display");
    document.addEventListener("keydown", this.handleKeydown.bind(this));
    sendBrowserAgnosticEvent(document, "modalOpened");
    ScrollLock.enable();
  }

  hide() {
    if (this.onHide) {
      this.onHide();
      this.onHide = undefined;
    }
    this.element.classList.remove("modal--display");
    document.removeEventListener("keydown", this.handleKeydown.bind(this));
    if (this.mediaQueryList) {
      this.mediaQueryList.removeEventListener("change", this.setModalSize);
      this.mediaQueryList = null;
    }
    ScrollLock.disable();
  }

  handleClick(event) {
    if (event.target === this.element && this.dismissable) {
      this.hide();
    }
  }

  handleKeydown(event) {
    if (event.keyCode == 27 && this.dismissable) {
      this.hide();
    }
  }

  responsiveFullscreen = () => {
    this.mediaQueryList = window.matchMedia(
      `max-width: ${responsiveBreakpoints.sm})`
    );
    this.contentTarget.classList.add("modal__content--responsive");
    this.mediaQueryList.addEventListener("change", this.setModalSize);
  };

  setModalSize = () => {
    if (this.mediaQueryList.matches) {
      this.element.style.height = `${window.innerHeight}px`;
      this.contentTarget.style.height = `${window.innerHeight}px`;
    } else {
      this.element.style.height = "";
      this.contentTarget.style.height = "";
    }
  };

  setFirstInputFocus() {
    var inputs = [];
    if (this.hasAutoFocusTarget) {
      inputs[0] = this.autoFocusTarget;
    } else {
      inputs = this.contentTarget.querySelectorAll(
        'input[type="text"], input[type="email"], input[type="password"]'
      );
    }
    if (inputs.length > 0) {
      if (inputs[0].value) {
        inputs[0].setSelectionRange(0, inputs[0].value.length);
      }
      inputs[0].focus();
    }
  }

  get dismissable() {
    return (
      !this.data.has("dismissable") || this.data.get("dismissable") == "true"
    );
  }
}
