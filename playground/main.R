# dir_A = ("G:\\2007-03-27"),
# dir_B = ("F:\\Dropbox\\Bilder_sortiert"),

dir_with_doubles <- ("/home/clemens/Desktop/test/test1/A")
dir_reference <- ("/home/clemens/Desktop/test/test1/B")

equality_table <- equal_size_files(
  dir_with_doubles,
  dir_reference,
  pattern = NULL,
  ignore.case = TRUE,
  full.names = TRUE,
  recursive = TRUE
)

jpeg_equality_table <- only_jpeg(equality_table)

move_doubles_jpeg(
  jpeg_equality_table,
  "/home/clemens/Desktop/test/test1"
)
