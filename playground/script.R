A <- ("C:\\Users/X/Desktop/test/A")
B <- ("C:\\Users/X/Desktop/test/B")
recursive <- TRUE

A_files <- list.files(A, full.names = TRUE, recursive = recursive)
B_files <- list.files(B, full.names = TRUE, recursive = recursive)

pic_details <- function(x) {
  list(
    pic_size = file.size(x),
    pic_height = nrow(pic_matrix),
    pic_width = ncol(pic_matrix),
    pic_matrix = jpeg::readJPEG(x, native = T)[seq(1, 2001, 10)]
  )
}

A_vals <- pbapply::pblapply(A_files, pic_details)
B_vals <- pbapply::pblapply(B_files, pic_details)

comparison <- lapply(
  A_vals,
  function(x) {
    sapply(
      B_vals,
      function(y, x) {
        identical(x, y)
      },
      x
    )
  }
)

A_comparison <- sapply(
  comparison,
  function(x) {
    any(x)
  }
)

A_doubles <- which(A_comparison)

A_doubles_paths <- A_files[A_doubles]

B_doubles_paths <- lapply(
  comparison[A_doubles],
  function(
    x, B_files
  ) {
    B_files[which(x)]
  },
  B_files
)

result <- data.frame(
  source = A_doubles_paths,
  target = sapply(
    B_doubles_paths,
    function(x) {
      paste(x, collapse = "; ")
    }
  )
)

write.csv(result, file = "C:\\Users/X/Desktop/test/res.csv")


