
################################################################################
### Recreating the sitemap.xml file.
if (file.exists("../../docs/sitemap.xml")) {
  file.remove("../../docs/sitemap.xml")
  file.create("../../docs/sitemap.xml")
}
################################################################################


################################################################################
### Defining the functions to create the sitemap.xml.
sitemap_intro_fun <- function() {
  # Function to add the chunk at the top of the file.   
  system(paste0('echo \"<?xml version=\\"1.0\\" encoding=\\"UTF-8\\"?>\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"<urlset\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"      xmlns=\\"http://www.sitemaps.org/schemas/sitemap/0.9\\"\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"      xmlns:xsi=\\"http://www.w3.org/2001/XMLSchema-instance\\"\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"      xsi:schemaLocation=\\"http://www.sitemaps.org/schemas/sitemap/0.9\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"      http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\\">\" >> ../../docs/sitemap.xml'))
  # We include the creation date at the top of the file in a comment.
  system(paste0('echo \"<!-- Sitemap created on ', Sys.time(), '. -->\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"\" >> ../../docs/sitemap.xml'))
}
  

sitemap_main_fun <- function(file_name, service_name) {
  # Function to add the chunks in the body of the file. 
  system(paste0('echo \"<!-- parsing file: docs/service/', file_name, '.json -->\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"<url>\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"  <loc>https://cloud.vhp4safety.nl/service/', service_name, '.html</loc>\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"  <priority>1.00</priority>\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"  <changefreq>weekly</changefreq>\" >> ../../docs/sitemap.xml'))
  system(paste0('echo \"</url>\" >> ../../docs/sitemap.xml'))
}

sitemap_outro_fun <- function() {
  # Function to add the closing tag at the bottom of the file.
  system(paste0('echo \"</urlset>\" >> ../../docs/sitemap.xml'))
}


################################################################################
### Running the functions above to create the sitemap.xml.

# Adding the chunk at the top.
sitemap_intro_fun()


# service_list <- dir("../../docs/service/")
# service_list <- service_list[grep(".json", service_list)]
# service_list <- gsub(".json", "", service_list)
# service_list <- service_list[-which(service_list == "template")]

# Adding the lists one by one, after getting the list of .json files and the 
# values in the id fields in them. 
require("rjson")
json_files <- grep(".json", dir("../../docs/service/"))
json_files <- dir("../../docs/service/")[json_files]
json_files <- json_files[-which(json_files == "template.json")]

# Creating an empty list object to store the id fields.
service_list <- rep(NA, length(json_files))
for (i in 1:length(json_files)) {
  service_list[i] <- fromJSON(file=paste0("../../docs/service/", json_files[i]))$id
}
  
for (i in service_list) {
  sitemap_main_fun(json_files[i], service_list[i])
}

# Adding the chunk at the bottom.
sitemap_outro_fun()
