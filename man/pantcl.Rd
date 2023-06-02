\name{pantcl} 
\alias{pantcl} 
\title{ perform literate programming } 
\description{ 
    A function which calls the pantcl application inside of a R package. 
} 
\usage{ pantcl(infile, outfile=NULL, css=NULL,quiet=FALSE) } 
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
} 
\details{ 
    Some more details ... 
} 
\examples{ 
  print("pantcl running") 
  cat("## Title\n\nHello World!\n\n```{r eval=TRUE}\nprint('Hello World!')\n```\n",file="hello.Rmd") 
  pantcl("hello.Rmd","hello.html") 
} 
