RM = rm -rf
LIB = lib
MINIMIZE = java -jar tools/yuicompressor-2.4.6.jar --nomunge --preserve-semi -o $(TARGET)/JSAV-min.js  $(TARGET)/JSAV.js 
CAT = cat
SRC = src
TARGET = build

SOURCES = $(SRC)/asu-helpers.js $(SRC)/jsav-asu-import-header.js $(TARGET)/asu.js $(SRC)/jsav-asu-import-footer.js

all: build

clean:
	$(RM) *~
	$(RM) build/*

build: $(TARGET)/asu.js $(TARGET)/jsav-asu-import.js

$(TARGET)/asu.js: $(SRC)/asu.jison
	-mkdir $(TARGET)
	jison $(SRC)/asu.jison -o $(TARGET)/asu.js

$(TARGET)/jsav-asu-import.js: $(SOURCES)
	$(CAT) $(SOURCES) > $(TARGET)/jsav-asu-import.js
	rm $(TARGET)/asu.js
