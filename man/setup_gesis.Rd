% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gesis.R
\name{setup_gesis}
\alias{setup_gesis}
\title{Prepare connection to GESIS}
\usage{
setup_gesis(download_dir = ".", file_mime = "application/octet-stream")
}
\arguments{
\item{download_dir}{The directory (relative to your working directory) to
which you will be downloading files from GESIS.}

\item{file_mime}{The MIME type of the file(s) you will be downloading (see
details).}
}
\value{
A Selenium remote driver.
}
\description{
Set up options necessary for automatically downloading files from GESIS. Will
always be the first function run when using the \code{gesis} package. See
Workflow section below for further explanation.
}
\details{
Most GESIS datasets are .dta or .spss files, which are of MIME type
  "application/octet-stream". However, there are stray files stored as e.g.
  .zip, which are of a different type ("application/zip" in this case). If
  you notice your browser opening a download dialog and waiting for your
  manual input (clicking OK to download), then odds are the file is not a
  .dta/.spss file. You will then need to re-run the setup with a different
  \code{file_mime} argument.
}
\section{Workflow}{
 The GESIS website (\url{http://www.gesis.org}) offers a
  large repository of datasets, mostly on public opinion surveys. However, it
  does not offer a standard API, which makes accessing these datasets in a
  programmatic and reproducible way difficult. The \code{gesis} package gets
  around this issue through the use of Selenium
  (\url{http://www.seleniumhq.org/}) and the \code{RSelenium} package.
  Selenium allows you to emulate a web browser session, wherein you log in to
  the GESIS website, browse to the dataset of interest, click to download
  that dataset, agree to accept the terms of use, and, ultimately, download
  the dataset. This whole process follows three steps: \enumerate{
  \item{Initiate a Selenium server (\code{setup_gesis})} \item{Log in to
  GESIS (\code{gesis_login})} \item{Download a specified dataset
  (\code{download_dataset})} \item{(optional) Manually closing the Selenium
  server (remDr$close(); remDr$closeServer())} }

  The \code{setup_gesis} function currently only supports Firefox. So if you
  want to use a different browser, it is recommended that you look at the
  code in that function, and the
  \href{https://cran.r-project.org/web/packages/RSelenium/vignettes/RSelenium-saucelabs.html}{documentation}
  in the \code{RSelenium} package on how to set up a remote driver using
  other browsers. Once you have successfully initiated a remote browser with
  a different browser, the subsequent steps in the workflow should work as
  described in this documentation.
}
\examples{
\dontrun{
gesis_remDr <- setup_gesis(download_dir = "downloads")
login_gesis(gesis_remDr, user = "myusername", pass = "mypassword")
download_dataset(gesis_remDr, doi = 5928)
}
}

