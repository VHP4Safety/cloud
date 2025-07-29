
################################################################################
# This is a script to compute the statistics based on the meta-data availability
# of the services listed in the cloud catalog. 

# Note that there are two parts of this script. 
# Part 1 creates a data frame with the available services and their meta-data
# tags. You do not need to run this part to get the data. The output is saved
# to the directory.
# Part 2 can read the output of Part 1. One can use this table to get the 
# proportion of availability of the meta-data tags.
################################################################################

################################################################################
### Loading (or installing if necessary) the rjson package. 
# install.packages("rjson")
library("rjson")
# library("jsonlite")
################################################################################

################################################################################
# Reading the template.json to get the list of all possible meta-data entries 
# for the services.
template <- fromJSON(file="../docs/service/template.json")
# Converting the template into a data frame to be able to read the fields.
template <- as.data.frame(template)
# Getting the field names.
fields <- names(template)
# Removing the instructional fields.
fields <- fields[-grep("_ins", fields)]
################################################################################

################################################################################
# Getting the list of services based on the availability of json files. 
service_list <- dir("../docs/service")[grep(".json", dir("../docs/service"))]
# Removing the template.json from the list.
service_list <- service_list[-which(service_list == "template.json")]
# The list of the services.
service_list
################################################################################

################################################################################
# Creating an empty data frame to store the data.
res <- matrix(FALSE, nrow=length(service_list), ncol=length(fields))
res <- as.data.frame(res)
names(res) <- fields

# And another data frame with the same attributes to store the real data.
dat <- res
################################################################################
# Looping through the json files to get which meta-data entries are available 
# and storing this information in a list object.
# dat <- list()
i   <- 1

for(service in service_list) {
  # Reading the json file and store it as a data frame.
  # tmp <- rjson::fromJSON(file=paste0("../", service), unexpected.escape="keep")
  tmp <- fromJSON(file=paste0("../docs/service/", service))
  tmp <- data.frame(tmp)
  
  res[i, which(fields %in% names(tmp))] <- TRUE
  dat[i, which(fields %in% names(tmp))] <- tmp
  
  i <- i+1
}

# Converting the stages that are in url format to text.
dat$stage[grep("#VHP0000056", dat$stage)] <- "ADME"
dat$stage[grep("#VHP0000102", dat$stage)] <- "Hazard Assessment"
dat$stage[grep("#VHP0000148", dat$stage)] <- "Chemical Information"
dat$stage[grep("#VHP0000149", dat$stage)] <- "General"

# Saving the environment
save.image("service_statistics.rdata")

# # Saving the service statistics.
# write.table(res, file="service_statistics.txt", quote=FALSE, sep="\t", 
#             row.names=FALSE)
# 
# # Saving the service data.
# write.table(dat, file="service_data.txt", quote=FALSE, sep="\t", 
#             row.names=FALSE)
################################################################################

################################################################################
# In this part, one can load the environment with the two data frames created 
# before. 
load("service_statistics.rdata")

# The data frame with all the meta-data values of tools.
dat

# The data frame with the availability of meta-data values of tools.
res

# One can use these tags to get the proportion of their availability, in a
# similar manner as the example below.
round(colMeans(res[, c("id", "description", "url", "doi", "ELIXIR.tess")]), 2)

# Or the proportion of available data over all fields. 
round(colMeans(res), 2)
################################################################################