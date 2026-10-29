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


# Pivot wider practice ---------------------------------------------------

example_eagle_nests_tidy |>
    pivot_wider(
        id_cols = region,
        names_from = year,
        values_from = number_of_nest
    )

# Use the example_acs_1 dataset from dcldata package
example_acs_1 |>
    pivot_wider(
        names_from = variable,
        values_from = estimate
    )

view(example_migration)
example_migration |> # From the dcldata
    pivot_longer(
        cols = -dest,
        names_to = 'country',
        values_to = 'migrants',
        values_drop_na = TRUE
    )


data(package = 'tidyr')
fish_encounters
View(fish_encounters)
fish_encounters |> # Note that the variables to be created  each has a single corresponing value contained in the seen column
    pivot_wider(
        names_from = station,
        values_from = seen,
        values_fill = 0 # This turns NA values from the seen column into 0
    )

us_rent_income |>
    distinct(variable) #  This helps you check the number of columns expected to be created

us_rent_income |> # Note that the variables to be created  each has two corresponding values contained in the estimate and moe columns
    pivot_wider(
        names_from = variable,
        values_from = c(estimate, moe)
    )

us_rent_income |> # Note that the variables to be created  each has two corresponding values contained in the estimate and moe columns
    pivot_wider(
        names_from = variable,
        values_from = c(estimate, moe),
        names_sep = '.' # This controls the seprator between the column labels
    )

us_rent_income |> # Note that the variables to be created  each has two corresponding values contained in the estimate and moe columns
    pivot_wider(
        names_from = variable,
        values_from = c(estimate, moe),
        names_glue = '{variable}_{.value }', # This controls how the new columns are named
        names_sep = '.'
    )

us_rent_income |>
    pivot_wider(
        names_from = variable, # Note that the variables to be created  each has two corresponding values contained in the estimate and moe columns
        values_from = c(estimate, moe),
        names_vary = 'slowest' # This controls the order in which the new columns appears. Here based on the order of the values contained in the variable column i.e income before rent
    )

us_rent_income |>
    pivot_wider(
        names_from = variable,
        values_from = c(estimate, moe), # Note that the variables to be created  each has two corresponding values contained in the estimate and moe columns
        names_vary = 'fastest' # This controls the order in which the new columns appears. Here based on the order of the estimate and income variables. The estimate come first followed by the the income
    )
