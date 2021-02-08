#' Get test statistics for assessing normality assumption
#'
#' @description
#' `test_normality()` makes it easy to get test statistics for evaluating
#' whether the assumption of normality for parametric tests has been met.
#'
#' @param .data A data frame, data frame extension (e.g. a tibble), or a lazy
#'   data frame (e.g. from dbplyr or dtplyr). See Methods, below, for more
#'   details.
#' @param dv The dependent variable to calculate descriptive statistics for.
#' @param group_by Variables or computations to group by. Uses
#'   [dplyr::group_by()].
#'
#' @returns
#' `test_normality()` returns a tibble with skewness, skewness, and
#' Shapiro-Wilk test of normality values.
#'
#' @examples
#' test_normality(mtcars, dv = mpg, group_by = cyl)
#'
#' @export
#' @seealso [dplyr::groupy_by()], [dplyr::summarise()],
#' [moments::skewness()], [moments::kurtosis], [shapiro.test()]
test_normality <- function(.data, dv, group_by) {
  .data %>%
    dplyr::group_by(dplyr::across({{group_by}})) %>%
    dplyr::summarise(skewness = moments::skewness({{dv}}),
                     kurtosis = moments::kurtosis({{dv}}),
                     statistic = shapiro.test({{dv}})$statistic,
                     df = length({{dv}}),
                     p.value = shapiro.test({{dv}})$p.value) %>%
    rowwise() %>%
    mutate(cell = stringr::str_flatten(c({{group_by}}), "_"),
           .before = everything()) %>%
    ungroup() %>%
    dplyr::select(!c({{group_by}}))
}
