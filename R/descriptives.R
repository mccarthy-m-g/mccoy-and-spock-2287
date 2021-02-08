#' Get descriptive statistics based on grouping variables
#'
#' @description
#' `get_descriptives()` makes it easy to get print-ready descriptive statistics
#' for a dependent variable across different grouping patterns of the
#' independent variable(s).
#'
#' @param .data A data frame, data frame extension (e.g. a tibble), or a lazy
#'   data frame (e.g. from dbplyr or dtplyr). See Methods, below, for more
#'   details.
#' @param dv The dependent variable to calculate descriptive statistics for.
#' @param group_by Variables or computations to group by. Uses
#'   [dplyr::group_by()].
#' @param na.rm A logical value indicating whether NA values should be stripped
#'   before the computation proceeds.
#'
#' @returns
#' `get_descriptives()` returns a tibble with one column for each grouping cell
#'  and descriptive statistic type.
#'
#' @examples
#' get_descriptives(dplyr::starwars,
#'                 dv = height,
#'                 group_by = c(sex, gender))
#'
#' @export
#' @seealso [dplyr::groupy_by()], [dplyr::summarise()]
get_descriptives <- function(.data, dv, group_by, na.rm = FALSE, wide = FALSE) {
  df <- .data %>%
    dplyr::group_by(dplyr::across({{group_by}})) %>%
    dplyr::summarise(n         = dplyr::n(),
                     mean      = mean({{dv}}, na.rm = na.rm),
                     variance  = sd({{dv}}, na.rm = na.rm)^2,
                     std_dev   = sd({{dv}}, na.rm = na.rm),
                     std_error = sd({{dv}}, na.rm = na.rm)/sqrt(dplyr::n()),
                     conf_low  = mean({{dv}}, na.rm = na.rm) - (
                       abs(qnorm((1-0.95)/2)) *
                       sd({{dv}}, na.rm = na.rm)/sqrt(dplyr::n())
                       ),
                     conf_high = mean({{dv}}, na.rm = na.rm) + (
                       abs(qnorm((1-0.95)/2)) *
                       sd({{dv}}, na.rm = na.rm)/sqrt(dplyr::n())
                       )
    )

  if (wide) {
    df <- tidyr::pivot_wider(df,
                             names_from = {{group_by}},
                             values_from = n:conf_high)
  }

  df
}
