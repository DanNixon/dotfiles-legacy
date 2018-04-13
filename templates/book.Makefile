PANDOC=pandoc

SOURCES=$(wildcard *.md)
PDFS=$(SOURCES:.md=.pdf)

%.pdf: %.md
	$(PANDOC) $< -o $@

all: $(PDFS)

clean:
	rm $(PDFS)
