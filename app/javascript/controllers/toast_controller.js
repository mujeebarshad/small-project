import { Controller } from "stimulus";

export default class extends Controller {
  animationClass = "c-banner__content--show";
  static targets = ["content"];

  connect() {
    this.hideTimer = setTimeout(this.hide, 5000);
    this.element.addEventListener("mouseover", this.skipTimer);
    this.contentTarget.classList.add(this.animationClass);
  }

  disconnect() {
    this.skipTimer();
  }

  skipTimer = () => {
    clearTimeout(this.hideTimer);
    this.element.removeEventListener("mouseover", this.skipTimer);
  };

  hide = () => {
    this.element.remove();
  };
}
