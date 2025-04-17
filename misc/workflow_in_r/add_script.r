
add_script <- function(data, id, target) {
  system(paste0('echo \"<script type=\\"application/ld+json\\">\" >> ', target))
  system(paste0('echo \"  {\" >> ', target))
  system(paste0('echo \"    \\"@context\\": \\"https://schema.org/\\",\" >> ', target))
  system(paste0('echo \"    \\"@type\\": \\"SoftwareApplication\\",\" >> ', target))
  system(paste0('echo \"    \\"http://purl.org/dc/terms/conformsTo\\": {\" >> ', target))
  system(paste0('echo \"      \\"@type\\": \\"CreativeWork\\", \\"@id\\": \\"https://bioschemas.org/profiles/ComputationalTool/1.0-RELEASE\\"\" >> ', target))
  system(paste0('echo \"    },\" >> ', target))
  system(paste0('echo \"    \\"@id\\" : \\"https://vhp4safety.github.io/cloud/service/', data[[id]][["id"]], '\\",\" >> ', target))
  system(paste0('echo \"    \\"name\\": \\"', data[[id]][["service"]], '\\",\" >> ', target))
  system(paste0('echo \"    \\"description\\": \\"', data[[id]][["description"]], '\\",\" >> ', target))
  system(paste0('echo \"    \\"url\\": \\"', data[[id]][["instance"]][["url"]], '\\"\" >> ', target))
  system(paste0('echo \"  }\" >> ', target))
  system(paste0('echo \"</script>\" >> ', target))
}

