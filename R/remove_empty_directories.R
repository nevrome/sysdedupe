#' remove_empty_directories
#'
#' @param x test
#'
#' @export
remove_empty_directories <- function(x) {
  
  all_files <- list.files(
    x,
    all.files = TRUE,
    no.. = TRUE,
    recursive = TRUE,
    include.dirs = FALSE,
    full.names = TRUE
  )
  all_files_and_dirs <- list.files(
    x,
    all.files = TRUE,
    no.. = TRUE,
    recursive = TRUE,
    include.dirs = TRUE,
    full.names = TRUE
  )
  all_dirs <- setdiff(all_files_and_dirs, all_files)
  all_dirs_with_files <- dirname(all_files)
  all_dirs_without_files <- setdiff(all_dirs, all_dirs_with_files)
  
  unlink(all_dirs_without_files, recursive = TRUE)
  
  return(all_dirs_without_files)
  
}
