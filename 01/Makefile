# Makefile
GIT_ROOT := $(shell git rev-parse --show-toplevel)
export BIBINPUTS := $(GIT_ROOT):

FILENAME = fw01
FINALNAME = $(FILENAME)
BUILD_DIR = build

all: $(BUILD_DIR)/$(FILENAME).pdf

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/$(FILENAME).pdf: $(FILENAME).tex | $(BUILD_DIR)
	pdflatex -output-directory=$(BUILD_DIR) $(FILENAME).tex
	biber --input-directory=$(BUILD_DIR) $(BUILD_DIR)/$(FILENAME)
	pdflatex -output-directory=$(BUILD_DIR) $(FILENAME).tex
	pdflatex -output-directory=$(BUILD_DIR) $(FILENAME).tex
	mv build/$(FILENAME).pdf $(FINALNAME).pdf

clean:
	rm -rf build

show:
	mupdf $(FINALNAME).pdf
