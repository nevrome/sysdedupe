#' equal_size_files
#'
#' @param dir_A 
#' @param dir_B 
#' @param ... 
#'
#' @export
equal_size_files <- function(
  dir_A, 
  dir_B,
  ...
) {
  
  message("Listing files in ", dir_A, " ...")
  
  A_files <- list.files(dir_A, ...)
  
  message(dir_A, ": ", length(A_files), " files")
  message("Listing files in ", dir_B, " ...")
  
  B_files <- list.files(dir_B,  ...)
  
  message(dir_B, ": ", length(B_files), " files")
  
  message("Calculating size of all files...")
  
  A_size <- sapply(A_files, file.size)
  B_size <- sapply(B_files, file.size)
  
  message("Comparing files sizes between ", dir_A, " and ", dir_B, " ...")
  
  reslist <- lapply(
    A_size, 
    function(x, B_size) {
      comparison <- x == B_size
      if(any(comparison)) {
        names(B_size)[comparison]
      }
    },
    B_size
  )

  message("Preparing output table...")
    
  redlist <- reslist[lapply(reslist, length) > 0]
  
  tab <- tibble::tibble(
    dir_A = names(redlist),
    dir_B = unname(redlist)
  )
  
  tab_long <- tidyr::unnest(tab)

  return(tab_long)
  
}
