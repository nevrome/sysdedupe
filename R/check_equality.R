#' check_equality
#'
#' @param equality_table 
#' @param pixels 
#'
#' @export
check_equality <- function(
  equality_table,
  pixels = seq(1, 2001, 10)
) {

  pb <- txtProgressBar(
    min = 0,
    max = nrow(equality_table),
    style = 3
  )
  
  equal <- c()
  for (i in 1:nrow(equality_table)) {
    A_pic <- equality_table$dir_A[i]
    B_pic <- equality_table$dir_B[i]
    A_pic_values = jpeg::readJPEG(A_pic, native = T)[pixels]
    B_pic_values = jpeg::readJPEG(B_pic, native = T)[pixels]
    equal[i] <- identical(A_pic_values, B_pic_values)
    
    setTxtProgressBar(pb, i)
  }
  
  equality_table$pixel_equal <- equal
  
  close(pb)
  
  return(equality_table)
  
}



