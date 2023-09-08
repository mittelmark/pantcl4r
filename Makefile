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
github-mac-install:
	brew install xquartz
	brew install graphviz
	brew install plantuml
	#brew install R
github-mac-run:	
	wget https://github.com/mittelmark/pantcl4r/files/12549351/pantcl4r_0.2.0.tar.gz
	R CMD INSTALL pantcl4r_0.2.0.tar.gz
	rm pantcl4r_0.2.0.tar.gz
	Rscript -e "install.packages(c(\"remotes\", \"rcmdcheck\",\"tcltk\"));"
	Rscript -e "remotes::install_deps(dependencies = TRUE);"
	Rscript -e "tools:::.build_packages('.');"
	Rscript -e "rcmdcheck::rcmdcheck(args = '--no-manual', error_on = 'error');"
	Rscript -e "install.packages('$(PKG)_$(VERSION).tar.gz',repos=NULL);"
	# export DISPLAY=:99.0
