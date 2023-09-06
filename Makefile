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
	echo "library(pantcl4R);pantcl('vignettes/tutorial.Rmd','vignettes/tutorial.html')" | Rscript -
	htmlark vignettes/tutorial.html -o inst/doc/tutorial.html
