\name{lipsum} 
\alias{lipsum} 
\title{Create lipsum text to fill documents with text blocks} 
\description{ 
    This function allows you to fill simple Lorem lipsum text into your document 
    to start initial layout previews. 
} 
\usage{lipsum(type=1, paragraphs=1,lang="latin") } 
\arguments{ 
   \item{type}{the lipsum block, either 1 (Lorem lipsum ...) or 2 (Sed ut perspiciatis ...), default: 1} 
   \item{paragraphs}{integer, how many paragraphs, default: 1} 
   \item{lang}{either 'latin' or 'english', the latter is not yet implemented, default: 'latin'} 
} 
\examples{ 
cat(lipsum(1,paragraphs=2)) 
} 
