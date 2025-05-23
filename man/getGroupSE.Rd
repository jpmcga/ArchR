% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GroupExport.R
\name{getGroupSE}
\alias{getGroupSE}
\title{Export Group Summarized Experiment}
\usage{
getGroupSE(
  ArchRProj = NULL,
  useMatrix = NULL,
  groupBy = "Sample",
  divideN = TRUE,
  scaleTo = NULL,
  threads = getArchRThreads(),
  verbose = TRUE,
  logFile = createLogFile("getGroupSE")
)
}
\arguments{
\item{ArchRProj}{An \code{ArchRProject} object.}

\item{useMatrix}{The name of the matrix in the ArrowFiles. See getAvailableMatrices to see options}

\item{groupBy}{The name of the column in \code{cellColData} to use for grouping cells together for summarizing.}

\item{divideN}{A boolean describing whether to divide by the number of cells.}

\item{scaleTo}{Depth normalize to this value if not NULL.}

\item{threads}{An integer specifying the number of threads for parallel.}

\item{verbose}{A boolean specifying to print messages during computation.}

\item{logFile}{The path to a file to be used for logging ArchR output.}
}
\description{
This function will group, summarize and export a summarized experiment for a assay in a ArchRProject.
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

# Get Group SE
se <- getGroupSE(proj, useMatrix = "PeakMatrix", groupBy = "Clusters")

}
