#' move_doubles_jpeg
#'
#' @param equality_table test
#' @param dir_doubles_backup test
#' @param pixels test
#'
#' @export
move_doubles_jpeg <- function(
  equality_table, 
  dir_doubles_backup,
  pixels = seq(1, 2001, 10)
) {

  dir_new <- file.path(dir_doubles_backup, paste0("doubles_", random_string_generator(1)))
  
  message("Creating doubles directory here: ", dir_new)
  
  dir.create(dir_new, recursive = T)
  
  message("Comparing individual jpeg pics by pixel values and moving pics to the doubles directory...")

  pb <- utils::txtProgressBar(
    min = 0,
    max = nrow(equality_table),
    style = 3
  )
  
  equal <- c()
  for (i in 1:nrow(equality_table)) {
    
    current_pic <- equality_table[["dir_with_doubles"]][i]
    
    if (!file.exists(current_pic)) {
      next
    }
    
    equal_pic <- equality_table[["dir_reference"]][i]
    
    current_pic_values <- jpeg::readJPEG(current_pic, native = T)[pixels]
    equal_pic_values <- jpeg::readJPEG(equal_pic, native = T)[pixels]
    
    equal <- identical(current_pic_values, equal_pic_values)

    if (equal) {

      new_source_dir <- dirname(file.path(
        dir_new,
        gsub("^/|^[A-Z]{1}:\\\\", "", current_pic)
      ))
      
      if (!dir.exists(new_source_dir)) {
        dir.create(
          new_source_dir,
          recursive = T
        )
      }
      
      suppressMessages(
        filesstrings::file.move(
          current_pic,
          new_source_dir
        )
      )
      
    } 
    
    utils::setTxtProgressBar(pb, i)
  }
  
  close(pb)
  
  return(dir_new)

}
