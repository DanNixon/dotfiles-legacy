# Note that DXF conversion requires use of a dialog box (i.e. cannot be built
# automatically), also conversion is not exact.

OUTPUT_DIR=out
DOCUMENTS=$(wildcard *.tex)
PDFS=$(addprefix $(OUTPUT_DIR)/,$(DOCUMENTS:.tex=.pdf))

LATEXMK=latexmk
TEXCOUNT=texcount
TEX_OPTIONS=-pdf -shell-escape -halt-on-error

GRAPHICS_DIR=graphics
METAPOST=mpost
INKSCAPE=inkscape
GRAPHVIZ=dot

MP_GRAPHICS=$(wildcard $(GRAPHICS_DIR)/*.mp)
MP_GRAPHICS_1=$(subst $(GRAPHICS_DIR),$(OUTPUT_DIR),$(MP_GRAPHICS:.mp=.1))
SVG_GRAPHICS=$(wildcard $(GRAPHICS_DIR)/*.svg)
SVG_GRAPHICS_EPS=$(subst $(GRAPHICS_DIR),$(OUTPUT_DIR),$(SVG_GRAPHICS:.svg=.eps))
DXF_GRAPHICS=$(wildcard $(GRAPHICS_DIR)/*.dxf)
DXF_GRAPHICS_EPS=$(subst $(GRAPHICS_DIR),$(OUTPUT_DIR),$(DXF_GRAPHICS:.dxf=.eps))
DOT_GRAPHICS=$(wildcard $(GRAPHICS_DIR)/*.dot)
DOT_GRAPHICS_EPS=$(subst $(GRAPHICS_DIR),$(OUTPUT_DIR),$(DOT_GRAPHICS:.dot=.eps))

all: out_dir mp_graphics svg_graphics dxf_graphics dot_graphics $(PDFS)

out_dir:
	mkdir -p $(OUTPUT_DIR)

clean:
	rm -rf $(OUTPUT_DIR)

$(OUTPUT_DIR)/%.pdf: %.tex
	$(LATEXMK) $(TEX_OPTIONS) -jobname=$(subst .pdf,,$@) $<
	@echo ===== WORD COUNT
	$(TEXCOUNT) $<

mp_graphics: out_dir $(MP_GRAPHICS_1)

$(OUTPUT_DIR)/%.1: $(GRAPHICS_DIR)/%.mp
	$(METAPOST) --jobname $(subst .1,,$@) $<
	mv $(subst .1,*,$(subst $(OUTPUT_DIR)/,,$@)) $(OUTPUT_DIR)

svg_graphics: out_dir $(SVG_GRAPHICS_EPS)

dxf_graphics: out_dir $(DXF_GRAPHICS_EPS)

dot_graphics: out_dir $(DOT_GRAPHICS_EPS)

$(OUTPUT_DIR)/%.eps: $(GRAPHICS_DIR)/%.dot
	$(GRAPHVIZ) -T eps -o $@ $<

$(OUTPUT_DIR)/%.eps: $(GRAPHICS_DIR)/%.*
	$(INKSCAPE) --file $< --export-eps=$@

watch: all
	when-changed *.tex *.bib -c make
