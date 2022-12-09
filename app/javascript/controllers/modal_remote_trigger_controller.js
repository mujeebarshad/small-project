import ModalTriggerController from "./modal_trigger_controller.js";

export default class extends ModalTriggerController {
  eventName = "modalContentLoaded";

  initialize() {
    this.onAjaxSend = this.onAjaxSend.bind(this);
    this.onAjaxError = this.onAjaxError.bind(this);
    this.onContentLoaded = this.onContentLoaded.bind(this);
    this.onHide = this.onHide.bind(this);
  }

  connect() {
    this.element.addEventListener("ajax:send", this.onAjaxSend);
    this.element.addEventListener("ajax:error", this.onAjaxError);

    if (this.data.get("showOnPageLoad")) {
      requestAnimationFrame(() => {
        requestAnimationFrame(() => {
          this.element.click();
        });
      });
    }
  }

  disconnect() {
    this.element.removeEventListener("ajax:send", this.onAjaxSend);
    this.element.removeEventListener("ajax:error", this.onAjaxError);
    PubSub.unsubscribe(this.eventName, this.onContentLoaded);
  }

  show() {
    PubSub.subscribe(this.eventName, this.onContentLoaded);
    this.modalController.show(this.onHide);
  }

  onHide() {
    if (this.xhr && this.xhr.readyState != 4) {
      this.xhr.abort();
    }
    this.xhr = undefined;

    this.resetContentClasses();
    this.modalController.contentTarget.classList.add("modal__content--loading");
    this.modalController.contentTarget.innerHTML = "";

    PubSub.unsubscribe(this.eventName, this.onContentLoaded);
    window.removeEventListener("resize", this.setModalSize);
  }

  onAjaxSend(event) {
    this.xhr = event.detail[0];
  }

  onAjaxError() {
    this.modalController.contentTarget.classList.remove(
      "modal__content--loading"
    );
    this.modalController.contentTarget.classList.add(
      "modal__content--error-message"
    );
    this.modalController.contentTarget.innerHTML =
      "<p>There were issues showing the content, " +
      "please try again or contact support." +
      '<button data-action="modal#hide">Close</button></p>';
  }

  onContentLoaded(_, data) {
    this.resetContentClasses();
    if ("contentClasses" in data) {
      this.modalController.contentTarget.classList.add(...data.contentClasses);
    }
    this.modalController.contentTarget.classList.remove(
      "modal__content--loading"
    );
    this.modalController.contentTarget.innerHTML = data.content;

    if (data.responsive) {
      this.modalController.responsiveFullscreen();
    }

    if (this.modalController.element.id != "profile_card") {
      this.modalController.setFirstInputFocus();
    }
  }

  // TODO; Save an empty copy of itself and replace with on hide
  //       to avoid issues more easily
  resetContentClasses() {
    this.modalController.contentTarget.classList.remove(
      "modal__content--small",
      "modal__content--medium",
      "modal__content--huge",
      "modal__content--borderless",
      "modal__content--scroll",
      "modal__content--padded",
      "modal__content--error-message",
      "modal__content--responsive"
    );
    this.modalController.element.style.height = "";
    this.modalController.contentTarget.style.height = "";
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
