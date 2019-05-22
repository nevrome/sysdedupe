#' hide_doubles
#'
#' @param equality_table test
#' @param dir_A test
#'
#' @export
hide_doubles <- function(equality_table, dir_A) {

  message("Preparing moving operation...")
          
  source_files <- unique(equality_table[["dir_A"]])
  dir_new <- file.path(dir_A, paste0("doubles_", random_string_generator(1)))
  new_source_dirs <- dirname(file.path(
    dir_new,
    gsub("^/|^[A-Z]{1}:\\\\", "", source_files)
  ))
  
  message("Creating doubles directory structure in ", dir_new)
  
  unique_new_source_dirs <- unique(new_source_dirs)
  for (i in 1:length(unique_new_source_dirs)) {
    dir.create(
      unique_new_source_dirs[i],
      recursive = T
    )
  }
  
  message("Moving files...")
  
  filesstrings::file.move(
    source_files,
    new_source_dirs
  )
  
}
