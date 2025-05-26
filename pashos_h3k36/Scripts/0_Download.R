# Load required packages
if (!requireNamespace("curl", quietly = TRUE)) install.packages("curl")
if (!requireNamespace("R.utils", quietly = TRUE)) install.packages("R.utils")

library(curl)
library(R.utils)

# URL and destination
ftp_tar <- "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE247nnn/GSE247253/suppl/GSE247253_RAW.tar"
dest_dir <- "/sharedFolder/Data"
tar_file <- file.path(dest_dir, "GSE247253_RAW.tar")

# Ensure directory exists
dir.create(dest_dir, showWarnings = FALSE)
system("chmod -R 777 ..", intern = TRUE)

# Download using curl with extended timeout
curl::curl_download(url = ftp_tar, destfile = tar_file, mode = "wb", handle = new_handle(timeout = 300))
system("chmod -R 777 ..", intern = TRUE)

# Extract the .tar archive
untar(tar_file, exdir = dest_dir)
system("chmod -R 777 ..", intern = TRUE)

# Unzip all .rds.gz files
gz_files <- list.files(dest_dir, pattern = "\\.gz$", full.names = TRUE)
for (f in gz_files) {
  message("Unzipping: ", f)
  gunzip(f, overwrite = TRUE, remove = TRUE)
}
system("chmod -R 777 ..", intern = TRUE)

# Optional cleanup
unlink(tar_file)
system("chmod -R 777 ..", intern = TRUE)
