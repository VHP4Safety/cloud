// Copyright (C) 2025 Egon Willighagen
// License: MIT

// groovy createMarkdown.groovy *.json

import groovy.json.JsonSlurper
import groovy.io.FileType

def list = []

def dir = new File("docs/service")
dir.eachFileRecurse (FileType.FILES) { file ->
  if (file.name.endsWith(".json") && file.name != "template.json") {
    list << file
  }
}
list = list.sort()

println "@prefix dc:      <http://purl.org/dc/elements/1.1/> ."
println "@prefix dcterms: <http://purl.org/dc/terms/> ."
println "@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> ."
println "@prefix schema:    <https://schema.org/> ."
println "@prefix foaf:    <http://xmlns.com/foaf/0.1/> ."
println ""

resourceNS = "https://resource.cloud.vhp4safety.nl/service/"
resourceTypeNS = "${resourceNS}/type/"
println "@prefix resource: <${resourceNS}> ."
println "@prefix resType: <${resourceTypeNS}> ."

list.each { file ->
  fileContents = file.text
  def data = new JsonSlurper().parseText(fileContents)

  id = data.id
  resourceIRI = "resource:" + id
  
  println "${resourceIRI} a schema:CreativeWork ;"
  if (data.description) println "  dcterms:description \"${data.description}\"@en ;"
  if (data.url) println "  foaf:webpage <${data.url}> ;"
  if (data.instance) {
    println "  resource:hasInstance ${resourceIRI}-instance ;"
    instanceRDF = "${resourceIRI}-instance a schema:CreativeWork ;"
    if (data.instance.type) instanceRDF += "  a resType:${data.instance.type} ."
  }
  if (data.provider) {
    println "  resource:hasProvider ${resourceIRI}-provider ;"
    providerRDF = "${resourceIRI}-provider "
    if (data.provider.contact) {
      providerRDF += "a foaf:Person "
      if (data.provider.contact.name ) providerRDF += ";\n  foaf:name \"${data.provider.contact.name}\" "
      if (data.provider.contact.email) providerRDF += ";\n  foaf:email \"${data.provider.contact.email}\" "
    } else {
      providerRDF += "a foaf:Organisation "
      if (data.provider.url ) providerRDF += ";\n  foaf:page \"${data.provider.url}\" "
    }
    providerRDF += ".\n"
  }
  if (data.service) println "  rdfs:label \"${data.service}\"@en ."

  println ""
  println instanceRDF
  println ""
  println providerRDF
  println ""
}
