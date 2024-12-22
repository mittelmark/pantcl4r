#' \name{pantcl}
#' \alias{pantcl}
#' \alias{pantcl4r}
#' \title{ perform literate programming }
#' \description{
#'     Convert Markdown documents with R, Python, Octave or Digram code to HTML output.
#' }
#' \usage{ pantcl(infile, outfile=NULL, css=NULL, quiet=FALSE, mathjax=NULL, javascript=NULL, refresh=NULL, inline=NULL, ...) }
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
#'   \item{mathjax}{
#'     should the MathJax Javascript library be loaded, default: NULL
#'   }
#'   \item{javascript}{
#'     should javascript libraries or files being included, implemented is currently only the 
#'     the library highlighjs, default: NULL
#'   }
#'   \item{refresh}{
#'     should the HTML be refreshed every N seconds, values lower than 10 means no refreshment, default: NULL
#'   }
#'   \item{inline}{
#'     should images and css files beeing inlined into the final HTML document to make it standalone, 
#'     if not given or called with inline=TRUE,they are inlined, default: NULL
#'   }
#'   \item{\ldots}{kept for compatibility with pandoc, not used currently }
#' }
#' \details{
#'   This function allows you to perform literate programming where you embed R, Python, Octave or Tcl code
#'   into your Markdown documents and convert them later to HTML output. Beside of programming languages as 
#'   well embedding shell programs, or diagram code for GraphViz pr PlantUML can be embedded if the appropiate
#'   tools are available. For a list of available tools which can be used see \url{https://github.com/mittelmark/pantcl}.
#'
#'   The package can be seen as a lighweight alternative to the rmarkdown or knitr packages. In contrast to them you have 
#'   embed plots using the \code{png} and the \code{dev.off} commands within your Rmd document and the use Markdown image syntax
#'   to embed the link. 
#' 
#'   If the PNG image is created but not embedded within your file, try to convert the document first
#'   to a Markdown document and then call the pantcl command again converting the Markdown to HTML with a second call like this:
#'   \code{pantcl('input.Rmd','output.md'); pantcl('output.md','output.html')}
#' }
#' \examples{
#'   print("pantcl running")
#'   ## equation and R example:
#'   md="## Title\n\nHello World!\n\n\\\\[ E = mc^2 \\\\]\n\n```{r eval=TRUE}\nprint('Hello World!')\n```\n"
#'   ## Tcl example
#'   md = paste(md, "\n```{.tcl eval=TRUE}\nset x 1\nputs $x\n\n")
#'   ## Kroki Diagram example
#'   md = paste(md, "\n```{.kroki eval=TRUE,dia=\"graphviz\"}\ndigraph g { A -> B }\n```\n")
#'   cat(md,file="hello.Rmd")
#'   pantcl("hello.Rmd","hello.html",mathjax=TRUE,refresh=10,javascript="highlightjs")
#'   file.remove("hello.Rmd")
#'   file.remove("hello.html")
#' }

pantcl <- function (infile, outfile=NULL, css=NULL, quiet=FALSE, mathjax=NULL, javascript=NULL, refresh=NULL, inline=NULL,...) {
    stopifnot(file.exists(infile))
    if (is.null(outfile)) {
        outfile=gsub("\\..md$",".html",infile)
    }
    if (is.null(mathjax)) {
        mjx=""
    } else {
        mjx="--mathjax true"
    }
    if (is.null(javascript)) {
        jsc=""
    } else {
        if (javascript != "highlightjs") {
            stop("Error: Currently only highlightjs as value for --javascript is supported!")
        }
        jsc=paste("--javascript",javascript)
    }
    if (is.null(css)) {
        css=""
    } else {
        css=paste("--css",css)
    }
    if (is.null(refresh)) {
        refresh=""
    } else {
        refresh=paste("--refresh",refresh)
    }
    if (is.null(inline)) {
        inline=""
    } else if (inline) {
        inline="--base64 true"
    } else {
        inline="--base64 false"
    }
    cmdline = paste("set ::argv [list",infile, outfile,css,"--no-pandoc",mjx,jsc,refresh,inline,"]")        

    tcltk::.Tcl("set ::quiet true")
    tcltk::.Tcl(paste(paste("cd",getwd())))
    tcltk::.Tcl("if {[info commands ::exitorig] eq {}} {  rename ::exit ::exitorig ; }; proc ::exit {args} { return }")
    tcltk::.Tcl(cmdline)
    tcltk::.Tcl(paste("source",file.path(system.file(package="pantcl4r"),"pantcl", "pantcl.tcl")))
    if (!quiet) {
        message(paste("Processing",infile,"to",outfile,"done!"))
    }
}

pantcl4r <- pantcl

#' \name{ptangle}
#' \alias{ptangle}
#' \title{ extract code chunk code }
#' \description{
#'     A function which extracts code chunks from Markdown documents.
#' }
#' \usage{ ptangle(infile, outfile=NULL, type="r",quiet=FALSE,...) }
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
#'   \item{\ldots}{kept for compatibility with pandoc, not used currently}
#' }
#' \details{
#'     Some more details ...
#' }
#' \examples{
#'   print("pantcl::ptangle running")
#'   cat("## Title\n\nHello World!\n\n```{r eval=TRUE}\nprint('Hello World!')\n```\n",file="hello.Rmd")
#'   ptangle("hello.Rmd","hello.R")
#'   file.remove("hello.Rmd")
#'   file.remove("hello.R")
#' }


ptangle <- function(infile, outfile=NULL,type="r",quiet=FALSE,...) {
    stopifnot(file.exists(infile))
    if (is.null(outfile)) {
        outfile=gsub("\\..md",paste(".",type,sep=""),infile)
        outfile=gsub(".r$",".R$",outfile)
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

#' \name{df2md}
#' \alias{df2md}
#' \title{Convert matrices or data frames into Markdown tables}
#' \description{
#'     Utility function to be used within Markdown documents to convert
#'     data frames or matrices into Markdown tables.
#' }
#' \usage{df2md(df,caption="",rownames=TRUE) }
#' \arguments{
#'   \item{df}{ data frame or matrix}
#'   \item{caption}{table caption, shown below of the table, default: ""}
#'   \item{rownames}{should rownames been show, default:TRUE}
#' }
#' \details{
#'     Some more details ...
#' }
#' \examples{
#' df2md(head(iris),caption="iris data")
#' }


df2md <- function(df,caption="",rownames=TRUE) {
    cn <- colnames(df)
    if (is.null(cn[1])) {
        cn=as.character(1:ncol(df))
    }
    rn <- rownames(df)
    if (is.null(rn[1])) {
        rn=as.character(1:nrow(df))
    }
    if (rownames) {
        headr <- paste0(c("","", cn),  sep = "|", collapse='')
        sepr <- paste0(c('|', rep(paste0(c(rep('-',3), "|"), 
                                         collapse=''),length(cn)+1)), collapse ='')
    } else {
        headr <- paste0(c("", cn),  sep = "|", collapse='')
        sepr <- paste0(c('|', rep(paste0(c(rep('-',3), "|"), 
                                         collapse=''),length(cn))), collapse ='')
        
    }
    st <- "|"
    for (i in 1:nrow(df)){
        if (rownames) {
            st <- paste0(st, "**",as.character(rn[i]), "**|", collapse='')
        }
        for(j in 1:ncol(df)){
            if (j%%ncol(df) == 0) {
                st <- paste0(st, as.character(df[i,j]), "|", 
                             "\n", "" , "|", collapse = '')
            } else {
                st <- paste0(st, as.character(df[i,j]), "|", 
                             collapse = '')
            }
        }
    }
    fin <- paste0(c("\n \n ",headr, sepr, substr(st,1,nchar(st)-1)), collapse="\n")
    if (caption!='') {
        fin=paste0(fin,'\n',caption,'\n')
    }
    cat(fin)
}

#' \name{lipsum}
#' \alias{lipsum}
#' \title{Create lipsum text to fill documents with text blocks}
#' \description{
#'     This function allows you to fill simple Lorem lipsum text into your document
#'     to start initial layout previews.
#' }
#' \usage{lipsum(type=1, paragraphs=1,lang="latin") }
#' \arguments{
#'    \item{type}{the lipsum block, either 1 (Lorem lipsum ...) or 2 (Sed ut perspiciatis ...), default: 1}
#'    \item{paragraphs}{integer, how many paragraphs, default: 1}
#'    \item{lang}{either 'latin' or 'english', the latter is not yet implemented, default: 'latin'}
#' }
#' \examples{
#' cat(lipsum(1,paragraphs=2))
#' }

lipsum <- function (type=1, paragraphs=1,lang="latin") {
   if (lang == "latin") {
       if (type == 1) {
           lips=paste(rep("Lorem ipsum dolor sit amet, consectetur adipiscing elit,
                          sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                          Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
                          nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
                          reprehenderit in voluptate velit esse cillum dolore eu fugiat
                          nulla pariatur. Excepteur sint occaecat cupidatat non proident,
                          sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n",paragraphs),collapse="\n")
       } else if (type == 2) {
           lips=paste(rep("Sed ut perspiciatis unde omnis iste natus error sit voluptatem
                          accusantium doloremque laudantium, totam rem aperiam, eaque ipsa
                          quae ab illo inventore veritatis et quasi architecto beatae vitae
                          dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas
                          sit aspernatur aut odit aut fugit, sed quia consequuntur magni
                          dolores eos qui ratione voluptatem sequi nesciunt. Neque porro
                          quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur,
                          adipisci velit, sed quia non numquam eius modi tempora incidunt
                          ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim
                          ad minima veniam, quis nostrum exercitationem ullam corporis
                          suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?
                          Quis autem vel eum iure reprehenderit qui in ea voluptate velit
                          esse quam nihil molestiae consequatur, vel illum qui dolorem eum
                          fugiat quo voluptas nulla pariatur?\n\n",paragraphs),collapse="\n")
       } else {
         stop("only type 1 and 2 are supported")
      } 
   } else {
      stop("Only latin supported currently")
   }
   lips=gsub("  +", " ",lips)
   return(lips)
}

.onLoad <- function(libname, pkgname) {
    # to show a startup message
    tcltk::.Tcl(paste("lappend auto_path",file.path(system.file(package="pantcl4r"),"pantcl", "lib")))
    tcltk::.Tcl("package require tclfilters")
    tools::vignetteEngine("pantcl4r",
                          package=pkgname,
                          weave = function (file, ...) { pantcl4r::pantcl(file,...) },
                          tangle=function (file, ...) { pantcl4r::ptangle(file,...) },
                          pattern="[.][PpTtRr]md$")
}


