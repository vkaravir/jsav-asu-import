(function($) {
  // add importAsu as an extension to instances of JSAV
  // parameter asuSrc can be a selector (for jQuery) or
  // a url to a file where the AnimalScript source will
  // be loaded
  JSAV.ext.importAsu = function(asuSrc) {
    var asuSrcElem = $(asuSrc),
        that = this;
    if (asuSrcElem.size() > 0) { // if we found an element with the asuSrc
      AsuImport(asuSrcElem.html(), this);
      this.recorded();
    } else { // if no element was found, try to load from the url
      $.get(asuSrc, function(data, status, response) {
        var inputLines = response.responseText.split("\n"),
            allLines = [];
        for (var i = 0, l = inputLines.length; i < l; i++) {
          allLines.push(inputLines[i].trim());
          // todo: check for file embeds
        }
        AsuImport(allLines.join("\n"), that);
        that.recorded();
      });
    }
  };

// begin wrapper for the generated Asu parser, will be closed in jsav-asu-import-footer.js
var AsuImport = function(src, jsav) {