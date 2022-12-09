import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["menu"];

  // Make sure document click events are always removed.
  disconnect() {
    document.removeEventListener("click", this.handleBackroundClick);
    document.removeEventListener("modalOpened", this.handleBackroundClick);
  }

  handleBackroundClick = e => {
    if (!(e.target == this.menuTarget || this.menuTarget.contains(e.target))) {
      this.hideDrop();
    }
  };

  toggle() {
    this.menuTarget.classList.contains("c-context-menu--open")
      ? this.hideDrop()
      : this.showDrop();
  }

  showDrop() {
    this.menuTarget.classList.add("c-context-menu--open");
    document.addEventListener("click", this.handleBackroundClick);
    document.addEventListener("modalOpened", this.handleBackroundClick);
  }

  hideDrop() {
    this.menuTarget.classList.remove("c-context-menu--open");
    document.removeEventListener("click", this.handleBackroundClick);
    document.removeEventListener("modalOpened", this.handleBackroundClick);
  }
}
