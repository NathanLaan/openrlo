String.prototype.trim = function () {
  return this.replace(/^\s+|\s+$/g, "");
}
String.prototype.ltrim = function () {
  return this.replace(/^\s+/, "");
}
String.prototype.rtrim = function () {
  return this.replace(/\s+$/, "");
}

//
// Used to generate Title URLs.
//
// TEST STRING: <0> {1} [2] '3' "4" \5\ /6/ |7| 8+_=9.,?!@#$%^&* ?!?
// TEST RESULT: 0-1-2-3-4-5-6-7-8_9?!-?!?
//
String.prototype.cleanString = function () {
  return this.toLowerCase().trim().replace(/ /g, '-').replace(/['"\\\/\|\;\:\{\}\[\]\(\)\+\=\<\>\,\.\@\#\$\%\^\&\*]/g, '');
  //return this.toLowerCase().trim().replace(/ /g, '-');
}


function consoleDebug(msg, err) {
  window.console && console.log && console.log(msg);
  if (err) {
    window.console && console.log && console.log(err);
  }
}