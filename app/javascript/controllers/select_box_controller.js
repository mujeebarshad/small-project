import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["valueDisplay"];
  classes = {
    focus: "c-select--has-focus",
    empty: "c-select--empty",
    disabled: "c-select--disabled"
  };
  focusEvents = ["click", "focus", "blur"];

  connect() {
    this.focusEvents.forEach(event => {
      this.selectTarget.addEventListener(event, this.handleFocus);
    });
    this.selectTarget.addEventListener("change", this.updateValue);
    if (this.selectTarget.disabled) {
      this.element.classList.add(this.classes.disabled);
    }
    this.updateValue();
  }

  disconnect() {
    this.focusEvents.forEach(event => {
      this.selectTarget.addEventListener(event, this.handleFocus);
    });
    this.selectTarget.removeEventListener("change", this.updateValue);
    document.removeEventListener("click", this.handleFocus);
  }

  handleFocus = () => {
    if (this.selectTarget == document.activeElement) {
      this.element.classList.add(this.classes.focus);
      document.addEventListener("click", this.handleFocus);
    } else {
      this.element.classList.remove(this.classes.focus);
      document.removeEventListener("click", this.handleFocus);
    }
  };

  updateValue = () => {
    if (this.selectTarget.value != "") {
      this.element.classList.remove(this.classes.empty);
    } else {
      this.element.classList.add(this.classes.empty);
    }
    this.valueDisplayTarget.innerText = this.selectTarget.options[
      this.selectedIndex
    ].text;
  };

  get selectTarget() {
    return this.element.querySelector("select");
  }

  get selectedIndex() {
    if (this.selectTarget.selectedIndex >= 0) {
      return this.selectTarget.selectedIndex;
    } else {
      return 0;
    }
  }
}
