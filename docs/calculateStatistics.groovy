// Copyright (C) 2023  Egon Willighagen
// License: MIT

// groovy createMarkdown.groovy *.json

import groovy.json.JsonSlurper
import groovy.io.FileType

def list = []

def dir = new File("service")
dir.eachFileRecurse (FileType.FILES) { file ->
  if (file.name.endsWith(".json") && file.name != "template.json") {
    list << file
  }
}
list = list.sort()

serviceCount = 0
idCount = 0
descriptionCount = 0
urlCount = 0
doiCount = 0
providerContactCount = 0
providerEmailCount = 0
demoCount = 0
elixirBioToolsCount = 0
elixirTeSSCount = 0
elixirFAIRsharingCount = 0

def asTwoDecimalPercentage(hits, total) {
  return ((int)((hits/total)*100.0));
}

list.each { file ->
  fileContents = file.text
  def data = new JsonSlurper().parseText(fileContents)
  serviceCount++
  if (data.id != null && data.id != "") idCount++
  if (data.description != null && data.description != "") descriptionCount++
  if (data.url != null && data.url != "") urlCount++
  if (data.doi != null && data.doi != "") doiCount++
  if (data.provider != null && data.provider.contact != null &&
      data.provider.contact.name != null && data.provider.contact.name != "") providerContactCount++
  if (data.provider != null && data.provider.contact != null &&
      data.provider.contact.email != null && data.provider.contact.email != "") providerEmailCount++
  if (data.demo != null && data.demo.url != "") demoCount++
  if (data.ELIXIR != null && data.ELIXIR.biotools != null &&
      data.ELIXIR.biotools != "") elixirBioToolsCount++
  if (data.ELIXIR != null && data.ELIXIR.tess != null &&
      data.ELIXIR.tess != "") elixirTeSSCount++
  if (data.ELIXIR != null && data.ELIXIR.fairsharing != null &&
      data.ELIXIR.fairsharing != "") elixirFAIRsharingCount++
}

println "Service: ${serviceCount}"
println "  ID: ${asTwoDecimalPercentage(idCount, serviceCount)}%"
println "  Description: ${asTwoDecimalPercentage(descriptionCount, serviceCount)}%"
println "  URL: ${asTwoDecimalPercentage(urlCount, serviceCount)}%"
println "  DOI: ${asTwoDecimalPercentage(doiCount, serviceCount)}%"
println "  Provider: name ${asTwoDecimalPercentage(providerContactCount, serviceCount)}%, email ${asTwoDecimalPercentage(providerEmailCount, serviceCount)}%"
println "  Demo: ${asTwoDecimalPercentage(demoCount, serviceCount)}%"
println "  ELIXIR: Bio.tools ${asTwoDecimalPercentage(elixirBioToolsCount, serviceCount)}%, TeSS ${asTwoDecimalPercentage(elixirTeSSCount, serviceCount)}%, FAIRsharing ${asTwoDecimalPercentage(elixirFAIRsharingCount, serviceCount)}%"
