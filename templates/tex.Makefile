TEX_COMPILER=xelatex

DOCUMENT_SOURCE=$(wildcard *.tex)

all:
	$(TEX_COMPILER) $(DOCUMENT_SOURCE)

clean:
	- rm *.pdf
	- rm *.log
	- rm *.aux
	- rm *.dvi
	- rm *.bbl
	- rm *.blg
	- rm *.bm
	- rm *.out
	- rm *.nav
	- rm *.snm
	- rm *.toc
	- rm *.gls
	- rm *.glg
	- rm *.glo
	- rm *.ilg
	- rm *.ind
	- rm *.ist
