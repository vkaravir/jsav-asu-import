AsuHelpers = {};
AsuHelpers.handledCommand = function(parser, jsav) {
  if (!parser._insideStep) {
    jsav.step();
  }
};
AsuHelpers.anchors = { "NW": "left top", "N": "center top", "NE": "right top",
    "W": "left center", "C": "center center", "E": "right center",
    "SW": "left bottom", "S": "center bottom", "SE": "right bottom",
    "Northwest": "left top", "North": "center top", "Northeast": "right top",
    "West": "left center", "Middle": "center center", "Center": "center center",
    "East": "right center", "Southwest": "left bottom",
    "South": "center bottom", "Southeast": "right bottom" };
AsuHelpers.directionToAnchor = function(dir) {
  return AsuHelpers.anchors[dir];
};
AsuHelpers.dirFactors = { "NW": [0, 0], "N": [0.5, 0], "NE": [1, 0],
    "W": [0, 0.5], "C": [0.5, 0.5], "E": [1, 0.5],
    "SW": [0, 1], "S": [0.5, 1], "SE": [1, 1],
    "Northwest": [0, 0], "North": [0.5, 0], "Northeast": [1, 0],
    "West": [0, 0.5], "Middle": [0.5, 0.5], "Center": [0.5, 0.5],
    "East": [1, 0.5], "Southwest": [0, 1],
    "South": [0.5, 1], "Southeast": [1, 1] };
AsuHelpers.applyDirection = function(dir, offset, bounds) {
  var factors = AsuHelpers.dirFactors[dir];
  return {left: bounds.left + offset.left + bounds.width*factors[0],
          top: bounds.top + offset.top + bounds.height*factors[1]};
};
AsuHelpers.depthToCss = function(depth, selector) {
  if (!depth) { return ""; }
  // behind modal dialogs, on top of other stuff
  var MAGIC_NUMBER = 800;
  return selector + "{z-index:" + (MAGIC_NUMBER - depth) + ";}";
};
AsuHelpers._colorCodes = {"black":"0,0,0", "blue": "0,0,255",
                          "blue2":"0,0,208", "blue3": "0, 0, 176",
                          "blue4":"0, 0, 144", "brown2": "192, 96, 0",
                          "brown3":"160, 64, 0", "brown4":"128, 48, 0",
                          "cyan":"0, 255, 255", "cyan2":"0, 208, 208",
                          "cyan3":"0, 176, 176", "cyan4":"0, 144, 144",
                          "dark Gray":"64, 64, 64", "gold":"255, 215, 0",
                          "gray":"128, 128, 128", "green":"0, 255, 0",
                          "green2":"0, 208, 0", "green3":"0, 176, 0",
                          "green4":"0, 144, 0", "light Gray":"192, 192, 192",
                          "light blue":"135, 206, 255", "magenta":"255, 0, 255",
                          "magenta2":"208, 0, 208", "magenta3":"176, 0, 176",
                          "magenta4":"144, 0, 144", "orange":"255, 200, 0",
                          "pink":"255, 175, 175", "pink2":"255, 192, 192",
                          "pink3":"255, 160, 160", "pink4":"255, 128, 128",
                          "red":"255, 0, 0", "red2":"208, 0, 0",
                          "red3":"176, 0, 0", "red4":"144, 0, 0",
                          "white":"255, 255, 255", "yellow":"255, 255, 0"};
AsuHelpers.colorNameToRGB = function(colorName) {
  return AsuHelpers._colorCodes[colorName];
};
