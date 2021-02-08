# Ensure the project root is set up correctly using {here}
here::i_am("R/data-simulation.R")

# load packages
library(here)
library(dplyr)

# create dataset --------------------------------------------------------------
set.seed(5327)
df_2way_3x3 <- tibble(ID = 1:423,
                      age = rnorm(n = 423, mean = 35, sd = 15),
                      gender = sample(c("man", "woman"),
                                      size = 423,
                                      replace = TRUE,
                                      prob = c(0.75, 0.25)
                      ),
                      division = c(rep("science_medical", 141),
                                   rep("command", 141),
                                   rep("operations", 141)
                      ),
                      uniform_colour = c(rep(c("blue", "yellow", "red"),
                                             each = 47,
                                             length.out = 423)
                      ),
                      injury_severity = c(round(rnorm(n = 47, mean = 3, sd = 1.5)), # A*a
                                          round(rnorm(n = 47, mean = 4, sd = 1.2)), # A*b
                                          round(rnorm(n = 47, mean = 8, sd = 2.0)), # A*c #high
                                          round(rnorm(n = 47, mean = 4, sd = 1.0)), # B*a
                                          round(rnorm(n = 47, mean = 3, sd = 1.8)), # B*b
                                          round(rnorm(n = 47, mean = 8, sd = 1.0)), # B*c #high
                                          round(rnorm(n = 47, mean = 3, sd = 1.3)), # C*a
                                          round(rnorm(n = 47, mean = 5, sd = 2.0)), # C*b
                                          round(rnorm(n = 47, mean = 8, sd = 1.1))  # C*c #high
                      )
) %>%
  mutate(age = case_when(age < 18 ~ 23,
                         age > 65  ~ 48,
                         TRUE ~ as.numeric(age)
  )
  ) %>%
  mutate(injury_severity = case_when(injury_severity > 10 ~ 10,
                                     injury_severity < 1  ~ 1,
                                     TRUE ~ as.numeric(injury_severity)
  )
  )
# encode IV1 as a factor
df_2way_3x3$division <- factor(df_2way_3x3$division,
                               levels = c("science_medical", "command", "operations"))
# encode IV2 as a factor
df_2way_3x3$uniform_colour <- factor(df_2way_3x3$uniform_colour,
                                     levels = c("blue", "yellow", "red"))

# save dataset to a .csv file -------------------------------------------------
write_csv(df_2way_3x3, here("Data", "redshirts.csv"))
