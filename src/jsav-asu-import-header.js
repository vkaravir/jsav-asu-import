(function($) {
  var initAsu = function(asuSrc) {
  };
  JSAV.ext.importAsu = function(asuSrc) {
    var asuSrcElem = $(asuSrc),
        that = this;
    if (asuSrcElem.size() > 0) {
      AsuImport(asuSrcElem.html(), this);
      this.recorded();
    } else {
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

var AsuImport = function(src, jsav) {