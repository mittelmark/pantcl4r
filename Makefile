VERSION := 0.1
PKG     := $(shell basename `pwd`)
build:
	R CMD build .

check: build man/pantcl.Rd
	R CMD check $(PKG)_$(VERSION).tar.gz
install:
	R CMD INSTALL $(PKG)_$(VERSION).tar.gz
	
man/%.Rd: R/%.R
	Rscript bin/rman.R $<
vignette:
	echo "library(pantcl4R);pantcl('vignettes/tutorial.Rmd','inst/doc/tutorial.html')" | Rscript -
