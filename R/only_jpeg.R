#' only_jpeg
#'
#' @param equality_table test
#'
#' @export
only_jpeg <- function(equality_table) {
  
  message("Removing non-jpeg files from equality table...")
  
  jpeg_equality_table <- equality_table[
    grepl("^(.*)+(\\.jpg|\\.jpeg)$", equality_table[["dir_with_doubles"]], ignore.case = TRUE) &
      grepl("^(.*)+(\\.jpg|\\.jpeg)$", equality_table[["dir_reference"]], ignore.case = TRUE),
    ]
  
  return(jpeg_equality_table)
  
}
