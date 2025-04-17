// Copyright (C) 2025  Egon Willighagen
// License: MIT

// groovy createMarkdown.groovy *.json

import groovy.json.JsonSlurper
import groovy.io.FileType

println """ID\tName\tURL\tCloudURL"""

def list = []

def dir = new File("docs/service")
dir.eachFileRecurse (FileType.FILES) { file ->
  if (file.name.endsWith(".json") && file.name != "template.json") {
    list << file
  }
}
list = list.sort()

list.each { file ->
  fileContents = file.text
  def data = new JsonSlurper().parseText(fileContents)
  println """${data.id}\t${data.service}\t${data.url}\thttps://cloud.vhp4safety.nl/service/${data.id}.html"""
}
