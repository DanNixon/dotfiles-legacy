PARTS_DIR = parts
DXF_DIR = dxf

ALL_PARTS = $(wildcard $(PARTS_DIR)/*.scad)
ALL_PARTS_DXF = $(subst parts,dxf,$(ALL_PARTS:.scad=.dxf))

all: $(ALL_PARTS_DXF)

clean:
	rm -rf $(DXF_DIR)

output_folder:
	mkdir -p $(DXF_DIR)

$(DXF_DIR)/%.dxf: output_folder $(PARTS_DIR)/%.scad
	openscad $(word 2,$^) -o $@
