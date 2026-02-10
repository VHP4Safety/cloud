
################################################################################
# This is an R script to generate the material based on the service .json files
# in the /docs/service/ directory. 


################################################################################
# Loading (or installing if necessary) the rjson package. 
require("rjson")


################################################################################
### Reading the the metadata and store them in the current R session. 

# Getting the list of available .json files in the service directory.
json_files <- grep(".json", dir("../../docs/service/"))
json_files <- dir("../../docs/service/")[json_files]

# Removing the template.json from the list of .json files.
json_files <- json_files[-which(json_files == "template.json")]

# Creating an empty list object to store the metadata of all the services.
service_metadata <- list()

# Reading in all the json files and add store them in the list object created 
# above.

for (i in 1:length(json_files)) {
  # Reading in the json file for the service and adding it to the list object.
  service_metadata[[i]] <- fromJSON(file=paste0("../../docs/service/", json_files[i]))
  
  # Giving the name of the json file to the current branch of the list to assign
  # service names to the branches of the list object.
  names(service_metadata)[i] <- json_files[i]
}


################################################################################
### Creating the tools.tsv file

# Creating a data frame that already captures information for the ID and Name 
# columns.
tools <- data.frame(ID       = unlist(lapply(service_metadata, function(x) x[["id"]])),
                    Name     = unlist(lapply(service_metadata, function(x) x[["service"]])),
                    URL      = NA, 
                    CloudURL = NA)

# Removing the json file names from the row names. 
rownames(tools) <- NULL

# Capturing the service URLs and CloudURLs. 
for (i in 1:length(json_files)) {
  if(!is.null(service_metadata[[json_files[i]]][["url"]])) {
    tools[i, "URL"]      <- service_metadata[[json_files[i]]][["url"]]
  }
  
  if(!is.null(service_metadata[[json_files[i]]][["instance"]][["url"]])) {
    tools[i, "CloudURL"] <- service_metadata[[json_files[i]]][["instance"]][["url"]]
  }
}

write.table(tools, file="../../docs/tools.tsv", quote=FALSE, sep="\t", 
            row.names=FALSE)


################################################################################
### Creating the catalog.md. 

# Specifying the target file name relative to the working directory for easiness
# in this script and testing purposes.
target <- "../../docs/catalog.md"

# Removing the current catalog.md file to allow any modifications. 
if(file.exists(target)) system(paste0("rm ", target))

# Creating the catalog.md from scratch.
system(paste0("touch ", target))

# Pasting the intro text in the catalog.md. 
system(paste0("cat catalog_intro_text >> ", target))

# Creating the body of the catalog.md. 
for(i in 1:length(json_files)) {
  service_name <- service_metadata[[i]][["service"]]
  
  # Adding the screenshot if it is available. 
  if (!is.null(service_metadata[[i]][["screenshot"]])) {
    if(service_metadata[[i]][["screenshot"]] != "") {
      image_file <- service_metadata[[i]][["screenshot"]]
      # system(paste0("echo \"![", service_name, " logo](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/", image_file, ") '", service_name, " logo'\" >> ", target))
      system(paste0("echo \"![", service_name, " logo](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/", image_file, ")\" >> ", target))
      system(paste0("echo \"\" >> ", target))
    }
  } 
  
  
  # Adding the title of the service.
  system(paste0("echo \"## ", service_name, "\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  # Adding the description of the service.
  service_description <- service_metadata[[i]][["description"]]
  file_name           <- paste0(service_metadata[[i]][["id"]], ".md")
  system(paste0("echo \"", service_description, " [[more information](service/", 
                file_name, ")]\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  system(paste0("echo \"------------------------\" >> ", target))
  system(paste0("echo \"\" >> ", target))
}

# Pasting the outro text in the catalog.md. 
system(paste0("cat catalog_outro_text >> ", target))


################################################################################
### Creating the index.md

# Specifying the target file name relative to the working directory for easiness
# in this script and testing purposes.
target <- "../../docs/index.md"

# Removing the current index.md file to allow any modifications. 
if(file.exists(target)) system(paste0("rm ", target))

# Creating the index.md from scratch.
system(paste0("touch ", target))

# Pasting the intro text in the intro.md. 
system(paste0("cat index_intro_text >> ", target))
system(paste0("echo \"\" >> ", target))


# Creating the body of the intro.md. 

# Listing the internal services. 
system(paste0("echo \"### VHP4Safety Platform\" >> ", target))
system(paste0("echo \"\" >> ", target))
system(paste0("echo \"The current development platform runs several services.\" >> ", target))
system(paste0("echo \"\" >> ", target))


for(i in 1:length(json_files)) {
  # Add the service only if it is an 'internal' service. 
  if (!is.null(service_metadata[[i]][["instance"]][["type"]])) {
    if (service_metadata[[i]][["instance"]][["type"]] %in% c("internal", "VHP4Safety")) {
      service_name        <- service_metadata[[i]][["service"]]
      service_description <- service_metadata[[i]][["description"]]
      file_name           <- paste0(service_metadata[[i]][["id"]], ".md")
      
      system(paste0("echo \"#### ", service_name, "\" >> ", target))
      system(paste0("echo \"\" >> ", target))
      system(paste0("echo \"", service_description, " [[more information](service/", file_name, ")]\" >> ", target))
      system(paste0("echo \"\" >> ", target))
    }
  }
}

# Adding the external services.
system(paste0("echo \"------------------------------------------\" >> ", target))
system(paste0("echo \"\" >> ", target))
system(paste0("echo \"### External Services\" >> ", target))
system(paste0("echo \"\" >> ", target))

for(i in 1:length(json_files)) {
  # Add the service only if it is an 'external' service.
  if (!is.null(service_metadata[[i]][["instance"]][["type"]])) {
    if (!service_metadata[[i]][["instance"]][["type"]] %in% c("internal", "VHP4Safety")) {
      service_name        <- service_metadata[[i]][["service"]]
      service_description <- service_metadata[[i]][["description"]]
      file_name           <- paste0(service_metadata[[i]][["id"]], ".md")
      
      system(paste0("echo \"#### ", service_name, "\" >> ", target))
      system(paste0("echo \"\" >> ", target))
      system(paste0("echo \"", service_description, " [[more information](service/", file_name, ")]\" >> ", target))
      system(paste0("echo \"\" >> ", target))
    }
  }
}

# Pasting the outro text in the intro.md. 
system(paste0("echo \"------------------------------------------\" >> ", target))
system(paste0("cat index_outro_text >> ", target))
system(paste0("echo \"\" >> ", target))


################################################################################
### Generating the individual service pages in md format.

# Loading functions to add script parts to the md file. 
source("add_tess_html.r")
source("add_script.r")

i <- 39 # R-ODAF

for (i in 1:length(service_metadata)) {
  
  # Setting the name of the object to be created.
  target <- paste0("../../docs/service/", service_metadata[[i]][["id"]], ".md")
  
  # Removing the target file to create it again with any changes possibly made.
  if(file.exists(target)) system(paste0("rm ", target))
  
  # Creating an empty markdown file. 
  system(paste0("touch ", target))
  
  # Generating the introduction.
  service_name        <- service_metadata[[i]][["service"]]
  service_description <- service_metadata[[i]][["description"]]
  
  system(paste0("echo \"\" >> ", target))
  system(paste0("echo \"# ", service_name, "\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  system(paste0("echo \"<!--- This file is autogenerated. Edit ", names(service_metadata)[i], " to make changes in this page. ---> \" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  system(paste0("echo \"", service_description, "\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  # The line below did not work as expected in the Markdown files.
  # system(paste0("echo \"![", service_name, " logo](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/", service_metadata[[i]][["id"]], ".png) '[", service_name, " logo]'\" >> ", target))
  if (!is.null(service_metadata[[i]][["screenshot"]])) {
    if(service_metadata[[i]][["screenshot"]] != "") {
      system(paste0("echo \"![", service_name, " logo](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/", service_metadata[[i]][["id"]], ".png)\" >> ", target))
    }
  }
  system(paste0("echo \"\" >> ", target))
  
  if (!is.null(service_metadata[[i]][["url"]])) {
    if(service_metadata[[i]][["url"]] != "") {
      system(paste0("echo \"**Main Webpage:** [", service_metadata[[i]][["url"]], "](", service_metadata[[i]][["url"]], ")\" >> ", target))
    }
  }
  system(paste0("echo \"\" >> ", target))
  
  if (!is.null(service_metadata[[i]][["instance"]][["url"]])) {
    if(service_metadata[[i]][["instance"]][["url"]] != "") {
      system(paste0("echo \"**Tool Webpage:** [", service_metadata[[i]][["instance"]][["url"]], "](", service_metadata[[i]][["instance"]][["url"]], ")\" >> ", target))
    }
  }
  system(paste0("echo \"\" >> ", target))
  
  
  system(paste0("echo \"## Contact\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  contact_persons <- service_metadata[[i]][["provider"]][["contact"]][["name"]]
  contact_emails  <- service_metadata[[i]][["provider"]][["contact"]][["email"]]
  if(!is.null(contact_persons) & !is.null(contact_emails)) {
    contact_persons <- unlist(strsplit(contact_persons, ";"))
    contact_emails  <- unlist(strsplit(contact_emails, ";")) 
    if(length(contact_persons) == length(contact_emails)) {
      contact_text <- paste0(contact_persons, " (", contact_emails, ")", collapse=", ")
    } else {
      contact_text <- paste0(paste0(contact_persons, collapse=", "), " (", paste0(contact_emails, collapse=", "), ")")
    }
  } else if(!is.null(contact_persons)) {
    contact_text <- paste(contact_persons, collapse=", ")
  } else if(!is.null(contact_emails)) {
    contact_text <- paste(contact_emails, collapse=", ")
  }
  
  system(paste0("echo \"**Contact Person(s):** ", contact_text, "\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  provider_name <- service_metadata[[i]][["provider"]][["name"]]
  provider_url  <- service_metadata[[i]][["provider"]][["url"]]
  
  if(!is.null(provider_name) & !is.null(provider_url)) {
    if(length(provider_name) > 0 & length(provider_url)) {
      provider_text <- paste0("[", provider_name, "](", provider_url, ")")
      system(paste0("echo \"**Provider Institute:** ", provider_text, "\" >> ", target))
    }
  } else if(!is.null(provider_name)) {
    provider_text <- provider_name
    system(paste0("echo \"**Provider Institute:** ", provider_text, "\" >> ", target))
  } else if(!is.null(provider_url)) {
    provider_text <- paste0("[", provider_url, "](", provider_url, ")")
    system(paste0("echo \"**Provider Institute:** ", provider_text, "\" >> ", target))
  }
  
  system(paste0("echo \"\" >> ", target))
  
  
  #### VHP4Safety Documentation
  
  system(paste0("echo \"## Documentation\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  system(paste0("echo \"#### VHP4Safety Documentation\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  # Intro 
  if (!is.null(service_metadata[[i]][["intro"]][["title"]]) & !is.null(service_metadata[[i]][["intro"]][["url"]])) {
    titles  <- unlist(strsplit(service_metadata[[i]][["intro"]][["title"]], ";"))
    urls    <- unlist(strsplit(service_metadata[[i]][["intro"]][["url"]], ";"))
    if (length(titles) > 1 | length(urls) > 1) {
      if (length(titles) == length(urls)) {
        res <- paste0("[", titles, "](", urls, ")")
        res <- paste(res, collapse=", ")
        system(paste0("echo \"* Service Introduction: ", res, "\" >> ", target))
      } else {
        res <- paste0("[", urls, "](", urls, ")", collapse=", ")
        system(paste0("echo \"* Service Introduction: ", res, "\" >> ", target))
      }
    } else {
      system(paste0("echo \"* Service Introduction: [", service_metadata[[i]][["intro"]][["title"]], "](", service_metadata[[i]][["intro"]][["url"]], ") \" >> ", target))
    }
  } else {
    system(paste0("echo \"* Service Introduction: To be added\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Workflow
  if (!is.null(service_metadata[[i]][["workflow"]][["title"]]) & !is.null(service_metadata[[i]][["workflow"]][["url"]])) {
    titles  <- unlist(strsplit(service_metadata[[i]][["workflow"]][["title"]], ";"))
    urls    <- unlist(strsplit(service_metadata[[i]][["workflow"]][["url"]], ";"))
    if (length(titles) > 1 | length(urls) > 1) {
      if (length(titles) == length(urls)) {
        res <- paste0("[", titles, "](", urls, ")")
        res <- paste(res, collapse=", ")
        system(paste0("echo \"* Workflow: ", res, "\" >> ", target))
      } else {
        res <- paste0("[", urls, "](", urls, ")", collapse=", ")
        system(paste0("echo \"* Workflow: ", res, "\" >> ", target))
      }
    } else {
      system(paste0("echo \"* Workflow: [", service_metadata[[i]][["workflow"]][["title"]], "](", service_metadata[[i]][["workflow"]][["url"]], ") \" >> ", target))
    }
  } else {
    system(paste0("echo \"* Workflow: To be added\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Demo
  if (!is.null(service_metadata[[i]][["demo"]][["title"]]) & !is.null(service_metadata[[i]][["demo"]][["url"]])) {
    titles  <- unlist(strsplit(service_metadata[[i]][["demo"]][["title"]], ";"))
    urls    <- unlist(strsplit(service_metadata[[i]][["demo"]][["url"]], ";"))
    if (length(titles) > 1 | length(urls) > 1) {
      if (length(titles) == length(urls)) {
        res <- paste0("[", titles, "](", urls, ")")
        res <- paste(res, collapse=", ")
        system(paste0("echo \"* Demo: ", res, "\" >> ", target))
      } else {
        res <- paste0("[", urls, "](", urls, ")", collapse=", ")
        system(paste0("echo \"* Demo: ", res, "\" >> ", target))
      }
    } else {
      system(paste0("echo \"* Demo: [", service_metadata[[i]][["demo"]][["title"]], "](", service_metadata[[i]][["demo"]][["url"]], ") \" >> ", target))
    }
  } else {
    system(paste0("echo \"* Demo: To be added\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Adding the text for TeSS communication.
  add_tess_html(id=service_metadata[[i]][["id"]], target=target)
  system(paste0("echo \"\" >> ", target))
  
  system(paste0("echo \"## VHP4Safety Service Metadata\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  ## VHP4Safety Service Metadata
  
  # Stage
  if (!is.null(service_metadata[[i]][["stage"]])) {
    system(paste0("echo \"* Stage: ", service_metadata[[i]][["stage"]], "\" >> ", target))
  } else {
    system(paste0("echo \"* Stage: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Sub-Stage
  if (!is.null(service_metadata[[i]][["stage"]])) {
    system(paste0("echo \"* Sub-Stage: ", service_metadata[[i]][["substage"]], "\" >> ", target))
  } else {
    system(paste0("echo \"* Sub-Stage: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Development Cloud
  if (!is.null(service_metadata[[i]][["instance"]][["url"]])) {
    system(paste0("echo \"* Development Cloud: [", service_metadata[[i]][["instance"]][["url"]], "](", service_metadata[[i]][["instance"]][["url"]], ") \" >> ", target))
  } else {
    system(paste0("echo \"* Development Cloud: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Login
  if (!is.null(service_metadata[[i]][["access"]][["login"]])) {
    system(paste0("echo \"* Login Required: ", service_metadata[[i]][["access"]][["login"]], "\" >> ", target))
  } else {
    system(paste0("echo \"* Login Required: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # TRL
  if (!is.null(service_metadata[[i]][["instance"]][["TRL"]])) {
    system(paste0("echo \"* TRL: ", service_metadata[[i]][["instance"]][["TRL"]], "\" >> ", target))
  } else {
    system(paste0("echo \"* TRL: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Type
  if (!is.null(service_metadata[[i]][["instance"]][["type"]])) {
    system(paste0("echo \"* Type: ", service_metadata[[i]][["instance"]][["type"]], "\" >> ", target))
  } else {
    system(paste0("echo \"* Type: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Contact
  if (!is.null(service_metadata[[i]][["provider"]][["contact"]][["name"]]) & !is.null(service_metadata[[i]][["provider"]][["contact"]][["email"]])) {
    system(paste0("echo \"* Contact: ", service_metadata[[i]][["provider"]][["contact"]][["name"]], " (", service_metadata[[i]][["provider"]][["contact"]][["email"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* Contact: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # API Type
  if (!is.null(service_metadata[[i]][["access"]][["API"]])) {
    system(paste0("echo \"* API Type: ", service_metadata[[i]][["access"]][["API"]], "\" >> ", target))
  } else {
    system(paste0("echo \"* API Type: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Categories
  # if (!is.null(service_metadata[[i]][["access"]][["API"]])) {
  #   system(paste0("echo \"* API Type: ", service_metadata[[i]][["access"]][["API"]], "\" >> ", target))
  # } else {
  # system(paste0("echo \"* Categories: To be added\" >> ", target))
  # }
  # system(paste0("echo \"\" >> ", target))
  
  # Categories
  # if (!is.null(service_metadata[[i]][["access"]][["API"]])) {
  #   system(paste0("echo \"* API Type: ", service_metadata[[i]][["access"]][["API"]], "\" >> ", target))
  # } else {
  system(paste0("echo \"* Categories: To be added\" >> ", target))
  # }
  system(paste0("echo \"\" >> ", target))
  
  # Targeted Users
  # if (!is.null(service_metadata[[i]][["access"]][["API"]])) {
  #   system(paste0("echo \"* API Type: ", service_metadata[[i]][["access"]][["API"]], "\" >> ", target))
  # } else {
  system(paste0("echo \"* Targeted Users: To be added\" >> ", target))
  # }
  system(paste0("echo \"\" >> ", target))
  
  # Relevant VHP4Safety Use Case
  # if (!is.null(service_metadata[[i]][["access"]][["API"]])) {
  #   system(paste0("echo \"* API Type: ", service_metadata[[i]][["access"]][["API"]], "\" >> ", target))
  # } else {
  system(paste0("echo \"* Relevant VHP4Safety Use Case: To be added\" >> ", target))
  # }
  system(paste0("echo \"\" >> ", target))
  
  ## Technical Tool Specifications
  system(paste0("echo \"## Technical Tool Specifications\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  # Provider
  if (!is.null(service_metadata[[i]][["provider"]][["name"]]) & !is.null(service_metadata[[i]][["provider"]][["url"]])) {
    system(paste0("echo \"* Provider: [", service_metadata[[i]][["provider"]][["name"]], "](", service_metadata[[i]][["provider"]][["url"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* Provider: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Citation
  if (!is.null(service_metadata[[i]][["doi"]])) {
    system(paste0("echo \"* Citation: [", service_metadata[[i]][["doi"]], "](https://doi.org/", service_metadata[[i]][["doi"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* Citation: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Version
  if (!is.null(service_metadata[[i]][["instance"]][["version"]])) {
    system(paste0("echo \"* Version: ", service_metadata[[i]][["instance"]][["version"]], "\" >> ", target))
  } else {
    system(paste0("echo \"* Version: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # License
  if (!is.null(service_metadata[[i]][["instance"]][["license"]])) {
    system(paste0("echo \"* License: ", service_metadata[[i]][["instance"]][["license"]], "\" >> ", target))
  } else {
    system(paste0("echo \"* License: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Source Code
  if (!is.null(service_metadata[[i]][["instance"]][["source"]])) {
    system(paste0("echo \"* Source Code: [", service_metadata[[i]][["instance"]][["source"]], "](", service_metadata[[i]][["instance"]][["source"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* Source Code: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Docker
  if (!is.null(service_metadata[[i]][["instance"]][["docker"]])) {
    system(paste0("echo \"* Docker: [", service_metadata[[i]][["instance"]][["docker"]], "](", service_metadata[[i]][["instance"]][["docker"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* Docker: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Bio.tools
  if (!is.null(service_metadata[[i]][["ELIXIR"]][["biotools"]])) {
    system(paste0("echo \"* Bio.tools: [", service_metadata[[i]][["ELIXIR"]][["biotools"]], "](https://bio.tools/", service_metadata[[i]][["ELIXIR"]][["biotools"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* Bio.tools: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # FAIRsharing
  if (!is.null(service_metadata[[i]][["ELIXIR"]][["fairsharing"]])) {
    system(paste0("echo \"* FAIRsharing: [", service_metadata[[i]][["ELIXIR"]][["fairsharing"]], "](", service_metadata[[i]][["ELIXIR"]][["fairsharing"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* FAIRsharing: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # TeSS
  if (!is.null(service_metadata[[i]][["ELIXIR"]][["tess"]])) {
    system(paste0("echo \"* TeSS: [", service_metadata[[i]][["ELIXIR"]][["tess"]], "](", service_metadata[[i]][["ELIXIR"]][["tess"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* TeSS: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # RSD
  if (!is.null(service_metadata[[i]][["Other"]][["rsd"]])) {
    system(paste0("echo \"* RSD: [", service_metadata[[i]][["Other"]][["rsd"]], "](", service_metadata[[i]][["Other"]][["rsd"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* RSD: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Wikipedia
  if (!is.null(service_metadata[[i]][["Other"]][["wikipedia"]])) {
    system(paste0("echo \"* Wikipedia: [", service_metadata[[i]][["Other"]][["wikipedia"]], "](", service_metadata[[i]][["Other"]][["wikipedia"]], ")\" >> ", target))
  } else {
    system(paste0("echo \"* Wikipedia: Not available\" >> ", target))
  }
  system(paste0("echo \"\" >> ", target))
  
  # Adding the last script part.
  add_script(data=service_metadata, id=names(service_metadata[i]), target=target)
}
