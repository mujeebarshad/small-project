import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    if (this.data.get("showOnPageLoad")) {
      this.show();
    }
  }

  show(e) {
    if (e) {
      e.preventDefault();
    }
    this.modalController.show();
  }

  get modalController() {
    return this.application.getControllerForElementAndIdentifier(
      document.getElementById(this.id),
      "modal"
    );
  }

  get id() {
    return this.data.get("id");
  }
}
