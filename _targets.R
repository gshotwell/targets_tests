# Load packages required to define the pipeline:
library(targets)
library(targets)
library(tarchetypes)
library(tibble)
values <- tibble(
  method_function = rlang::syms(c("method1", "method2")),
  data_source = c("NIH", "NIAID")
)
targets <- tar_map(
  values = values,
  tar_target(analysis, method_function(data_source, reps = 10)),
  tar_target(summary, summarize_analysis(analysis, data_source))
)
list(targets)

files <- list.files("R")
files <- files[files != "_snaps"]

file_mapping <- tibble::tibble(
  r_file = file.path("R", files),
  tests = file.path("tests/testthat", paste0("test-", files))
)

# This is used to force a dependency with both the test file and the R file
dep_test <- function(file, test_file) {
  testthat::test_file(test_file)
}

targets <- tarchetypes::tar_map(
  values = file_mapping,
  tar_target(
    name = main_file,
    command = r_file,
    format = "file"
  ),
  tar_target(
    name = test_file,
    command = tests,
    format = "file"
  ),
  tar_target(name = results,
             command = dep_test(main_file, test_file)
  )
)
list(targets)
