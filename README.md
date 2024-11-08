# pantcl4r

[![Release](https://img.shields.io/github/v/release/mittelmark/pantcl4r.svg?label=current+release)](https://github.com/mittelmark/microemacs/releases)
[![license](https://img.shields.io/badge/license-MIT-lightgray.svg)](https://opensource.org/license/mit)
![Build](https://github.com/mittelmark/pantcl4r/workflows/Makefile%20Package/badge.svg)

A R package for literate programming.

This package can be used to create reports and manuscripts with embedded
programming code where the code can be evaluated by the script language or a
diagram, charting or diagramming tool and the output will  be embedded in the final manuscript.

This is a small scale alternative to Sweave, Rmarkdown, Knitr etc. It is
essentially a wrapper for the [pantcl](https://github.com/mittelmark/pantcl) application
which does not need an installed version of pandoc or any other R package.

It allows currently the embedding for the following programming languages and tools:

- [filter-abc](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-abc.html) - visualize [ABC music notation](https://abcnotation.com/)
- [filter-cmd](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-cmd.html) - execute shell scripts for instance [Lilypond music scripts](http://lilypond.org/), [GraphViz](https://www.graphviz.org) scripts, Python, Lua, R scripts, [sqlite3](https://www.sqlite.org) scripts, or code for languages like  C, C++, Go, Rust, V  etc.
- [filter-dot](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-dot.html) - [GraphViz dot](https://www.graphviz.org) filter
- [filter-emf](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-emf.html) - [Jasspa MicroEmacs macros](http://www.jasspa.com) filter
- [filter-eqn](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-eqn.html) - visualize mathematical equations using eqn2graph, see here [Guide for typesetting using eqn](https://lists.gnu.org/archive/html/groff/2013-10/pdfTyBN2VWR1c.pdf)
- [filter-julia](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-julia.html) - statistical language Julia (slow for embedding, use R instead) [Julia Website](https://julialang.org/)
- [filter-kroki](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-kroki.html) - visualize diagram code using the [kroki webservice](https://kroki.io)
- [filter-mmd](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-mmd.html) - visualize diagram code using the [mermaid command line tool](https://github.com/mermaidjs/mermaid.cli)
- [filter-mtex](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-mtex.html) - visualize mathematical equations using LaTeX
- [filter-pic](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-pic.html) - visualize diagram and flowcharts using the [PIC language](https://en.wikipedia.org/wiki/PIC_(markup_language))
- [filter-pik](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-pik.html) - visualize diagram code or flowcharts uing [pikchr](https://fossil-scm.org/home/doc/trunk/www/pikchr.md) or [fossil](https://fossil-scm.org/home/doc/trunk/www/index.wiki)
- [filter-pipe](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-pipe.html) - embed R, Python or Octave code or plots into Markdown
- [filter-puml](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-puml.html) - embed [PlantUML](http://www.plantuml.com) code
- [filter-rplot](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-rplot.html) - embed R plots
- [filter-sqlite](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-sqlite.html) - embed [Sqlite3 SQL database](https://www.sqlite.org) statements
- [filter-tcl](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-tcl.html) - embed Tcl statements
- [filter-tcrd](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-tcrd.html) - embed Tcl music chords.
- [filter-tdot](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-tdot.html) - embed Tcl GraphViz diaragrams
- [filter-tsvg](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/pantcl/master/lib/tclfilters/filter-tsvg.html) - embed Tcl created SVG code

## Commands

There are essentially three commands:

* `pantcl` - converting Rmarkdown documents with embedded code to HTML
* `ptangle` - extract programming code into script files from  the Markdown document
* `pangui` - simple graphical  interface to edit abc music, Graphviz dot, Eqn equations,  Mermaid diagrams,  Pikchr and Pic code, Plantuml code, R-plots and Tcl-svg or Tcl-dot code

Below you see an image of the graphical  tool:

![](https://user-images.githubusercontent.com/75636/266270712-d6810a37-e50e-4105-833f-96467ea4d552.png)

## Install and Use

To install the latest release for R you can use the following commands from within a
R console:

```
install.packages(
    "https://github.com/mittelmark/pantcl4r/releases/download/v0.3.1/pantcl4r_0.3.1.tar.gz",
    repos=NULL);
```

Thereafter you should check the package vignette:

```
library(pantcl4r)
vignette("tutorial",package="pantcl4r")
```

To  process  a  Markdown file for  example,  with  embedded  R code,  you  can do the
following:

```
pantcl4r::pantcl("input.Rmd","output.html")
```

Which will  create a file  _output.html_  where the R code chunks or chunks of
the other languages within _input.html_ are evaluated and the results embedded
into the output file if requested.


To install the latest development library you need the library 'remotes'.

```
library(remotes)
remotes::install_github("https://github.com/mittelmark/pantcl4r")
```

## Author and Copyright

Author: Detlef Groth, University of Potsdam, Germany

License: MIT License see the file [LICENSE](LICENSE) for details.

## Bug reporting

In case of bugs and suggestions, use the [issues](https://github.com/mittelmark/pantcl4r/issues) link on top.
