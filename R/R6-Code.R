#' @title
#' R6 Code class
#'
#' @description
#' Class representing a piece of code.
#'
#' @family
#' Representations
Code <- R6::R6Class(
  classname = "Code",
  # Public ----
  public = list(
    #' @description
    #' Initializer method
    #'
    #' @param name (\link[base]{character})\cr
    #' Name of Code object.
    #' @param lines (\link[base]{character})\cr
    #' Vector of lines Code object.
    #'
    #' @return `invisible(self)`
    initialize = function(name, lines) {
      private$name <- name
      private$lines <- lines
      private$nLines <- length(lines)
      return(invisible(self))
    },

    #' @description
    #' Overload generic print, to print Code object.
    #'
    #' @param ...
    #' further arguments passed to or from other methods. See \link[base]{print}.
    #'
    #' @return ([base]{character})
    print = function(...) {
      classTypes <- class(self)
      classTypes <- paste0(glue::glue("<{classTypes}>"), collapse = " ")

      cat(
        glue::glue(
          "{classTypes}
        Name: {private$name}
        # Lines: {private$nLines}
        "
        )
      )
    },

    #' @description
    #' Get method for lines.
    #'
    #' @return (\link[base]{character})\cr
    #' Vector of lines in the Code object.
    getLines = function() {
      return(private$lines)
    },

    #' @description
    #' Get method for number of lines.
    #'
    #' @return (\link[base]{numeric})
    #' Number of lines in the Code object.
    getNLines = function() {
      return(private$nLines)
    },

    #' @description
    #' Get method for Name.
    #'
    #' @return (\link[base]{character})\cr
    #' Name of the Code object.
    getName = function() {
      return(private$name)
    }
  ),
  # Private ----
  private = list(
    name = "",
    lines = c(),
    nLines = 0
  )
)
