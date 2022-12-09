export function isIE() {
  var ua = window.navigator.userAgent;
  return ua.indexOf("MSIE ") > -1 || ua.indexOf("Trident/") > -1;
}

export function isFF() {
  var ua = window.navigator.userAgent;
  return ua.toLowerCase().indexOf("firefox") > -1;
}

// To be used in conjunction with `matchMedia`
export const responsiveBreakpoints = {
  xs: "0em",
  sm: "48em",
  md: "64em",
  lg: "75em"
};
