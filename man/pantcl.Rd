\name{pantcl} 
\alias{pantcl} 
\alias{pantcl4r} 
\title{ perform literate programming } 
\description{ 
    Convert Markdown documents with R, Python, Octave or Digram code to HTML output. 
} 
\usage{ pantcl(infile, outfile=NULL, css=NULL, quiet=FALSE, mathjax=NULL, javascript=NULL, refresh=NULL, inline=NULL, ...) } 
\arguments{ 
  \item{infile}{ 
    an infile with Markdown code and embedded Programming language code 
  } 
  \item{outfile}{ 
    an HTML outfile, if not given the Markdown extension is simply exchanged by html, default: NULL 
  } 
  \item{css}{ 
    an optional css fileHTML outfile, default: NULL 
  } 
  \item{quiet}{ 
    should messages been hidden, default: FALSE 
  } 
  \item{mathjax}{ 
    should the MathJax Javascript library be loaded, default: NULL 
  } 
  \item{javascript}{ 
    should javascript libraries or files being included, implemented is currently only the  
    the library highlighjs, default: NULL 
  } 
  \item{refresh}{ 
    should the HTML be refreshed every N seconds, values lower than 10 means no refreshment, default: NULL 
  } 
  \item{inline}{ 
    should images and css files beeing inlined into the final HTML document to make it standalone,  
    if not given or called with inline=TRUE,they are inlined, default: NULL 
  } 
  \item{\ldots}{kept for compatibility with pandoc, not used currently } 
} 
\details{ 
  This function allows you to perform literate programming where you embed R, Python, Octave or Tcl code 
  into your Markdown documents and convert them later to HTML output. Beside of programming languages as  
  well embedding shell programs, or diagram code for GraphViz pr PlantUML can be embedded if the appropiate 
  tools are available. For a list of available tools which can be used see \url{https://github.com/mittelmark/pantcl}. 
 
  The package can be seen as a lightweight alternative to the rmarkdown or knitr packages. In contrast to them you have  
  embed plots using the \code{png} and the \code{dev.off} commands within your Rmd document and then you use Markdown image syntax 
  after the code block to embed the image.  
 
  If the PNG image is created but not embedded within your file, try to convert the document first 
  to a Markdown document and then call the pantcl command again converting the Markdown to HTML with 
  a second call like this: 
   
      \code{pantcl('input.Rmd','output.md'); pantcl('output.md','output.html')} 
} 
\examples{ 
  print("pantcl running") 
  ## equation and R example: 
  md="## Title\n\nHello World!\n\n\\\\[ E = mc^2 \\\\]\n\n```{r eval=TRUE}\nprint('Hello World!')\n```\n" 
  ## Tcl example 
  md = paste(md, "\n```{.tcl eval=TRUE}\nset x 1\nputs $x\n\n") 
  ## Kroki Diagram example 
  md = paste(md, "\n```{.kroki eval=TRUE,dia=\"graphviz\"}\ndigraph g { A -> B }\n```\n") 
  cat(md,file="hello.Rmd") 
  pantcl("hello.Rmd","hello.html",mathjax=TRUE,refresh=10,javascript="highlightjs") 
  file.remove("hello.Rmd") 
  file.remove("hello.html") 
} 
