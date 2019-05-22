# dir_A = ("G:\\2007-03-27"),
# dir_B = ("F:\\Dropbox\\Bilder_sortiert"),

dir_A <- ("C:\\Users/X/Desktop/test/A")
dir_B <- ("C:\\Users/X/Desktop/test/B")

equality_table <- equal_size_files(
  dir_A,
  dir_B,
  pattern = "^(.*)+(\\.jpg|\\.jpeg)$",
  ignore.case = TRUE,
  full.names = TRUE,
  recursive = TRUE
)

equality_table <- check_equality(equality_table)



