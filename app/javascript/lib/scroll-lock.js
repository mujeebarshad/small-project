// Created based on:
// * https://markus.oberlehner.net/blog/simple-solution-to-prevent-body-scrolling-on-ios/
// * https://www.npmjs.com/package/body-scroll-lock
//

export default class ScrollLock {
  static lockScrollingClass = "u-lock-scrolling";
  static isIosDevice =
    typeof window !== "undefined" &&
    window.navigator &&
    window.navigator.platform &&
    (/iP(ad|hone|od)/.test(window.navigator.platform) ||
      (window.navigator.platform === "MacIntel" &&
        window.navigator.maxTouchPoints > 1));
  static scrollPosition = 0;

  static enable() {
    let body = document.querySelector("body");
    if (this.isIosDevice) {
      this.scrollPosition = window.pageYOffset;
      body.style.overflow = "hidden";
      body.style.position = "fixed";
      body.style.top = `-${this.scrollPosition}px`;
      body.style.width = "100%";
    } else {
      body.classList.add(this.lockScrollingClass);
    }
  }
  static disable() {
    let body = document.querySelector("body");
    if (this.isIosDevice) {
      body.style.removeProperty("overflow");
      body.style.removeProperty("position");
      body.style.removeProperty("top");
      body.style.removeProperty("width");
      window.scrollTo(0, this.scrollPosition);
    } else {
      body.classList.remove(this.lockScrollingClass);
    }
  }
}
