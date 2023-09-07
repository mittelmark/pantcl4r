VERSION := $(shell grep Version: DESCRIPTION | perl -pe 's/.+: //')
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
	echo "library(pantcl4r);pantcl('vignettes/tutorial.Rmd','vignettes/tutorial.html')" | Rscript -
	cp vignettes/tutorial.html inst/doc/tutorial.html
	echo "library(pantcl4r);pantcl('vignettes/python.Rmd','vignettes/python.html')" | Rscript -
	cp vignettes/python.html inst/doc/python.html
