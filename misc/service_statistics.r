
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
### Part 1: Creating the data frame
################################################################################

################################################################################
### Loading (or installing if necessary) the rjson package. 
# install.packages("rjson")
# library("rjson")
library(jsonlite)
################################################################################

################################################################################
# Reading the template.json to get the list of all possible meta-data entries 
# for the services.
# template <- fromJSON(file="../template.json")
################################################################################

################################################################################
# Getting the list of services based on the availability of json files. 
service_list <- dir("../")[grep(".json", dir("../"))]

# Removing the template.json from the list.
service_list <- service_list[-which(service_list == "template.json")]

# The list of the services.
service_list
################################################################################

################################################################################
# Looping through the json files to get which meta-data entries are available 
# and storing this information in a list object.
dat <- list()
i   <- 1

for(service in service_list) {
  # Reading the json file and store it as a data frame.
  # tmp <- rjson::fromJSON(file=paste0("../", service), unexpected.escape="keep")
  tmp <- jsonlite::fromJSON(paste0("../", service))
  tmp <- data.frame(tmp)
  
  # Adding the available meta-data tags in the list.
  dat[[i]] <- names(tmp)
  
  # Changing the name of the branch in the list to the name of the service.
  names(dat)[i] <- gsub(".json", "", service)
  
  i <- i+1
}
################################################################################

################################################################################
# Creating a data frame where the rows and columns are assigned to services and
# meta-data tag, respectively. 

# Getting the service names.
res <- data.frame(service=names(dat))

# Getting the list of meta-data tags.
tags <- unique(unlist(dat))

# Adding columns for each tag in the data frame. 
res <- cbind(res, matrix(FALSE, nrow=nrow(res), ncol=length(tags)))
colnames(res)[2:ncol(res)] <- tags

# Converting the FALSE's into TRUEs for each service if they are available in 
# the json file. 
for(i in 1:nrow(res)) {
  res[i, which(colnames(res)[2:ncol(res)] %in% dat[[i]])+1] <- TRUE
}
res

# The proportion of availabbility of the meta-data tags in the data frame
round(colMeans(res[, 2:ncol(res)]), 2)

save(res, file="statistics_table.rdata")
################################################################################


################################################################################
### Part 1: Creating the data frame
################################################################################

################################################################################
# In this part, one can read in the output of the Part 1 which is a data frame
# with all the services and availability of the meta-data tags in their json
# files. 

# Reading the output of the Part 1.
load("statistics_table.rdata")

# The data frame.
res

# The list of all possible meta-data tags.
colnames(res[2:ncol(res)])

# One can use these tags to get the proportion of their availability, in a 
# similar manner as the example below. 
round(colMeans(res[, c("id", "description", "url", "doi", "ELIXIR.tess")]), 2)
################################################################################