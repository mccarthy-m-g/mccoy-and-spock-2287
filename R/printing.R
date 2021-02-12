#' Format numbers as strings for printing
#'
#' @description
#' `print_num()` makes it easy to format numbers rounded to a specified number
#' of decimal places with trailing zeros.
#'
#' @param x A numeric vector.
#' @param digits An integer indicating the number of decimal places to be used.
#' @param abs A logical indicating if printed numbers should be absolute.
#'
#' @returns
#' `print_num()` returns a A character vector of length that of the longest
#' input.
#'
#' @examples
#' print_num(2)
#' print_num(2, digits = 4)
#'
#' @export
#' @seealso [sprintf()]
print_num <- function(x, digits = 2, abs = FALSE) {
  ifelse(abs,
         sprintf(paste0("%.", digits, "f"), abs(x)),
         sprintf(paste0("%.", digits, "f"), x)
         )
}

#' Format p-values as strings for printing
#'
#' @description
#' `print_p()` makes it easy to format p-values rounded to a specified number
#' of decimal places.
#'
#' @param x A numeric vector.
#' @param digits An integer indicating the number of decimal places to be used
#'   as a lower cutoff. p-values below this cutoff will have a leading
#'   less-than sign.
#' @param in_table A logical indicating whether the p-value will be printed in
#'   a table. Removes leading equal sign for p-values greater than the decimal
#'   cutoff.
#'
#' @returns
#' `print_p()` returns a A character vector of length that of the longest
#' input.
#'
#' @examples
#' print_p(0.0005)
#' print_p(0.0025)
#' print_p(0.002, in_table = TRUE)
#'
#' @export
#' @seealso [sprintf()]
print_p <- function(x, digits = 3, in_table = FALSE) {
  lower_limit <- as.numeric(paste0("0.", strrep(0, digits - 1), "1"))
  ifelse(x < lower_limit,
         paste0("< .", strrep(0, digits - 1), "1"),
         paste0(if(!in_table) "= ",
                stringr::str_remove(sprintf(paste0("%.", digits, "f"), x),
                                    "^0+")
                )
         )
}

#' Format t-test results in APA format
#'
print_t.test <- function(x) {
  # get test values
  t  <- sprintf("%.2f", x$statistic)
  df <- sprintf("%.2f", x$parameter)
  p  <- ifelse(x$p.value < 0.001,
               "< .001",
               paste0("= ", gsub("^(-?)0\\.","\\.", sprintf("%.3f", x$p.value)))
  )

  # turn values into APA string
  paste0("$t(", df, ") = ", t, "$, $p ", p, "$")
}
