# load library -----------------------------------------------------------
library('tidyverse')
library(fs) # To use the dir_create function for creating folder
library(remotes) # To use the install_github() function for the purpose of loading the dcldata
library(dcldata) # The data challenge dataset package

data(package = 'dcldata') # load the data challenge lab dataset

# Install dcldata from GitHub
remotes::install_github("dcl-docs/dcldata")

data(package = 'dcldata')

# Create folders ---------------------------------------------------------

dir_create('data-raw') # create folder
dir_create('code')
dir_create('data')

data(billboard) # Load the billboard dataset from the tidyr package
view(billboard)
?billboard


# Pivot_longer function --------------------------------------------------

billboard |>
    pivot_longer(
        cols = contains('wk'),
        names_to = 'week_of_rank',
        values_to = "ranking",
        values_drop_na = TRUE
    ) |>
    mutate(
        week_of_rank = parse_number(week_of_rank)
    )


example_eagle_nests_tidy <- example_eagle_nests |>
    pivot_longer(
        cols = -region,
        names_to = 'year',
        values_to = 'number_of_nest'
    )


example_eagle_pairs |>
    pivot_longer(
        cols = -c(state, state_abbr),
        names_to = 'year',
        values_to = "number_of_nests",
        values_drop_na = TRUE
    )
