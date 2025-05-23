% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ReproduciblePeakSet.R
\name{addReproduciblePeakSet}
\alias{addReproduciblePeakSet}
\title{Add a Reproducible Peak Set to an ArchRProject}
\usage{
addReproduciblePeakSet(
  ArchRProj = NULL,
  groupBy = "Clusters",
  peakMethod = "Macs2",
  reproducibility = "2",
  peaksPerCell = 500,
  maxPeaks = 150000,
  minCells = 25,
  excludeChr = c("chrM", "chrY"),
  pathToMacs2 = if (tolower(peakMethod) == "macs2") findMacs2() else NULL,
  genomeSize = NULL,
  shift = -75,
  extsize = 150,
  method = if (tolower(peakMethod) == "macs2") "q" else "p",
  cutOff = 0.1,
  additionalParams = "--nomodel --nolambda",
  extendSummits = 250,
  promoterRegion = c(2000, 100),
  genomeAnnotation = getGenomeAnnotation(ArchRProj),
  geneAnnotation = getGeneAnnotation(ArchRProj),
  plot = TRUE,
  threads = getArchRThreads(),
  parallelParam = NULL,
  force = FALSE,
  verbose = TRUE,
  logFile = createLogFile("addReproduciblePeakSet"),
  ...
)
}
\arguments{
\item{ArchRProj}{An \code{ArchRProject} object.}

\item{groupBy}{The name of the column in \code{cellColData} to use for grouping cells together for peak calling.}

\item{peakMethod}{The name of peak calling method to be used. Options include "Macs2" for using macs2 callpeak or "Tiles" for using a TileMatrix.}

\item{reproducibility}{A string that indicates how peak reproducibility should be handled. This string is dynamic and can be a
function of \code{n} where \code{n} is the number of samples being assessed. For example, \code{reproducibility = "2"} means at least 2 samples
must have a peak call at this locus and \code{reproducibility = "(n+1)/2"} means that the majority of samples must have a peak call at this locus.}

\item{peaksPerCell}{The upper limit of the number of peaks that can be identified per cell-grouping in \code{groupBy}. This is useful
for controlling how many peaks can be called from cell groups with low cell numbers.}

\item{maxPeaks}{A numeric threshold for the maximum peaks to retain per group from \code{groupBy} in the union reproducible peak set.}

\item{minCells}{The minimum allowable number of unique cells that was used to create the coverage files on which peaks are called.
This is important to allow for exclusion of pseudo-bulk replicates derived from very low cell numbers.}

\item{excludeChr}{A character vector containing the \code{seqnames} of the chromosomes that should be excluded from peak calling.}

\item{pathToMacs2}{The full path to the MACS2 executable.}

\item{genomeSize}{The genome size to be used for MACS2 peak calling (see MACS2 documentation). This is required if genome is not hg19, hg38, mm9, or mm10.}

\item{shift}{The number of basepairs to shift each Tn5 insertion. When combined with \code{extsize} this allows you to create proper fragments,
centered at the Tn5 insertion site, for use with MACS2 (see MACS2 documentation).}

\item{extsize}{The number of basepairs to extend the MACS2 fragment after \code{shift} has been applied. When combined with \code{extsize} this
allows you to create proper fragments, centered at the Tn5 insertion site, for use with MACS2 (see MACS2 documentation).}

\item{method}{The method to use for significance testing in MACS2. Options are "p" for p-value and "q" for q-value. When combined with
\code{cutOff} this gives the method and significance threshold for peak calling (see MACS2 documentation).}

\item{cutOff}{The numeric significance cutOff for the testing method indicated by \code{method} (see MACS2 documentation).}

\item{additionalParams}{A string of additional parameters to pass to MACS2 (see MACS2 documentation).}

\item{extendSummits}{The number of basepairs to extend peak summits (in both directions) to obtain final fixed-width peaks. For example,
\code{extendSummits = 250} will create 501-bp fixed-width peaks from the 1-bp summits.}

\item{promoterRegion}{A vector of two integers specifying the distance in basepairs upstream and downstream of a TSS to be included as a promoter region.
Peaks called within one of these regions will be annotated as a "promoter" peak. For example, \code{promoterRegion = c(2000, 100)} will annotate any peak within the region
2000 bp upstream and 100 bp downstream of a TSS as a "promoter" peak.}

\item{genomeAnnotation}{The genomeAnnotation (see \code{createGenomeAnnotation()}) to be used for generating peak metadata such as nucleotide
information (GC content) or chromosome sizes.}

\item{geneAnnotation}{The geneAnnotation (see \code{createGeneAnnotation()}) to be used for labeling peaks as "promoter", "exonic", etc.}

\item{plot}{A boolean describing whether to plot peak annotation results.}

\item{threads}{The number of threads to be used for parallel computing.}

\item{parallelParam}{A list of parameters to be passed for biocparallel/batchtools parallel computing.}

\item{force}{A boolean value indicating whether to force the reproducible peak set to be overwritten if it already exist in the given \code{ArchRProject} peakSet.}

\item{verbose}{A boolean value that determines whether standard output includes verbose sections.}

\item{logFile}{The path to a file to be used for logging ArchR output.}

\item{...}{Additional parameters to be pass to \code{addGroupCoverages()} to get sample-guided pseudobulk cell-groupings. Only used for TileMatrix-based
peak calling (not for MACS2). See \code{addGroupCoverages()} for more info.}
}
\description{
This function will get insertions from coverage files, call peaks,
and merge peaks to get a "Union Reproducible Peak Set".
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

# Add Peak Matrix Tiles
proj <- addReproduciblePeakSet(proj, peakMethod = "tiles")

# Add Peak Matrix Macs2 (Preferred)
proj <- addReproduciblePeakSet(proj, peakMethod = "macs2")

}
