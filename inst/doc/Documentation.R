## ----knitrOptions, include=FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----localCache, echo=FALSE---------------------------------------------------
withr::local_envvar(
  R_USER_CACHE_DIR = tempfile(),
  R_COMPILE_AND_INSTALL_PACKAGES = "always"
)

## ----setup--------------------------------------------------------------------
library(PaRe)

## ----whiteList----------------------------------------------------------------
PaRe::whiteList

## ----whiteListSession---------------------------------------------------------
sessionWhiteList <- rbind(
  whiteList,
  list(
    source = "dummySession",
    link = "some/file.csv",
    package = "package",
    version = "version"
  )
)

sessionWhiteList

## ----setupWhiteList-----------------------------------------------------------
fileWhiteList <- rbind(
  read.csv(
    system.file(
      package = "PaRe",
      "whiteList.csv"
    )
  ),
  list(
    source = "dummyFile",
    link = "some/file.csv",
    package = "package",
    version = "version"
  )
)

fileWhiteList

## ----writeWhiteList, eval=FALSE-----------------------------------------------
#  write.csv(
#    fileWhiteList,
#    system.file(
#      package = "PaRe",
#      "whiteList.csv"
#    )
#  )

## ----permittedPackages, eval=FALSE, message=FALSE, warning=FALSE--------------
#  PaRe::getDefaultPermittedPackages(base = TRUE)

## ----cloneRepoShow, eval=FALSE------------------------------------------------
#  # Temp dir to clone repo to
#  tempDir <- tempdir()
#  pathToRepo <- file.path(tempDir, "glue")
#  
#  # Clone IncidencePrevalence to temp dir
#  git2r::clone(
#    url = "https://github.com/tidyverse/glue.git",
#    local_path = pathToRepo
#  )
#  
#  repo <- PaRe::Repository$new(path = pathToRepo)

## ----cloneRepo, echo=FALSE----------------------------------------------------
fetchedRepo <- tryCatch(
  {
    tempDir <- tempdir()
    pathToRepo <- file.path(tempDir, "glue")

    git2r::clone(
      url = "https://github.com/tidyverse/glue.git",
      local_path = pathToRepo
    )

    repo <- PaRe::Repository$new(path = pathToRepo)
    TRUE
  },
  error = function(e) {
    FALSE
  },
  warning = function(w) {
    FALSE
  }
)

## ----checkDependenciesShow, eval=FALSE----------------------------------------
#  PaRe::checkDependencies(repo = repo)

## ----setupGraphShow, eval=FALSE-----------------------------------------------
#  graphData <- PaRe::getGraphData(
#    repo = repo,
#    packageTypes = c("imports", "suggests")
#  )

## ----graphCharacteristicsShow, eval=FALSE-------------------------------------
#  data.frame(
#    countVertices = length(igraph::V(graphData)),
#    countEdges = length(igraph::E(graphData)),
#    meanDegree = round(mean(igraph::degree(graphData)), 2),
#    meanDistance = round(mean(igraph::distances(graphData)), 2)
#  )

## ----plotGraphShow, eval=FALSE------------------------------------------------
#  plot(graphData)

## ----summariseFunctionUseShow, eval=FALSE-------------------------------------
#  funsUsed <- PaRe::getFunctionUse(repo = repo)
#  funsUsed

## ----summariseFunctionUse, echo=FALSE, message=FALSE, warning=FALSE-----------
if (fetchedRepo) {
  funsUsed <- PaRe::getFunctionUse(repo = repo)
  funsUsed
}

## ----definedFunctionsShow, eval=FALSE-----------------------------------------
#  defFuns <- PaRe::getDefinedFunctions(repo = repo)
#  head(defFuns)

## ----definedFunctions, echo=FALSE---------------------------------------------
if (fetchedRepo) {
  defFuns <- PaRe::getDefinedFunctions(repo = repo)
  head(defFuns)
}

## ----pkgDiagramShow, eval=FALSE-----------------------------------------------
#  PaRe::pkgDiagram(repo = repo) %>%
#    DiagrammeRsvg::export_svg() %>%
#    magick::image_read_svg()

## ----pkgDiagram, echo=FALSE---------------------------------------------------
if (fetchedRepo) {
  if (all(c(
    require("DiagrammeRsvg", character.only = TRUE),
    require("magick", character.only = TRUE)))) {
      PaRe::pkgDiagram(repo = repo) %>%
        DiagrammeRsvg::export_svg() %>%
        magick::image_read_svg()
  }
}

## ----linesOfCodeShow, eval=FALSE----------------------------------------------
#  PaRe::countPackageLines(repo = repo)

## ----linesOfCode, echo=FALSE--------------------------------------------------
if (fetchedRepo) {
  PaRe::countPackageLines(repo = repo)
}

## ----lintScoreShow, eval=FALSE------------------------------------------------
#  messages <- PaRe::lintRepo(repo = repo)
#  PaRe::lintScore(repo = repo, messages = messages)

## ----lintScore, echo=FALSE----------------------------------------------------
if (fetchedRepo) {
  messages <- PaRe::lintRepo(repo = repo)
  PaRe::lintScore(repo = repo, messages = messages)
}

## ----lintMessagesShow, eval=FALSE---------------------------------------------
#  head(messages)

## ----lintMessages, echo=FALSE-------------------------------------------------
if (fetchedRepo) {
  head(messages)
}

