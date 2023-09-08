\name{df2md} 
\alias{df2md} 
\title{Convert matrices or data frames into Markdown tables} 
\description{ 
    Utility function to be used within Markdown documents to convert 
    data frames or matrices into Markdown tables. 
} 
\usage{df2md(df,caption="",rownames=TRUE) } 
\arguments{ 
  \item{df}{ data frame or matrix} 
  \item{caption}{table caption, shown below of the table, default: ""} 
  \item{rownames}{should rownames been show, default:TRUE} 
} 
\details{ 
    Some more details ... 
} 
\examples{ 
df2md(head(iris),caption="iris data") 
} 
