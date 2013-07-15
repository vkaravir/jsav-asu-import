%{
  // for testing purposes, make these globallly visible
  var asustyle = $("<style id='asuStyle'/>").appendTo($("body"));
  var asuobjs = {};
  asugroups = {};
  prevLoc = {};
%}
%lex
%s INITIAL COMMAND VARIABLE STEP
%%
/* header stuff */

"%Animal"             { return 'ANIMAL'; }
"title"               return 'title'
"author"              return 'author'

/* commands */
"embed"               return 'embed'

"array"               { this.begin("COMMAND"); return 'array';}
"field"               { this.begin("COMMAND"); return 'field';}
"vertical"            return 'vertical'
"horizontal"          return 'horizontal'
"arrayMarker"         { this.begin("COMMAND"); return 'arrayMarker';}
"arrayPointer"        { this.begin("COMMAND"); return 'arrayPointer';}
"arrayIndex"          { this.begin("COMMAND"); return 'arrayIndex';}
"atIndex"             return 'atIndex'
<COMMAND>"label"               return 'label'
"short"               return 'short'
"long"                return 'long'
"normal"              return 'normal'

"codegroup"           { this.begin("COMMAND"); return 'codegroup';}
"addCodeLine"         { this.begin("COMMAND"); return 'addCodeLine';}
"addCodeElem"         { this.begin("COMMAND"); return 'addCodeElem';}
"name"                return 'name'
"row"                 return 'row'
"columns"             return 'column'
"column"              return 'column'
"inline"              return 'inline'
"indentation"         return 'indentation'
"highlightColor"      return 'highlightColor'
"contextColor"        return 'contextColor'

"listelement"         { this.begin("COMMAND"); return 'listelement'; }
<COMMAND>"text"       return 'text';
"text"                { this.begin("COMMAND"); return 'text'; }
"pointers"            return 'pointers'
"prev"                return 'prev'
"next"                return 'next'
"boxFillColor"        return 'boxFillColor'
"pointerAreaColor"    return 'pointerAreaColor'
"pointerAreaFillColor"  return 'pointerAreaFillColor'
"textColor"           return 'textColor'

"point"               { this.begin("COMMAND"); return 'point';}

"arraySwap"           { this.begin("COMMAND"); return 'arraySwap';}
"arrayPut"            { this.begin("COMMAND"); return 'arrayPut';}
"moveArrayIndex"      { this.begin("COMMAND"); return 'moveArrayMarker';}
"moveArrayMarker"     { this.begin("COMMAND"); return 'moveArrayMarker';}
"moveArrayPointer"    { this.begin("COMMAND"); return 'moveArrayMarker';}
"moveIndex"           { this.begin("COMMAND"); return 'moveArrayMarker';}
"moveMarker"          { this.begin("COMMAND"); return 'moveArrayMarker';}
"movePointer"         { this.begin("COMMAND"); return 'moveArrayMarker';}
"jumpArrayIndex"      { this.begin("COMMAND"); return 'jumpArrayMarker';}
"jumpArrayMarker"     { this.begin("COMMAND"); return 'jumpArrayMarker';}
"jumpArrayPointer"    { this.begin("COMMAND"); return 'jumpArrayMarker';}
"jumpIndex"           { this.begin("COMMAND"); return 'jumpArrayMarker';}
"jumpMarker"          { this.begin("COMMAND"); return 'jumpArrayMarker';}
"jumpPointer"         { this.begin("COMMAND"); return 'jumpArrayMarker';}
"arrayEnd"            return 'arrayEnd'
"outside"             return 'outside'
"highlightArrayCell"  { this.begin("COMMAND"); return 'highlightArrayCell';}
"unhighlightArrayCell"  { this.begin("COMMAND"); return 'unhighlightArrayCell';}
"highlightArrayElem"  { this.begin("COMMAND"); return "highlightArrayElem";}
"unhighlightArrayElem"  { this.begin("COMMAND"); return "unhighlightArrayElem";}
"elementColor"        return 'elementColor'
"elemHighlight"       return 'elemHighlight'
"cellHighlight"       return 'cellHighlight'

"unhighlightCode"     { this.begin("COMMAND"); return 'unhighlightCode';}
"highlightCode"       { this.begin("COMMAND"); return 'highlightCode';}
"context"             return 'context'
"region"              return 'region'
<COMMAND>"color"      return 'color'
<COMMAND>"fillColor"  return 'fillColor'
"color"      return 'COLORCOMMAND'
'fillColor'  return 'FILLCOLORCOMMAND'
"clone"               { this.begin("COMMAND"); return 'clone';}
"type"                return 'type'
"delay"               { this.begin("COMMAND"); return 'delay';}
"clock"               return 'clock'
"echo"                { this.begin("COMMAND"); return 'echo';}
"print"               { this.begin("COMMAND"); return 'echo';}
"write"               { this.begin("COMMAND"); return 'echo';}
"location"            { this.begin("COMMAND"); return 'location';}
"boundingBox"         return 'boundingBox'
"bounds"              return 'boundingBox'
"visible"             return 'visible'
"ids"                 return 'ids'
"rule"                return 'rule'
"value"               return 'value'

"label"               { this.begin("COMMAND"); return 'LABELCOMMAND';}
"setLink"             { this.begin("COMMAND"); return 'setLink';}
"clearLink"           { this.begin("COMMAND"); return 'clearLink';}
"link"                return 'link'
"defineLocation"      { this.begin("COMMAND"); return 'location';}
"defLocation"         { this.begin("COMMAND"); return 'location';}
"moveLocation"        { this.begin("COMMAND"); return 'moveLocation';}

"ungroup"             { this.begin("COMMAND"); return 'ungroup';}
"group"               { this.begin("COMMAND"); return 'group';}
"merge"               { this.begin("COMMAND"); return 'group';}
"set"                 { this.begin("COMMAND"); return 'group';}
"remove"              { this.begin("COMMAND"); return 'ungroup';}

"square"              { this.begin("COMMAND"); return 'square';}
"relrectangle"        { this.begin("COMMAND"); return 'relrectangle';}
"relRectangle"        { this.begin("COMMAND"); return 'relrectangle';}
"relrect"             { this.begin("COMMAND"); return 'relrectangle';}
"rectangle"           { this.begin("COMMAND"); return 'rectangle';}
"rect"                { this.begin("COMMAND"); return 'rectangle';}
"triangle"            { this.begin("COMMAND"); return 'triangle';}
"polygon"             { this.begin("COMMAND"); return 'polygon';}
"polyline"            { this.begin("COMMAND"); return 'polyline';}
<COMMAND>"line"       return 'line'
"line"                { this.begin("COMMAND"); return 'polyline';}
"arc"                 { this.begin("COMMAND"); return 'arc';}
"ellipseseg"          { this.begin("COMMAND"); return 'ellipsesegment';}
"ellipsesegment"      { this.begin("COMMAND"); return 'ellipsesegment';}
"circleseg"           { this.begin("COMMAND"); return 'circlesegment';}
"circlesegment"       { this.begin("COMMAND"); return 'circlesegment';}
"radius"              return 'radius'
"angle"               return 'angle'
"starts"              return 'starts'
"clockwise"           return 'clockwise'
"counterclockwise"    return 'counterclockwise'
"ellipse"             { this.begin("COMMAND"); return 'ellipse';}
"circle"              { this.begin("COMMAND"); return 'circle';}
"at"                  return 'at'
"length"              return 'length'
"after"               return 'after'
"ticks"               return 'ticks'
"ms"                  return 'ms'
"within"              return 'within'
"hidden"              return 'hidden'
"centered"            return 'centered'
"boxed"               return 'boxed'
<COMMAND>"move"       { return 'move'; }
"move"                { this.begin("COMMAND"); return 'MOVECOMMAND';}
"translate"           { this.begin("COMMAND"); return 'MOVECOMMAND';}
"jump"                { this.begin("COMMAND"); return 'jump';}
"corner"              return 'corner'
"along"               return 'along'

"rotate"              { this.begin("COMMAND"); return 'rotate';}
"around"              return 'around'
"center"              return 'center'
"degrees"             return 'degrees'

"{"[\r\n]+            { this.begin("STEP"); return 'BEGIN_STEP'; }
"}"[\r\n]+            { this.popState(); return 'END_STEP'; }
"{"                   return '{';
"}"                   return '}';

"filled"              return 'filled'
"cellHighlight"       return 'cellHighlight'
"black"|"blue2"|"blue3"|"blue4"|"blue"|"brown2"|"brown3"|"brown4"|"cyan2"|"cyan3"|"cyan4"|"cyan"|"dark Gray"|"gold"|"green2"|"green3"|"green4"|"green"|"light Gray"|"light blue"|"magenta"|"magenta2"|"magenta3"|"magenta4"|"orange"|"pink2"|"pink3"|"pink4"|"pink"|"red2"|"red3"|"red4"|"red"|"white"|"yellow"   return 'COLOR_NAME'

"hideAllBut"          return 'hideAllBut'
"hideAll"             return 'hideAll'
"hideCode"            return 'hideCode'
"hide"                return 'hide'
"show"                return 'show'
"swap"                return 'swap'
"exchange"            return 'swap'
"setText"             return 'setText'
"setFont"             return 'setFont'

"font"                return 'font'
"SansSerif"           return 'SansSerif'
"Serif"               return 'Serif'
"Monospaced"          return 'Monospaced'
"size"                return 'size'
"bold"                return 'bold'
"italic"              return 'italic'

"offset"              return 'offset'
"baseline"            return 'baseline'
"start"               return 'start'
"end"                 return 'end'

"supports"            return 'supports'
"resource"            return RESOURCEKEY
"bundle"              return RESOURCEKEY
"resourceBundle"      return RESOURCEKEY

"graph"               { this.begin("COMMAND"); return 'graph';}
"bgColor"             return 'bgColor'
"outlineColor"        return 'outlineColor'
"elemHighlightColor"  return 'elemHighlightColor'
"nodeFontColor"       return 'nodeFontColor'
"edgeFontColor"       return 'edgeFontColor'
"directed"            return 'directed'
"weighted"            return 'weighted'
"nodes"               return 'nodes'
"edges"               return 'edges'
"edgeFont"            return 'font'
"origin"              return 'origin'
"showIndices"         return 'showIndices'
"unhighlightEdge"     return 'unhighlightEdge'
"highlightEdge"       return 'highlightEdge'
"transformEdge"       return 'transformEdge'
"unhighlightNode"     return 'unhighlightNode'
"highlightNode"       return 'highlightNode'
"transformNode"       return 'transformNode'
"setEdgeWeight"       return 'setEdgeWeight'
"edge"                return 'edge'

"grid"                { this.begin("COMMAND"); return 'grid';}
"lines"               return 'lines'
"style"               return 'style'
"plain"               return 'plain'
"matrix"              return 'matrix'
"table"               return 'table'
"junctions"           return 'junctions'
"cellWidth"           return 'cellWidth'
"cellHeight"          return 'cellHeight'
"maxCellWidth"        return 'maxCellWidth'
"maxCellHeight"       return 'maxCellHeight'
"fixedCellSize"       return 'fixedCellSize'
"borderColor"         return 'borderColor'
"highlightTextColor"  return 'highlightTextColor'
"highlightFillColor"  return 'highlightFillColor'
"highlightBorderColor"  return 'highlightBorderColor'
"align"               return 'align'
"highlightBackColor"  return 'highlightBackColor'
"setGridValue"        { this.begin("COMMAND"); return 'setGridValue';}
"setGridColor"        { this.begin("COMMAND"); return 'setGridColor';}
"setGridFont"         { this.begin("COMMAND"); return 'setGridFont';}
"swapGridValues"      { this.begin("COMMAND"); return 'swapGridValues';}
"unhighlightGridCell" { this.begin("COMMAND"); return 'unhighlightGridCell';}
"highlightGridCell"   { this.begin("COMMAND"); return 'highlightGridCell';}
"unhighlightGridElem" { this.begin("COMMAND"); return 'unhighlightGridElem';}
"highlightGridElem"   { this.begin("COMMAND"); return 'highlightGridElem';}
"alignGridValue"      { this.begin("COMMAND"); return 'alignGridValue';}
"refresh"             return 'refresh'

"declare"             {this.begin("VARIABLE"); return 'declare';}
"initValue"           return 'initValue'
"initvalue"           return 'initValue'
"role"                return 'role'
"update"              {this.begin("VARIABLE"); return 'update';}
"discard"             {this.begin("VARIABLE"); return 'discard';}

"fwArrow"             return 'fwArrow'
"bwArrow"             return 'bwArrow'
"closed"              return 'closed'

"("                   return '('
")"                   return ')'
","                   return ','
"*"                   return '*'
"+"                   return '+'
":"                   return ':'
'on'                  return 'on'
'position'            return 'position'
'from'                return 'from'
'to'                  return 'to'
'with'                return 'with'
'depth'               return 'depth'
'top'                 return 'top'
'left'                return 'left'
'right'               return 'right'
'bottom'              return 'bottom'
'none'                return 'none'
'x'                   return 'x'
'y'                   return 'y'
'width'               return 'width'
"height"              return 'height'
"via"                 return 'via'
"of"                  return 'of'
"and"                 return 'and'

'ptr'[0-9]+           return 'PTRNAT'

[0-9]+'*'[0-9]+       return 'SIZE'
[0-9]+"."[0-9]+\b     return 'DOUBLE'
[0-9]+                return 'NAT'
'-'[0-9]+             return 'NEGNAT'
\"[^\"\n]*\"          return 'QUOTED_STRING'

"-"                   return '-'
"NE"                  return 'DIRECTION'
"NW"                  return 'DIRECTION'
"N"                   return 'DIRECTION'
"NE"                  return 'DIRECTION'
"W"                   return 'DIRECTION'
"C"                   return 'DIRECTION'
"E"                   return 'DIRECTION'
"SW"                  return 'DIRECTION'
"S"                   return 'DIRECTION'
"SE"                  return 'DIRECTION'
"Northwest"           return 'DIRECTION'
"North"               return 'DIRECTION'
"Northeast"           return 'DIRECTION'
"West"                return 'DIRECTION'
"Middle"              return 'DIRECTION'
"Center"              return 'DIRECTION'
"East"                return 'DIRECTION'
"Southwest"           return 'DIRECTION'
"South"               return 'DIRECTION'
"Southeast"           return 'DIRECTION'

<VARIABLE>([a-zA-Z0-9]|'-')+          { return 'UnquotedString';}

[\r\n]+               {
              while (this.conditionStack[this.conditionStack.length-1] === "COMMAND") {
                this.popState();
              }
            }
\s+ /* skip whitespace */
<<EOF>>               { return 'EOF'; }
/lex


%start AnimalScriptFile

%%

AnimalScriptFile
  : FileHeader Commands Eof
  ;

FileHeader
  : ANIMAL Version Size TitleInfo AuthorInfo
  ;

Version
  : DOUBLE
  | NAT
  | /* empty */
  ;

Size
  : SIZE
    { 
      var sizes = $1.split("*");
      jsav.canvas.css({ width: sizes[0], height: sizes[1] });
    }
  | /* empty */
  ;

TitleInfo
  : title QUOTED_STRING
  | /* empty */
  ;

AuthorInfo
  : author QUOTED_STRING
  | /* empty */
  ;

Commands
  : Command Commands
  | /* empty */
  ;

Command
  : ObjectPrimitives
  | Operations
  | BEGIN_STEP
    { this._insideStep = true; }
  | END_STEP
    { this._insideStep = false; jsav.step(); }
  | LanguageSupport
  | ExtensionCommand
  ;

ObjectPrimitives
  : ArcTypes
  {
    console.error("arc commands not yet supported");
  }
  | Array
  | ArrayMarker
  | CodeTypes
  | ListElement
  {
    console.error("ListElements not yet supported");
  }
  | Point
  | PolygonTypes
  | Polyline
  | Text
  | I18nText
  {
    console.error("I18nText not yet supported");
  }
  | GraphDef
  | GridDefinition
  | VariableDeclaration
  {
    console.error("Variables not yet supported");
  }
  ;

Operations
  : ArrayOp
  | Clone
  | ColorChangeTypes
  | Delay
  | Echo
  {
    console.error("Echo commands not yet supported");
  }
  | Label
  | Link
  {
    console.error("Link commands not yet supported");
  }
  | Location
  | Merge
  | Move
  | Rotate
  | ShowTypes
  | Swap
  | SetText
  | SetFont
  | JHAVEInteractionSupport
  {
    console.error("JHAVEInteractionSupport commands not yet supported");
  }
  | EmbedFile
  | MethodSupport
  | PropertyChange
  {
    console.error("propertyChange commands not yet supported");
  }
  | GraphOps
  | GridOps
  | VariableOps
  {
    console.error("Variable operations not yet supported");
  }
  ;

ArcTypes
  : Arc
  | CircleSeg
  | Ellipse
  | Circle
  ;

Arc
  : ArcName String NodeDefinition 'radius' NodeDefinition ArcOptions
  ;

ArcName
  : arc
  | ellipsesegment
  ;

CircleSeg
  : circlesegment String NodeDefinition radius Int ArcOptions
  ;

ArcOptions
  : ArcAngle ArcStarts ArcDirection ColorDef DepthDef ClosedName FillOptions ArrowOptions DisplayOptions
  ;

ArcAngle
  : angle Int
  | /* empty */
  ;

ArcStarts
  : starts Int
  | /* empty */
  ;

ArcDirection
  : clockwise
  | counterclockwise
  | /* empty */
  ;

Ellipse
  : ellipse String NodeDefinition radius NodeDefinition ClosedOptions
  ;

Circle
  : circle String NodeDefinition radius Int ClosedOptions
    {
      var opts = $6.opts;
      if ('color' in $6) { opts.stroke = $6.color; }
      if ('fill' in $6) { opts.fill = $6.fill; }
      var circle = jsav.g.circle($3.left, $3.top, parseInt($5, 10), opts);
      circle.id($2);
      asuobjs[$2] = circle;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

/* Array STUFF */

Array
  : ArrayKey String OptionalAt NodeDefinition ColorDef FillColorDef ElemColorDef ElemHighlightColorDef CellHighlightColorDef ArrayDirection length NAT ArrayValues DepthDef TimeOffset Cascaded TimingWithinDef HiddenDef Font
    {
      var cssProps = [];
      // element border color
      if ($5) { cssProps.push("#" + $2 + " .jsavindex {border-color:" + $5 + ';}'); }
      // element background color
      if ($6) { cssProps.push("#" + $2 + " .jsavindex {background-color:" + $6 + ';}'); }
      // element color (=text color)
      if ($7) { cssProps.push("#" + $2 + " .jsavvalue {color:" + $7 + ';}'); }
      // element highlight color
      if ($8) { cssProps.push("#" + $2 + " .jsavvalue.jsavelemhighlight {color:" + $8 + 
                              ' !important;}'); }
      // cell highlight color
      if ($9) { cssProps.push("#" + $2 + " .jsavvalue.jsavcellhighlight {" +
                              "background-color:" + $9 + ' !important;}'); }
      // font definition
      if ($19) {
        cssProps.push("#" + $2 + " .jsavnode {" + $19 + "}");
      }
      // depth
      if (typeof $14 !== undefined) {
        cssProps.push(AsuHelpers.depthToCss($14, "#" + $2));
      }
      // add the generated CSS to the DOM
      asustyle.html(asustyle.html() + cssProps.join(""));
      
      var arrayOpts = $.extend({},
                      $4,  // position
                      $10, // direction (aka layout)
                      $15, // timeoffset
                      $17, // duration
                      $18); // visibility (hidden)
      // handle vertical arrays
      if ($10 === "vertical") { arrayOpts.layout = "vertical"; }

      // length of an array must always match number of ArrayValues, so ignore length

      // handle array cascade
      if ($16) { console.error("Array cascade not supported yet, displaying all values at once");}

      var arr = jsav.ds.array($13, arrayOpts);
      arr.id($2);
      arr.layout();
      asuobjs[$2] = arr;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

ArrayKey
  : array 
  | field
  ;

OptionalAt
  : at
  | /* empty */
  ;

ArrayValues
  : ArrayValues IntString
    {$$ = $1.concat($2);}
  | IntString
    {$$ = [$1];}
  ;

FillColorDef
  : fillColor Color
    { $$ = $2; }
  | /* empty */
  ;

ElemColorDef
  : elementColor Color
    { $$ = $2; }
  | /* empty */
  ;

ElemHighlightColorDef
  : elemHighlight Color
    { $$ = $2; }
  | elemHighlightColor Color
    { $$ = $2; }
  | /* empty */
  ;

CellHighlightColorDef
  : cellHighlight Color
    { $$ = $2; }
  | /* empty */
  ;

ArrayDirection
  : horizontal
  | vertical
    { $$ = {layout: "vertical"}; }
  | /* empty */
  ;

Cascaded
  : cascaded
  | /* empty */
  ;

ArrayMarker
  : MarkKey String on String atIndex NAT MarkerLabel ArrowLength ColorDef DepthDef Font DisplayOptions
    {
      var pointerOpts = $.extend({targetIndex: parseInt($6, 10)}, $8, $12);
      var cssProps = [];
      // marker color
      if ($9) { cssProps.push("#" + $2 + ".jsavpointer {color:" + $9 + ';}'); }
      // font definition
      if ($11) { cssProps.push("#" + $2 + " .jsavvalue {" + $11 + "}"); }
      // depth
      if ($10) { cssProps.push(AsuHelpers.depthToCss($10, "#" + $2)); }
      // add the generated CSS to the DOM
      asustyle.html(asustyle.html() + cssProps.join(""));
      var pointer = jsav.pointer($7 || "", asuobjs[$4], pointerOpts);
      pointer.id($2);
      asuobjs[$2] = pointer;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
MarkKey
  : arrayMarker
  | arrayPointer
  | arrayIndex
  ;
MarkerLabel
  : label IntString
   { $$ = $2; }
  | /* empty */
  ;
ArrowLength
  : short
    { $$ = { top: "-15px"}; }
  | long
    { $$ = { top: "-40px"}; }
  | normal
    { $$ = { top: "-25px"}; }
  | /* empty */
    { $$ = { top: "-25px"}; }
  ;

CodeTypes
  : CodeGroup
  | CodeLine
  | CodeElem
  ;
CodeGroup
  : codegroup String OptionalAt NodeDefinition ColorDef HighlightColorDef ContextColorDef Font DepthDef TimeOffset
    {
      var opts = $.extend({ lineNumbers: false },
                          $4, // position
                          $10), // timing
          cssProps = [];

      // handle default text color
      if ($5) { cssProps.push("#" + $2 + " {color:" + $5 + ";}"); }
      // handle highlight text color
      if ($6) { cssProps.push("#" + $2 + " .jsavhighlight {color:" +
                              $6 + " !important; background-color: transparent !important;}");}
      // handle context highlight color
      if ($7) { cssProps.push("#" + $2 + " .asucontexthighlight {color:" +
                              $7 + ";}"); }
      // handle font
      if ($8) { cssProps.push("#" + $2 + " {" + $8 + "}"); }
      // depth
      if ($9) { cssProps.push(AsuHelpers.depthToCss($9, "#" + $2)); }
      // add the generated CSS to the DOM
      asustyle.html(asustyle.html() + cssProps.join(""));

      // create the actual JSAV pseudocode object
      var code = jsav.code([], opts);
      code.id($2);
      asuobjs[$2] = code;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
HighlightColorDef
  : highlightColor Color
    { $$ = $2; }
  | /* empty */
  ;
ContextColorDef
  : contextColor Color
    { $$ = $2; }
  | /* empty */
  ;
CodeLine
  : addCodeLine String NameDef to String Indentation TimeOffset
    {
      var pseudo = asuobjs[$5],
          indentation = $6;
      pseudo.addCodeLine(indentation + $2);
    }
  ;
CodeElem
  : addCodeElem String NameDef to String RowDef ColDef InlineDef Indentation TimeOffset
  ;
NameDef
  : name String
  | /* empty */
  ;
RowDef
  : row NAT
    { $$ = parseInt($2, 10); }
  | /* empty */
  ;
ColDef
  : column NAT
    { $$ = parseInt($2, 10); }
  | /* empty */
  ;
InlineDef
  : inline
  | /* empty */
  ;
Indentation
  : indentation NAT
    { 
      var indent = parseInt($2, 10),
          indStr = "";
      for (; indent > 0; indent--) {
        indStr += " ";
      }
      $$ = indStr;
    }
  | /* empty */
    { $$ = ""; }
  ;

ListElement
  : listelement String NodeDefinition TextDef pointers NAT PointerPositionDef PtrLocations Prev Next ColorDef BoxFillColorDef PointerAreaColorDef PointerAreaFillColorDef TextColorDef DepthDef DisplayOptions
  ;
TextDef
  : text IntString
  | /* empty */
  ;
PointerPositionDef
  : position PointerPos
  | /* empty */
  ;
PointerPos
  : top
  | left
  | right
  | bottom
  | none
  ;
PtrLocations
  : PtrLocation PtrLocations
  | /* empty */
  ;
PtrLocation
  : PTRNAT NodeDefinition
  | PTRNAT to String
  ;
Prev
  : prev String
  | /* empty */
  ;
Next
  : next String
  | /* empty */
  ;
BoxFillColorDef
  : boxFillColor Color
    { $$ = $2; }
  | /* empty */
  ;
PointerAreaColorDef
  : pointerAreaColor Color
    { $$ = $2; }
  | /* empty */
  ;
PointerAreaFillColorDef
  : pointerAreaFillColor Color
    { $$ = $2; }
  | /* empty */
  ;
TextColorDef
  : textColor Color
    { $$ = $2; }
  | /* empty */
  ;

Point
  : point String NodeDefinition ColorDef DepthDef DisplayOptions
    {
      var opts = $.extend($3, $6),
          cssProps = [];
      // color
      if ($4) { cssProps.push("#" + $2 + "{color:" + $4 + ';}'); }
      // depth
      if (typeof $5 !== undefined) {
        cssProps.push(AsuHelpers.depthToCss($5, "#" + $2));
      }
      // add the generated CSS to the DOM
      asustyle.html(asustyle.html() + cssProps.join(""));
      
      var point = jsav.label(".", opts);
      point.id($2);
      asuobjs[$2] = point;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

PolygonTypes
  : Square
  | Rect
  | Triangle
  | Polygon
  ;

Square
  : square String NodeDefinition NAT ClosedOptions
    {
      var opts = $5.opts,
          sideLength = parseInt($4, 10);
      if ('color' in $5) { opts.stroke = $5.color; }
      if ('fill' in $5) { opts.fill = $5.fill; }
      var square = jsav.g.rect($3.left, $3.top,
                               sideLength, sideLength,
                               opts);
      square.id($2);
      asuobjs[$2] = square;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

Rect
  : AbsoluteRectangle
  | RelativeRectangle
  ;

AbsoluteRectangle
  : rectangle String NodeDefinition NodeDefinition ClosedOptions
    {
      var opts = $5.opts;
      if ('color' in $5) { opts.stroke = $5.color; }
      if ('fill' in $5) { opts.fill = $5.fill; }
      var rect = jsav.g.rect($3.left, $3.top,
                             $4.left - $3.left, $4.top - $3.top,
                             opts);
      rect.id($2);
      asuobjs[$2] = rect;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

RelativeRectangle
  : relrectangle String NodeDefinition NodeDefinition ClosedOptions
    {
      var opts = $5.opts;
      if ('color' in $5) { opts.stroke = $5.color; }
      if ('fill' in $5) { opts.fill = $5.fill; }
      var rect = jsav.g.rect($3.left, $3.top,
                             $4.left, $4.top,
                             opts);
      rect.id($2);
      asuobjs[$2] = rect;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

Triangle
  : triangle String NodeDefinition NodeDefinition NodeDefinition ClosedOptions
    {
      var opts = $6.opts,
          points = [[$3.left, $3.top], [$4.left, $4.top],
                    [$5.left, $5.top]];
      if ('color' in $6) { opts.stroke = $6.color; }
      if ('fill' in $6) { opts.fill = $6.fill; }
      var poly = jsav.g.polygon(points, opts);
      poly.id($2);
      asuobjs[$2] = poly;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

Polygon
  : polygon String NodeDefinition NodeDefinition NodeDefinitions ClosedOptions
    {
      $5.unshift([$3.left, $3.top])
      $5.unshift([$4.left, $4.top])
      var opts = $6.opts;
      if ('color' in $6) { opts.stroke = $6.color; }
      if ('fill' in $6) { opts.fill = $6.fill; }
      var poly = jsav.g.polygon($5, opts);
      poly.id($2);
      asuobjs[$2] = poly;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
NodeDefinitions
  : NodeDefinitions NodeDefinition
    { $1.push([$2.left, $2.top]); $$ = $1;}
  | NodeDefinition
    { $$ = [[$1.left, $1.top]];}
  ;

/* Both polyline and line commands are unified to polyline by the lexer */
Polyline
  : polyline String NodeDefinition NodeDefinitions OpenOptions
    {
      $4.unshift([$3.left, $3.top])
      var opts = $5.opts;
      if ('color' in $5) { opts.stroke = $5.color; }
      var poly = jsav.g.polyline($4, opts);
      poly.id($2);
      asuobjs[$2] = poly;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

Text
  : text String IntString OptionalAt NodeDefinition TextAlignment ColorDef DepthDef Font BoxedDef DisplayOptions
    {
      var opts = $.extend({}, $5, $11),
          cssProps = [],
          widthFactor = $6;
      // font color
      if ($7) { cssProps.push("#" + $2 + "{color:" + $7 + ';}'); }
      // boxed definition -> add black border
      if ($10) { cssProps.push("#" + $2 + "{border:1px solid black;}"); }
      // font definition
      if ($9) { cssProps.push("#" + $2 + " {" + $9 + "}"); }
      // depth
      if ($8) { cssProps.push(AsuHelpers.depthToCss($8, "#" + $2)); }
      // add the generated CSS to the DOM
      asustyle.html(asustyle.html() + cssProps.join(""));
      var text = jsav.label($3, opts);
      text.id($2);
      // take the alignment into account
      var bounds = text.bounds();
      text.element.css({left: "-=" + widthFactor*bounds.width + "px"});
      asuobjs[$2] = text;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
/** Reduces to a factor of element width that the text should be translated */
TextAlignment
  : centered
    { $$ = 0.5; }
  | right
    { $$ = 1; }
  | /* empty */
    { $$ = 0; }
  ;
BoxedDef
  : boxed
  | /* empty */
  ;

ClosedOptions
  : ColorDef DepthDef FillOptions DisplayOptions
    { 
      var opts = {depth: $2, opts: $.extend({}, $4)};
      if ($1) { opts.color = $1; }
      if ($3) { opts.fill = $3; }
      $$ = opts;
    }
  ;
OpenOptions
  : ColorDef DepthDef ArrowOptions DisplayOptions
    { 
      var opts = {depth: $2, opts: $.extend({}, $3, $4)};
      if ($1) { opts.color = $1; }
      $$ = opts;
    }
  ;

ColorDef
  : color Color
    { $$ = $2; }
  | /* empty */
  ;
Color
  : COLOR_NAME
      { $$ = 'rgb(' + AsuHelpers.colorNameToRGB($1) + ')'; }
  | '(' NAT ',' NAT ',' NAT ')'
      { $$ = 'rgb(' + $2 + ',' + $4 + ',' + $6 + ')'; }
  | /* empty */
  ;

DepthDef
  : depth NAT
    { $$ = parseInt($2, 10); }
  | /* empty */
    { $$ = 1;}
  ;



ArrayOp
  : ArraySwap
  | ArrayPut
  | MoveArrayMarker
  | HighlightArrayCell
  | HighlightArrayElem
  ;

ArrayPut
  : arrayPut String on String position NAT Timing
    { 
      var arr = asuobjs[$4],
          pos = parseInt($6, 10),
          arrSize = arr.size();
      if (pos < arrSize && pos >= 0) {
        arr.value(pos, $2, $7);
      } else {
        console.error("Invalid position for arrayPut on '" + $4 + "' position", pos);
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

ArraySwap
  : arraySwap on String position NAT with NAT Timing
    {
      asuobjs[$3].swap($5, $7, $8);
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

/* The different moveMarkerKeywords are unified by the lexer to 
  moveArrayMarker and jumpArrayMarker */
MoveArrayMarker
  : MoveOrJumpArrayMarker String to MarkerPositionDef Timing
    {
      var pointer = asuobjs[$2],
          targetArr = pointer.target(),
          // duration:0 for jump overrides timing
          opts = $.extend({}, $5, $1);
      if ($4 === "end") {
        opts.targetIndex = targetArr.size() - 1;
      } else if ($4 === "out") {
        opts.targetIndex = targetArr.size() - 1;
        // move the target outside the last index
        opts.anchor = "right top";
        opts.left = "20px";
      } else {
        // just a normal index in the array
        opts.targetIndex = $4;
      }
      pointer.target(targetArr, opts);
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
MoveOrJumpArrayMarker
  : moveArrayMarker
    { $$ = {}; }
  | jumpArrayMarker
    { $$ = {duration: 0}; }
  ;
MarkerPositionDef
  : position NAT
    { $$ = parseInt($2, 10); }
  | arrayEnd
    { $$ = 'end'; }
  | outside
    { $$ = 'out'; }
  ;

HighlightArrayCell
  : HlACellKeyword on String HighlightRange Timing
    {
      asuobjs[$3][$1]($4, "jsavcellhighlight", $5);
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
HlACellKeyword
  : highlightArrayCell
    { $$ = 'addClass'; }
  | unhighlightArrayCell
    { $$ = 'removeClass'; }
  ;
HighlightRange
  : position NAT
    { $$ = $2; }
  | to NAT
    { $$ = function(index) { return index <= $2; }; }
  | from NAT to NAT
    { $$ = function(index) { return $2 <= index && index <= $4; }; }
  | from NAT
    { $$ = function(index) { return $2 <= index; }; }
  | /* empty */
    { $$ = true; }
  ;
HighlightArrayElem
  : HlAElemKeyword on String HighlightRange Timing
    {
      asuobjs[$3][$1]($4, "jsavelemhighlight", $5);
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
HlAElemKeyword
  : highlightArrayElem
    { $$ = 'addClass'; }
  | unhighlightArrayElem
    { $$ = 'removeClass'; }
  ;

Clone
  : clone String as String OptionalAt NodeDefinition DisplayOptions
    {
      console.error("Cloning of objects not yet supported");
    }
  ;

ColorChangeTypes
  : ColorChange
  | CodeColorChange
  ;
ColorChange
  : ColorKeyword Oids ColorTypeDef Color Timing
    {
    var objIds = $2,
        type = $3 || $1,
        obj, prop, newProp;
    for (var i = objIds.length; i--; ) {
      obj = asuobjs[objIds[i]];
      newProp = {};
      if (JSAV.utils.isGraphicalPrimitive(obj)) {
        if (type === "color") { prop = "stroke"; }
        else if (type === "fillColor") { prop = "fill"; }
        else { console.error("ColorChange of type", type, "not yet implemented"); }
      } else {
        if (type === "color") { prop = type; }
        else if (type === "fillColor") { prop = "background-color"; }
        else { console.error("ColorChange of type", type, "not yet implemented"); }
      }
      newProp[prop] = $4;
      obj.css(newProp, $5);
    }
    }
  ;
ColorKeyword
  : COLORCOMMAND
    { $$ = "color"; }
  | FILLCOLORCOMMAND
    { $$ = "fillColor"; }
  ;
ColorTypeDef
  : type String
    { $$ = $2; }
  | /* empty */
  ;
CodeColorChange
  : CodeColorType on String line NAT RowDef ColDef ContextOrRegion Timing
    {
      var line = parseInt($5, 10);
      if (!($6 || $7)) { // code group (no row or col specified)
        // this is: asubobjs[objId].add/RemoveClass(line, className, opts)
        asuobjs[$3][$1](line, $8 || "jsavhighlight", $9);
      } else { // code element
        console.error("(un)highlight of code elements not yet supported", $3);
        // how to implement:
        // - get the codeline
        // - get the row/col:th asucodelement object
        // - wrap the JSAV.anim and add/remove the class
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
CodeColorType
  : highlightCode
    { $$ = "addClass"; }
  | unhighlightCode
    { $$ = "removeClass"; }
  ;
ContextOrRegion
  : context
    { $$ = "asucontexthighlight"; }
  | region
  | /* empty */
  ;

Delay
  : delay NAT
  | delay NAT ms
  | delay clock on String
  ;

Echo
  : echo location ':' NodeDefinition
  | echo boundingBox ':' Oids
  | echo text ':' String
  | echo value ':' Oids
  | echo ids ':' Oids
  | echo visible
  | echo rule ':' String
  ;

Label
  : LABELCOMMAND String
    {
      jsav.stepOption("label", $2);
    }
  ;

Link
  : setLink String LinkDef to String Timing
  | setLink String LinkDef NodeDefinition Timing
  | clearLink String LinkDef Timing
  ;
LinkDef
  : link NAT
  | /* empty */
  ;

Location
  : location String OptionalAt NodeDefinition
  | moveLocation String to NodeDefinition
  ;

/* group, merge, set are unified by lexer to group
  ungroup and remove are unified to ungroup */
Merge
  : group String Oids
    {
      asugroups[$2] = $3;
      AsuHelpers.handledCommand(this, jsav);
    }
  | ungroup String Oids
    {
      var group = asugroups[$2],
          remove = $3;
      // remove the object IDs in the remove list
      for (var i = 0, l = remove.length; i < l; i++) {
        group.splice(group.indexOf(remove[i]), 1);
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

Move
  : MoveVia
  | MoveAlong
  | MoveTo
  ;
MoveKeyword
  : MOVECOMMAND
    { $$ = {}; }
  | jump
    { $$ = {duration: 0}; }
  ;
MoveVia
  : MoveKeyword Oids Corner MethodSpec via String Timing
    {
      var objIds = $2,
          viaObj = asuobjs[$6],
          opts = $.extend($7, $1),
          obj, translation, i,
          viaObjPoints,
          viaObjLastPoint, viaObjFirstPoint;
      // only if the object has .points() function, can we move via it
      if (!$.isFunction(viaObj.points)) {
        console.error("Object to move via has to be a polyline, polygon, etc.",
                      $6, "is not!");
        return;
      }
      viaObjPoints = viaObj.points();
      // get the last point
      viaObjLastPoint = viaObjPoints[viaObjPoints.length - 1];
      viaObjFirstPoint = viaObjPoints[0];
      // calculate the transition (last point, relative to the first point)
      translation = [viaObjLastPoint[0] - viaObjFirstPoint[0],
                     viaObjLastPoint[1] - viaObjFirstPoint[1]];
      for (i = objIds.length; i--; ) {
        obj = asuobjs[objIds[i]];
        if (JSAV.utils.isGraphicalPrimitive(obj)) {
          obj.translate(translation[0], translation[1], opts);
        } else {
          obj.css({left: "+=" + translation[0] + "px",
                   top: "+=" + translation[1] + "px"}, opts);
        }
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
MoveAlong
  : MoveAlongPolyline
  | MoveAlongArc
  ;
MoveAlongPolyline
  : MoveKeyword Oids Corner MethodSpec along LineOrPolyline NodeDefinition NodeDefinitions Timing
    {
      var objIds = $2,
          opts = $.extend($9, $1),
          obj, translation, i,
          viaObjLastPoint = $8[$8.length - 1],
          viaObjFirstPoint = [$7.left, $7.top];
      // calculate the translation (last point, relative to the first point)
      translation = [viaObjLastPoint[0] - viaObjFirstPoint[0],
                     viaObjLastPoint[1] - viaObjFirstPoint[1]];
      for (i = objIds.length; i--; ) {
        obj = asuobjs[objIds[i]];
        if (JSAV.utils.isGraphicalPrimitive(obj)) {
          obj.translate(translation[0], translation[1], opts);
        } else {
          obj.css({left: "+=" + translation[0] + "px",
                   top: "+=" + translation[1] + "px"}, opts);
        }
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
LineOrPolyline
  : line
  | polyline
  ;
MoveAlongArc
  : MoveKeyword Oids Corner MethodSpec along ArcType NodeDefinition Int Int Int Int Timing
  | MoveKeyword Oids Corner MethodSpec along CircleType NodeDefinition Int Int Int Timing
  ;
MoveTo
  : MoveKeyword Oids Corner MethodSpec to NodeDefinition Timing
    {
      var objs = $2,
          anchor = $3,
          move = $6,
          timing = $.extend($7, $1),
          bounds, obj, newPos;
      for (var i = objs.length; i--; ) {
        obj = asuobjs[objs[i]];
        bounds = obj.bounds();
        newPos = AsuHelpers.applyDirection(anchor, move, { width: 0-bounds.width,
                                                          height: 0-bounds.height,
                                                          left: 0,
                                                          top: 0});
        if (JSAV.utils.isGraphicalPrimitive(obj)) {
          obj.translate(newPos.left - bounds.left, newPos.top - bounds.top);
        } else {
          obj.css(newPos, timing);
        }
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

MethodSpec
  : type String
    { $$ = $2; }
  | /* empty */
  ;

Corner
  : corner Direction
    { $$ = $2; }
  | /* empty */
    { $$ = "NW"; }
  ;
ArcType
  : ArcName
  | ellipse
  ;
CircleType
  : circle
  | circlesegment
  ;

Rotate
  : rotate Oids around String DegreesDef Timing
    {
      var objs = $2,
          obj;
      for (var i = objs.length; i--; ) {
        if (JSAV.utils.isGraphicalPrimitive(asuobjs[objs[i]])) {
          asuobjs[objs[i]].rotate(0 - $5, $6);
        } else {
          console.error("Rotating", objs[i], "not yet supported!");
        }
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  | rotate Oids center NodeDefinition DegreesDef Timing
  ;
DegreesDef
  : degrees Int
    { $$ = parseInt($2, 10); }
  ;

ShowTypes
  : SimpleShow
  | CodeHide
  | SelectiveHide
  ;
SimpleShow
  : ShowMode Oids MethodSpec Timing
    {
      var id;
      for (var i = 0, l = $2.length; i < l; i++) {
        id = $2[i];
        if (id in asuobjs) {
          asuobjs[id][$1]($4);
        } else if (id in asugroups) {
          var grp = asugroups[id];
          for (var j = 0, k = grp.length; j < k; j++) {
            asuobjs[grp[j]][$1]($4);
          }
        }
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
CodeHide
  : hideCode String TimeOffset
    {
      if (asuobjs[$2]) {
        asuobjs[$2].hide($3);
      } else {
        console.error("Node code to hide with ID", $2);
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
SelectiveHide
  : hideAll MethodSpec Timing
    {
      for (var id in asuobjs) {
        if (asuobjs.hasOwnProperty(id)) {
          asuobjs[id].hide($3);
        }
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  | hideAllBut Oids MethodSpec Timing
    {
      for (var id in asuobjs) {
        if (asuobjs.hasOwnProperty(id) && $2.indexOf(id) === -1) {
          asuobjs[id].hide($4);
        }
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
ShowMode
  : show
  | hide
  ;

/* swap and exchange keywords are normalized to swap by the lexer */
Swap
  : swap String String
    {
      var obj1 = asuobjs[$2],
          obj2 = asuobjs[$3];
      // change object IDs
      obj1.id($3);
      obj2.id($2);
      // change objects
      asuobjs[$3] = obj1;
      asuobjs[$2] = obj2;
      AsuHelpers.handledCommand(this, jsav);
    }
  ;

SetText
  : setText OptionalOf String MethodSpec to IntString Timing
    {
      var opts = $7;
      // TODO: what should be done with the MethodSpec
      asuobjs[$3].text($6, $7);
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
OptionalOf
  : of
  | /* empty */
  ;
SetFont
  : setFont OptionalOf String OptionalTo Font Timing
    {
      var obj = asuobjs[$3],
          newFont = {},
          fontDef = $5.split(';'),
          fdef;
      for (var i = fontDef.length - 1; i--; ) {
        fdef = fontDef[i].split(':');
        newFont[fdef[0]] = fdef[1];
      }
      obj.css(newFont, $6);
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
OptionalTo
  : to
  | /* empty */
  ;

LanguageSupport
  : supports Oids ResourceDef
  ;
ResourceDef
  : RESOURCEKEY String
  ;

DisplayOptions
  : HiddenDef TimeOffset
    { $$ = $.extend({}, $1, $2); }
  ;
HiddenDef
  : hidden
    { $$ = { visible: false }; }
  | /* empty */
  ;

TimeOffset
  : after NAT TimeUnit
    {
      var time = parseInt($2, 10);
      // if in ticks, assume frame rate 50fps
      if ($3 !== "ms") { time = Math.round(1000*time/50); }
      $$ = { delay: time };
    }
  | /* empty */
  ;
Timing
  : TimeOffset TimingWithinDef
    { 
      // only set a value if either offset or duration is set
      if ($1 || $2) { $$ = $.extend($1, $2); }
    }
  ;
TimeUnit
  : ticks
  | ms
  | /* empty */
  ;
TimingWithinDef
  : within NAT TimeUnit
    {
      var time = parseInt($2, 10);
      if ($3 !== "ms") { time = 30*1000*time; }
      $$ = { duration: time };
    }
  | /* empty */
  ;

NodeDefinition
  : Offset
  | '(' Int ',' Int ')'
    {
      $$ = {left: parseInt($2, 10), top: parseInt($4, 10)};
      prevLoc = $$;
    }
  | move '(' Int ',' Int ')'
    {
      $$ = {left: prevLoc.left + parseInt($3, 10),
            top: prevLoc.top + parseInt($5, 10)};
      prevLoc = $$;
    }
  ;
Offset
  : offset '(' Int ',' Int ')' from String node NAT
    { 
      console.error("Offset from node not supported yet");
      $$ = { left: parseInt($3, 10), top: parseInt($5, 10),
            relativeTo: asuobjs[$8] };
      prevLoc = $$;
    }
  | offset '(' Int ',' Int ')' from String Direction
    {
      var obj = asuobjs[$8];

      // bounds of the objects we're positioning relative to
      var bounds = obj.bounds(),
          offset = obj.element.offset(), // offset of that object
          canvasOffset = jsav.canvas.offset(); // offset of JSAV canvas
      bounds.left = offset.left - canvasOffset.left;
      bounds.top = offset.top - canvasOffset.top;

      // apply the direction option, which will return {left:..., top:...}
      $$ = AsuHelpers.applyDirection($9,
                            { left: parseInt($3, 10),
                              top: parseInt($5, 10)},
                            bounds);
      prevLoc = $$;
    }
  | offset '(' Int ',' Int ')' from String
    {
      var obj = asuobjs[$8]; // should be a "point"

      // offset of the objects we're positioning relative to
      var offset = obj.element.offset(), // offset of that object
          canvasOffset = jsav.canvas.offset(); // offset of JSAV canvas

      $$ = { left: parseInt($3, 10) + (offset.left - canvasOffset.left),
             top: parseInt($5, 10) + (offset.top - canvasOffset.top)};
      prevLoc = $$;
    }
  | offset '(' Int ',' Int ')' from String baseline StartOrEnd
    {
      var obj = asuobjs[$8];

      // bounds of the objects we're positioning relative to
      var bounds = obj.bounds(),
          offset = obj.element.offset(), // offset of that object
          canvasOffset = jsav.canvas.offset(); // offset of JSAV canvas

      // apply the alignment option, which will return {left:..., top:...}
      $$ = AsuHelpers.applyDirection($10,
                            { left: parseInt($3, 10),
                              top: parseInt($5, 10)},
                            bounds);
      prevLoc = $$;
    }
  ;
Direction
  : DIRECTION
    { $$ = $1; }
  ;
StartOrEnd
  : start
    { $$ = "NW"; }
  | end
    { $$ = "NE"; }
  | /* empty */
    { $$ = "NW"; }
  ;

ArrowOptions
  : fwArrow
    { $$ = {"arrow-end": "classic-wide-long"}; }
  | bwArrow
    { $$ = {"arrow-start": "classic-wide-long"}; }
  | fwArrow bwArrow
    { $$ = {"arrow-end": "classic-wide-long", "arrow-start": "classic-wide-long"}; }
  | /* empty */
  ;
ClosedName
  : closed
  | /* empty */
  ;

FillOptions
  : filled FillColorDef
    { $$ = $2; }
  | /* empty */
  ;

Font
  : FontName FontSize FontBold FontItalic
    {
      var fontStr = "";
      if ($1) { fontStr += "font-family:" + $1 + ";"; }
      if ($2) {
        fontStr += "font-size:" + $2 + "px;";
        if ($2 > 25) {
          fontStr += "line-height:normal;";
        }
      }
      if ($3) { fontStr += "font-weight:bold;"; }
      if ($4) { fontStr += "font-style:italic"; }
      // only emit the string if it contains something
      if (fontStr) {
        $$ = fontStr;
      }
    }
  ;
FontName
  : font FontNames
    { $$ = $2; }
  | /* empty */
  ;
FontNames
  : Serif
    { $$ = 'serif'; }
  | SansSerif
    { $$ = 'sans-serif'; }
  | Monospaced
    { $$ = 'monospace'; }
  ;
FontSize
  : size NAT
    { $$ = parseInt($2, 10); }
  | /* empty */
  ;
FontBold
  : bold
  | /* empty */
  ;
FontItalic
  : italic
  | /* empty */
  ;

Oids
  : Oids String
    {
      if ($2 in asuobjs) {
        $$ = $1.concat($2);
      } else if ($2 in asugroups) {
        $$ = $1.concat(asugroups[$2]);
      } else {
        console.error("Unknown object ID", $2);
      }
    }
  | /* empty */
    { $$ = []; }
  ;

Int
  : NAT
  | NEGNAT
  | String ObjectPosition
  ;
Operator
  : +
  | -
  | *
  | ':'
  ;
ObjectPosition
  : x
  | y
  | width
  | height
  ;

IntString
  : String
  ;

String
  : QUOTED_STRING
    { $$ = $1.replace(/\"/g, ''); }
  ;

GraphDef
  : graph String size NAT ColorDef BgColorDef OutlineColorDef HighlightColorDef ElemHighlightColorDef NodeFontColorDef EdgeFontColorDef Directed Weighted nodes '{' Font GraphNodes '}' edges '{' Font GraphEdges '}' OriginDef ShowIndicesDef DepthDef DisplayOptions
    {
      var graphOpts = $.extend({},
                          $12, // directed
                          $13, // weighted
                          $24, // origin of the graph (top-left coord)
                          $27  // displayoptions
                      ),
          cssProps = [];
      // node color (=text color) ??
      if ($5) { cssProps.push("#" + $2 + " .jsavnode {color:" + $5 + ';}'); }
      // node background color
      if ($6) { cssProps.push("#" + $2 + " .jsavnode {background-color:" + $6 + ';}'); }
      // outline color
      if ($7) {
        cssProps.push("#" + $2 + " .jsavnode {border-color:" + $7 + ';}');
        cssProps.push("#" + $2 + " .jsavedge {stroke: " + $7 + ';}');
      }
      // node/edge highlight color
      if ($8) { 
        cssProps.push("#" + $2 + " .jsavnode.jsavhighlight {background-color:" +
                      $8 + ' !important;}');
        cssProps.push("#" + $2 + " .jsavnode.jsavhighlight .jsavvalue {" +
                      "background-color:transparent !important;}");
        cssProps.push("#" + $2 + " .jsavedge.jsavhighlight {stroke:" +
                      $8 + ' !important;}');
      }
      // element highlight color
      if ($9) {
          cssProps.push("#" + $2 + " .jsavnode.jsavhighlight {" +
                        "color:" + $9 + ' !important;' + '}');
          cssProps.push("#" + $2 + " .jsavnode.jsavhighlight .jsavvalue {" +
                        "color:" + $9 + ' !important;' + '}');
      }
      // node font color
      if ($10) { cssProps.push("#" + $2 + " .jsavnode {color:" + $10 + ';}'); }
      // edge font color
      if ($11) { cssProps.push("#" + $2 + " .jsavedgelabel {color:" + $10 + ';}'); }
      // node font definition
      if ($16) { cssProps.push("#" + $2 + " .jsavnode {" + $16 + "}"); }
      // edge font definition
      if ($21) { cssProps.push("#" + $2 + " .jsavedgelabel {" + $21 + "}"); }
      // depth
      if ($26) { cssProps.push(AsuHelpers.depthToCss($26, "#" + $2)); }
      // add the generated CSS to the DOM
      asustyle.html(asustyle.html() + cssProps.join(""));

      var nodes = $17,
          maxLeft = 0,
          maxTop = 0;
      for (var i = 0, l = nodes.length; i < l; i++) {
        maxLeft = Math.max(nodes[i][1].left);
        maxTop = Math.max(nodes[i][1].top);
      }
      graphOpts.height = maxTop + 45;
      graphOpts.width = maxLeft + 45;

      var graph = jsav.ds.graph(graphOpts),
          showIndices = $25,
          node;
      graph.id($2);
      asuobjs[$2] = graph;
      // add the nodes to the graph
      for (i = 0, l = nodes.length; i < l; i++) {
        node = graph.addNode(nodes[i][0], nodes[i][1]);
        if (showIndices) { // create node labels if necessary
          var label = jsav.label(i, {relativeTo: node, anchor: "right bottom",
                         myAnchor: "right bottom", left: "-5px",
                         top: "-5px"});
          label.element.css("z-index", 850);
        }
      }
      var edges = $22,
          nodes = graph.nodes();
      for (i = 0, l = edges.length; i < l; i++) {
        var opts = {};
        if (edges[i][2]) { opts.weight = edges[i][2]; }
        graph.addEdge(nodes[edges[i][0]], nodes[edges[i][1]], opts);
      }
      graph.layout();
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
BgColorDef
  : bgColor Color
    { $$ = $2; }
  | /* empty */
  ;
OutlineColorDef
  : outlineColor Color
    { $$ = $2; }
  | /* empty */
  ;
NodeFontColorDef
  : nodeFontColor Color
    { $$ = $2; }
  | /* empty */
  ;
EdgeFontColorDef
  : edgeFontColor Color
    { $$ = $2; }
  | /* empty */
  ;
Directed
  : directed
    { $$ = {directed: true}; }
  | /* empty */
    { $$ = {directed: false}; }
  ;
Weighted
  : weighted
    { $$ = { weighted: true}; }
  | /* empty */
    { $$ = { weighted: false}; }
  ;
GraphNodes
  : String OptionalAt NodeDefinition "," GraphNodes
    { $5.unshift([$1, $3]); $$ = $5; }
  | String OptionalAt NodeDefinition
    { $$ = [[$1, $3]]; }
  ;
EdgeFontDef
  : edgeFont Font
    { $$ = $2; }
  | /* empty */
  ;
GraphEdges
  : GraphEdges GraphEdge
    { $1.push($2); $$ = $1; }
  | /* empty */
    { $$ = []; }
  ;
GraphEdge
  : '(' NAT ',' NAT EdgeWeightDef ')'
    { $$ = [parseInt($2, 10), parseInt($4, 10), $5]; }
  ;
EdgeWeightDef
  : ',' IntString
    { $$ = $2; }
  | /* empty */
  ;
OriginDef
  : origin NodeDefinition
    { $$ = $2; }
  | /* empty, by default position to 0, 0 */
    { $$ = {left: 0, top: 0}; }
  ;
ShowIndicesDef
  : showIndices
    { $$ = true; }
  | /* empty */
  ;

GraphOps
  : HlEdge
  | HlNode
  | ChangeWeight
  ;
HlEdge
  : GraphEdgeHlKeyword on String MethodSpec EdgeDefs Timing
    {
      var graph = asuobjs[$3],
          edges = $5,
          nodes = graph.nodes(),
          func = $1 || $4, // transformEdge will use the methodspec
          edge;
      for (var i = edges.length; i--; ) {
        edge = graph.getEdge(nodes[edges[i][0]], nodes[edges[i][1]]);
        if (edge) { edge[func]($6); }
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
GraphEdgeHlKeyword
  : highlightEdge
    { $$ = "highlight"; }
  | transformEdge
    { $$ = ""; }
  | unhighlightEdge
    { $$ = "unhighlight"; }
  ;
EdgeDefs
  : '(' NAT ',' NAT ')' EdgeDefs
    { $6.push([parseInt($2, 10), parseInt($4, 10)]);$$ = $6; }
  | /* empty */
    { $$ = [];}
  ;
HlNode
  : GraphNodeHlKeyword on String MethodSpec nodes NodeDefs Timing
    {
      var graph = asuobjs[$3],
          graphNodes = graph.nodes(),
          targetNodes = $6,
          func = $1 || $4; // transformEdge will use the methodspec
      for (var i = targetNodes.length; i--; ) {
        graphNodes[targetNodes[i]][func]($7);
      }
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
GraphNodeHlKeyword
  : highlightNode
    { $$ = "highlight"; }
  | transformNode
    { $$ = ""; }
  | unhighlightNode
    { $$ = "unhighlight"; }
  ;
NodeDefs
  : NAT NodeDefs
    { $2.push(parseInt($1, 10));$$ = $2; }
  | /* empty */
    { $$ = [];}
  ;
ChangeWeight
  : setEdgeWeight of String OptionalEdge '(' NAT ',' NAT ')' to String
    {
      var graph = asuobjs[$3],
          nodes = graph.nodes(),
          edge = graph.getEdge(nodes[parseInt($6, 10)], nodes[parseInt($8)]);
      edge.weight($11);
      AsuHelpers.handledCommand(this, jsav);
    }
  ;
OptionalEdge
  : edge
  | /* empty */
  ;

GridDefinition
  : grid String NodeDefinition LinesDef ColDef StyleDef CellWidthDef MaxCellWidthDef CellHeightDef MaxCellHeightDef FixedCellSizeDef ColorDef ElemColorDef TextColorDef FillColorDef BorderColorDef HighlightTextColorDef HighlightBackColorDef HighlightFillColorDef HighlightBorderColorDef Font AlignDef DepthDef Timing
    {
      var cssProps = [],
          style = $6;

      // cell sizings
      if ($7) { cssProps.push("#" + $2 + " .jsavindex { width:" + $7 + "px;}");}
      if ($8) { cssProps.push("#" + $2 + " .jsavindex { max-width:" + $8 + "px;}");}
      if ($9) { cssProps.push("#" + $2 + " .jsavindex { height:" + $9 + "px;}");}
      if ($10) { cssProps.push("#" + $2 + " .jsavindex { max-height:" + $10 + "px;}");}
      if ($11 && $7) { // fixed sizing and width def, use width as max-width
        cssProps.push("#" + $2 + " .jsavindex { max-width:" + $7 + "px;}");
      }
      if ($11 && $9) { // fixed sizing and height def, use width as max-height
        cssProps.push("#" + $2 + " .jsavindex { max-height:" + $9 + "px;}");
      }

      // color def, used if text/border colors are not specified
      if ($12) {
        if (!$14) { cssProps.push("#" + $2 + " .jsavvalue {color:" + $12 + ';}'); }
        if (!$16) {
          if (style === "asutable") {
            cssProps.push("#" + $2 + " .jsavindex {border-color:" + $12 + ';}');
          } else if (style === "asumatrix") {
            // for matrix style, the borders are specified for the main element
            cssProps.push("#" + $2 + "{border-color:" + $12 + ';}');
          }
        }
      }
      // text color
      if ($14) { cssProps.push("#" + $2 + " .jsavvalue {color:" + $14 + ';}'); }
      // element fill color
      if ($15) {
        if (style === "asutable" || style === "asuplain") {
          cssProps.push("#" + $2 + " .jsavindex {background-color:" + $15 + ';}');
        }
      }
      // element border color
      if ($16) {
        if (style === "asutable") {
          cssProps.push("#" + $2 + " .jsavindex {border-color:" + $16 + ';}');
        } else if (style === "asumatrix") {
          // for matrix style, the borders are specified for the main element
          cssProps.push("#" + $2 + "{border-color:" + $16 + ';}');
        }
      }

      /*
      // element highlight color
      if ($8) { cssProps.push("#" + $2 + " .jsavvalue.jsavelemhighlight {color:" + $8 + 
                              ' !important;}'); }
      // cell highlight color
      if ($9) { cssProps.push("#" + $2 + " .jsavvalue.jsavcellhighlight {" +
                              "background-color:" + $9 + ' !important;}'); }*/
      // font definition
      if ($21) {
        cssProps.push("#" + $2 + " .jsavnode {" + $21 + "}");
      }
      // depth
      if (typeof $23 !== undefined) {
        cssProps.push(AsuHelpers.depthToCss($23, "#" + $2));
      }

      // alignment
      cssProps.push("#" + $2 + " .jsavvalue { text-align: " + $22 + ";}");

      // add the generated CSS to the DOM
      asustyle.html(asustyle.html() + cssProps.join(""));

      // create initial data for the matrix
      var arr = [], arrays = [];
      arr.length = $5;
      for (i = 0; i < $4; i++) {
        arrays.push(arr.slice(0));
      }

      var opts = $.extend($3, $24);

      var m = jsav.ds.matrix(arrays, opts);
      m.id($2);
      m.element.addClass(style);
      m.layout();
      asuobjs[$2] = m;
    }
  ;
LinesDef
  : lines NAT
    { $$ = parseInt($2, 10); }
  ;
StyleDef
  : style plain
    { $$ = "asuplain"; }
  | style matrix
    { $$ = "asumatrix"; }
  | style table
    { $$ = "asutable"; }
  | style junctions
    { $$ = "asujunctions"; }
  | /* empty */
    { $$ = "asuplain"; }
  ;
CellWidthDef
  : cellWidth NAT
    { $$ = parseInt($2, 10); }
  | /* empty */
  ;
MaxCellWidthDef
  : maxCellWidth NAT
    { $$ = parseInt($2, 10); }
  | /* empty */
  ;
CellHeightDef
  : cellHeight NAT
    { $$ = parseInt($2, 10); }
  | /* empty */
  ;
MaxCellHeightDef
  : maxCellHeight NAT
    { $$ = parseInt($2, 10); }
  | /* empty */
  ;
FixedCellSizeDef
  : fixedCellSize
    { $$ = true; }
  | /* empty */
    { $$ = false; }
  ;
BorderColorDef
  : borderColor Color
    { $$ = $2; }
  | /* empty */
  ;
HighlightTextColorDef
  : highlightTextColor Color
    { $$ = $2; }
  | /* empty */
  ;
HighlightBackColorDef
  : highlightBackColor Color
    { $$ = $2; }
  | /* empty */
  ;
HighlightFillColorDef
  : highlightFillColor Color
    { $$ = $2; }
  | /* empty */
  ;
HighlightBorderColorDef
  : highlightBorderColor Color
    { $$ = $2; }
  | /* empty */
  ;
AlignDef
  : align GridAlignKw
    { $$ = $2; }
  | /* empty */
    { $$ = "center"; }
  ;
GridAlignKw
  : left
    { $$ = "left"; }
  | right
    { $$ = "right"; }
  | center
    { $$ = "center"; }
  ;

GridOps
  : SetGridValue
  | SetGridColor
  {
    console.error("Grid operations not yet supported");
  }
  | SetGridFont
  {
    console.error("Grid operations not yet supported");
  }
  | SwapGridValues
  | HighlightGridCell
  | HighlightGridElem
  | AlignGridValue
  ;

SetGridValue
  : setGridValue String String RefreshDef Timing
    {
      // cell will contain [GridId, row, column]
      var cell = AsuHelpers.parseGridCellIdentifier($2),
          grid = asuobjs[cell[0]],
          row = cell[1],
          column = cell[2]
          i, j,
          newValue = $3,
          opts = $5;
      if (row >= grid._arrays.length ||
          column >= grid._arrays[0].size()) {
        console.error("Invalid cell (" + row + ",", column +
                      ") for setGridValue");
        return;
      }
      if (typeof row === "number" && typeof column === "number") {
        // setting value for a single cell
        grid.value(row, column, newValue, opts);
      } else if (typeof row === "number") { // complete row
        for (i = grid._arrays[0].size(); i--; ) {
          grid.value(row, i, newValue, opts);
        }
      } else if (typeof column === "number") { // complete column
        for (i = grid._arrays.length; i--; ) {
          grid.value(i, column, newValue, opts);
        }
      } else { // whole grid
        for (i = grid._arrays.length; i--; ) {
          for (j = grid._arrays.length; j--; ) {
            grid.value(i, j, newValue, opts);
          }
        }
      }
      // if refresh, recalculate the layout
      if ($4) { grid.layout(); }
    }
  ;
RefreshDef
  : refresh
    { $$ = true; }
  | /* empty */
  ;
SetGridColor
  : setGridColor String ColorDef TextColorDef FillColorDef BorderColorDef HighlightTextColorDef HighlightFillColorDef HighlightBorderColorDef Timing
  ;
SwapGridValues
  : swapGridValues String and String RefreshDef Timing
    {
      var ind1 = AsuHelpers.gridCellIdentifierToIndices($2, asuobjs),
          ind2 = AsuHelpers.gridCellIdentifierToIndices($4, asuobjs),
          grid1 = asuobjs[AsuHelpers.parseGridCellIdentifier($2)[0]],
          grid2 = asuobjs[AsuHelpers.parseGridCellIdentifier($4)[0]],
          i, cell1, cell2;
      if (ind1.length !== ind2.length) {
        console.error("Mismatch in size of grid values to swap");
      }
      for (i = ind1.length; i-- ;) {
        cell1 = ind1[i];
        cell2 = ind2[i];
        jsav.effects.swapValues(grid1._arrays[cell1[0]], cell1[1],
                                grid2._arrays[cell2[0]], cell2[1]);
      }
    }
  ;
HighlightGridCell
  : GridCellHlKeyword String Timing
    {
      var ind = AsuHelpers.parseGridCellIdentifier($2),
          grid = asuobjs[ind[0]],
          func = $1,
          row = ind[1],
          column = ind[2],
          opts = $3;
      AsuHelpers.callGridFunction(grid, func, row, column, "asugridcellhighlight", opts);
    }
  ;
GridCellHlKeyword
  : highlightGridCell
    { $$ = "addClass"; }
  | unhighlightGridCell
    { $$ = "removeClass"; }
  ;
HighlightGridElem
  : GridElemHlKeyword String Timing
    {
      var ind = AsuHelpers.parseGridCellIdentifier($2),
          grid = asuobjs[ind[0]],
          func = $1,
          row = ind[1],
          column = ind[2],
          opts = $3;
      AsuHelpers.callGridFunction(grid, func, row, column, "asugridelemhighlight", opts);
    }
  ;
GridElemHlKeyword
  : highlightGridElem
    { $$ = "addClass"; }
  | unhighlightGridElem
    { $$ = "removeClass"; }
  ;
AlignGridValue
  : alignGridValue String GridAlignKw Timing
    {
      var ind = AsuHelpers.parseGridCellIdentifier($2),
          grid = asuobjs[ind[0]],
          row = ind[1],
          column = ind[2],
          opts = $.extend({}, $4),
          funcName = "css",
          align = {"text-align": $3};
      opts.duration = 0;
      AsuHelpers.callGridFunction(grid, funcName, row, column, align, opts);
    }
  ;

VariableOps
  : VariableSet
  | VariableDiscard
  ;
VariableDeclaration
  : declare String InitValueDef RoleDef
  | declare UnquotedString InitValueDef RoleDef
  ;
InitValueDef
  : initValue String
  | /* empty */
  ;
RoleDef
  : role String
  | /* empty */
  ;
VariableSet
  : update String ToOrInitValue String RoleDef
  | update UnquotedString ToOrInitValue String RoleDef
  ;
ToOrInitValue
  : to
  | initValue
  ;
VariableDiscard
  : discard String
  ;

EmbedFile
  : embed String
    { console.error("embed commands should be handled before parsing!"); }
  ;

Eof
  : EOF
    {
      // cleanup some of the objects we've created
      asuobjs = null;
      asugroups = null;
    }
  ;