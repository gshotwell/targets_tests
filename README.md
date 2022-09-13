
# targetbuild

<!-- badges: start -->
<!-- badges: end -->

This is an example project which shows you how to use targets to conditionally test files when either the file or the test file has been run. 

## Example

To run the tests in this package use `targets::tar_make()` initially this will run all of the tests in the package, but subsequent runs will only test changed files. This can be very convenient for large packages with lots of long running tests. 

The file_mapping object in `_targets.R` file defines the pipeline and assumes that you are following the `usethis` pattern of naming test files `test-<R-file>.R` you can modify this object if you have a different testing pattern or want to specify the testing dependencies manually. 
