# dir_A = ("G:\\2007-03-27"),
# dir_B = ("F:\\Dropbox\\Bilder_sortiert"),

dir_A <- ("/home/clemens/Desktop/test/test1/A")
dir_B <- ("/home/clemens/Desktop/test/test1/B")

equality_table <- equal_size_files(
  dir_A,
  dir_B,
  pattern = NULL,
  ignore.case = TRUE,
  full.names = TRUE,
  recursive = TRUE
)

jpeg_equality_table <- check_jpeg_equality(equality_table)

jpeg_equality_table_checked <- jpeg_equality_table[jpeg_equality_table$pixel_equal,]

hide_doubles(jpeg_equality_table_checked, dir_A)


