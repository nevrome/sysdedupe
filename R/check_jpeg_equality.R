#' check_jpeg_equality
#'
#' @param equality_table 
#' @param pixels 
#'
#' @export
check_jpeg_equality <- function(
  equality_table,
  pixels = seq(1, 2001, 10)
) {

  message("Removing non-jpeg files from equality table...")
  
  jpeg_equality_table <- dplyr::filter(
    equality_table,
    grepl("^(.*)+(\\.jpg|\\.jpeg)$", dir_A, ignore.case = TRUE) &
      grepl("^(.*)+(\\.jpg|\\.jpeg)$", dir_B, ignore.case = TRUE)
  )
  
  message("Compare individual files by pixel values...")
  
  pb <- txtProgressBar(
    min = 0,
    max = nrow(jpeg_equality_table),
    style = 3
  )
  
  equal <- c()
  for (i in 1:nrow(jpeg_equality_table)) {
    A_pic <- jpeg_equality_table$dir_A[i]
    B_pic <- jpeg_equality_table$dir_B[i]
    A_pic_values = jpeg::readJPEG(A_pic, native = T)[pixels]
    B_pic_values = jpeg::readJPEG(B_pic, native = T)[pixels]
    equal[i] <- identical(A_pic_values, B_pic_values)
    
    setTxtProgressBar(pb, i)
  }
  
  close(pb)
  
  message("Add result of equality test to equality table...")
  
  jpeg_equality_table$pixel_equal <- equal
  
  return(jpeg_equality_table)
  
}



