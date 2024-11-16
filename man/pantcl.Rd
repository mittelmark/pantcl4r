\name{pantcl} 
\alias{pantcl} 
\alias{pantcl4r} 
\title{ perform literate programming } 
\description{ 
    A function which calls the pantcl application inside of a R package. 
} 
\usage{ pantcl(infile, outfile=NULL, css=NULL,quiet=FALSE, mathjax=FALSE,...) } 
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
    should the MathJax Javascript library be loaded, default: FALSE 
  } 
  \item{\ldots}{kept for compatibility with pandoc, not used currently } 
} 
\details{ 
    Some more details ... 
} 
\examples{ 
  print("pantcl running") 
  cat("## Title\n\nHello World!\n\n\\\\[ E = mc^2 \\\\]\n\n```{r eval=TRUE}\nprint('Hello World!')\n```\n",file="hello.Rmd") 
  pantcl("hello.Rmd","hello.html",mathjax=TRUE) 
} 
