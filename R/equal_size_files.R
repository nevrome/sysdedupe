#' equal_size_files
#'
#' @param dir_with_doubles test
#' @param dir_reference test
#' @param ... test
#'
#' @export
equal_size_files <- function(
  dir_with_doubles, 
  dir_reference,
  ...
) {
  
  message("Listing files in ", dir_with_doubles, " ...")
  
  A_files <- list.files(dir_with_doubles, ...)
  
  message(dir_with_doubles, ": ", length(A_files), " files")
  message("Listing files in ", dir_reference, " ...")
  
  B_files <- list.files(dir_reference,  ...)
  
  message(dir_reference, ": ", length(B_files), " files")
  
  message("Calculating size of all files...")
  
  A_size <- sapply(A_files, file.size)
  B_size <- sapply(B_files, file.size)
  
  message("Comparing files sizes between ", dir_with_doubles, " and ", dir_reference, " ...")
  
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

  message("Preparing equality table...")
    
  redlist <- reslist[lapply(reslist, length) > 0]
  
  tab <- tibble::tibble(
    dir_with_doubles = names(redlist),
    dir_reference = unname(redlist)
  )
  
  equality_table <- tidyr::unnest(tab)

  return(equality_table)
  
}
