\name{ptangle} 
\alias{ptangle} 
\title{ extract code chunk code } 
\description{ 
    A function which extracts code chunks from Markdown documents. 
} 
\usage{ ptangle(infile, outfile=NULL, type="r",quiet=FALSE,...) } 
\arguments{ 
  \item{infile}{ 
    an infile with Markdown code and embedded Programming language code 
  } 
  \item{outfile}{ 
    a script outfile, if not given the Markdown extension is simply exchanged by the type, default: NULL 
  } 
  \item{type}{ 
    an optional chunk type to be extractted, default: "r" 
  } 
  \item{quiet}{ 
    should messages been hidden, default: FALSE 
  } 
  \item{\ldots}{kept for compatibility with pandoc, not used currently} 
} 
\details{ 
    Some more details ... 
} 
\examples{ 
  print("pantcl::ptangle running") 
  cat("## Title\n\nHello World!\n\n```{r eval=TRUE}\nprint('Hello World!')\n```\n",file="hello.Rmd") 
  ptangle("hello.Rmd","hello.R") 
} 
