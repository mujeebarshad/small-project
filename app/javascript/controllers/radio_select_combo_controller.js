import { Controller } from "stimulus";
import { sendBrowserAgnosticEvent } from "../lib/events.js";

export default class extends Controller {
  static targets = ["radioButton", "select"];
  connect() {
    this.radioButtonTarget.addEventListener("change", this.handleChange);
    this.handleChange();
  }

  disconnect() {
    this.radioButtonTarget.removeEventListener("change", this.handleChange);
  }

  handleChange = () => {
    if (this.radioButtonTarget.checked) {
      if (this.hasSelectTarget) {
        this.selectTarget.disabled = false;
      }

      document
        .querySelectorAll(
          '[name="' + this.radioButtonTarget.getAttribute("name") + '"]'
        )
        .forEach(elem => {
          if (elem != this.radioButtonTarget) {
            sendBrowserAgnosticEvent(elem, "change");
          }
        });
      if (this.hasSelectTarget) {
        sendBrowserAgnosticEvent(this.selectTarget, "change");
      }
    } else {
      if (this.hasSelectTarget) {
        this.selectTarget.value = null;
        this.selectTarget.disabled = true;
      }
    }
  };
}
