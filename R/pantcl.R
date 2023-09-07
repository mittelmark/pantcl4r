#' \name{pantcl}
#' \alias{pantcl}
#' \title{ perform literate programming }
#' \description{
#'     A function which calls the pantcl application inside of a R package.
#' }
#' \usage{ pantcl(infile, outfile=NULL, css=NULL,quiet=FALSE) }
#' \arguments{
#'   \item{infile}{
#'     an infile with Markdown code and embedded Programming language code
#'   }
#'   \item{outfile}{
#'     an HTML outfile, if not given the Markdown extension is simply exchanged by html, default: NULL
#'   }
#'   \item{css}{
#'     an optional css fileHTML outfile, default: NULL
#'   }
#'   \item{quiet}{
#'     should messages been hidden, default: FALSE
#'   }
#'   \item{encoding}{kept for compatibility with pandoc, not used currently, default: NULL }
#' }
#' \details{
#'     Some more details ...
#' }
#' \examples{
#'   print("pantcl running")
#'   cat("## Title\n\nHello World!\n\n```{r eval=TRUE}\nprint('Hello World!')\n```\n",file="hello.Rmd")
#'   pantcl("hello.Rmd","hello.html")
#' }

pantcl <- function (infile, outfile=NULL,css=NULL,quiet=FALSE,encoding=NULL) {
    stopifnot(file.exists(infile))
    if (is.null(outfile)) {
        outfile=gsub("\\..md",".html")
    }
    if (!is.null(css)) {
        cmdline = paste("set ::argv [list",infile, outfile,"--css",css,"--no-pandoc]")        
    } else {
        cmdline = paste("set ::argv [list",infile, outfile,"--no-pandoc --inline true]")
    }
    tcltk::.Tcl("set ::quiet true")
    tcltk::.Tcl("if {[info commands ::exitorig] eq {}} {  rename ::exit ::exitorig ; }; proc ::exit {args} { return }")
    tcltk::.Tcl(cmdline)
    tcltk::.Tcl(paste("source",file.path(system.file(package="pantcl4r"),"pantcl", "pantcl.tcl")))
    if (!quiet) {
        message(paste("Processing",infile,"to",outfile,"done!"))
    }
}

#' \name{ptangle}
#' \alias{ptangle}
#' \title{ extract code chunk code }
#' \description{
#'     A function which extracts code chunks from Markdown documents.
#' }
#' \usage{ ptangle(infile, outfile=NULL, type="r",quiet=FALSE) }
#' \arguments{
#'   \item{infile}{
#'     an infile with Markdown code and embedded Programming language code
#'   }
#'   \item{outfile}{
#'     a script outfile, if not given the Markdown extension is simply exchanged by the type, default: NULL
#'   }
#'   \item{type}{
#'     an optional chunk type to be extractted, default: "r"
#'   }
#'   \item{quiet}{
#'     should messages been hidden, default: FALSE
#'   }
#' }
#' \details{
#'     Some more details ...
#' }
#' \examples{
#'   print("pantcl::ptangle running")
#'   cat("## Title\n\nHello World!\n\n```{r eval=TRUE}\nprint('Hello World!')\n```\n",file="hello.Rmd")
#'   ptangle("hello.Rmd","hello.R")
#' }


ptangle <- function(infile, outfile=NULL,type="r",quiet=FALSE) {
    stopifnot(file.exists(infile))
    if (is.null(outfile)) {
        outfile=gsub("\\..md",paste(".",mode,sep=""))
    }
    tcltk::.Tcl("set ::quiet true")
    cmdline = paste("set ::argv [list",infile, outfile,"--tangle",type,"]")
    tcltk::.Tcl("if {[info commands ::exitorig] eq {}} {  rename ::exit ::exitorig ; }; proc ::exit {args} { return }")
    tcltk::.Tcl(cmdline)
    tcltk::.Tcl(paste("source",file.path(system.file(package="pantcl4r"),"pantcl", "pantcl.tcl")))
    if (!quiet) {
        message(paste("Extracting code from",infile,"to",outfile,"done!"))
    }
    invisible(outfile)
    #knitr::purl(file, encoding = encoding, quiet = quiet, ...)
}

#' \name{pangui}
#' \alias{pangui}
#' \title{ start a graphical user interface }
#' \description{
#'     A function which start a graphical  user interface to write graphical code chunks.
#' }
#' \usage{ pangui(infile=NULL,quiet=FALSE) }
#' \arguments{
#'   \item{infile}{
#'     an infile to be edited with  the graphical interface, default: NULL
#'   }
#'   \item{quiet}{
#'     should messages been hidden, default: FALSE
#'   }
#' }
#' \details{
#'     Some more details ...
#' }
#' \examples{
#' \dontrun{
#'   pangui()
#' }
#' }

pangui <- function(infile=NULL,quiet=FALSE) {
    
    if (!is.null(infile)) {
        stopifnot(file.exists(infile))
    }
    pan = tcltk::tclvalue(tcltk::.Tcl("info commands ::pantcl::*"))
    if (pan != "") {
        message("Eventually you must restart R to restart the interface?")
        tcltk::.Tcl("after 1000 [list wm deiconify .]")
        return()
    } else {
        tcltk::.Tcl("set ::quiet true")
        tcltk::.Tcl("set ::runGui true")    
        tcltk::.Tcl("set ::runninginR true")            
        if (!is.null(infile)) {
            cmdline = paste("set ::argv [list",infile,"--gui]")
        } else {
            cmdline = paste("set ::argv --gui")
        }
        tcltk::.Tcl("if {[info commands ::exitorig] eq {}} { rename ::exit ::exitorig ; }; proc ::exit {args} { wm withdraw . }")
    
        tcltk::.Tcl(cmdline)
        tcltk::.Tcl(paste("source",file.path(system.file(package="pantcl4r"),"pantcl", "pantcl.tcl")))
        tcltk::.Tcl("after 1000 [list wm deiconify .]")
        if (!quiet) {
            message(paste("Running graphical user interface .."))
        }
        return()
    }
}



.onLoad <- function(libname, pkgname) {
    # to show a startup message
    tcltk::.Tcl(paste("lappend auto_path",file.path(system.file(package="pantcl4r"),"pantcl", "lib")))
    tcltk::.Tcl("package require tclfilters")
    tools::vignetteEngine("pantcl",
                          package=pkgname,
                          weave=pantcl,
                          tangle=ptangle,pattern="[.][PpTtRr]md$")
}


