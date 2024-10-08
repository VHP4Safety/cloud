// License: MIT

// groovy createMarkdown.groovy *.json

import groovy.json.JsonSlurper
import groovy.io.FileType

println """
![https://vhp4safety.nl](VHP-LOGO-100mm-RGB.png "The VHP4Safety Project is a Dutch NWO-funded research collaboration")

# VHP4Safety Cloud catalog - Persona 1

<!-- THIS FILE IS AUTOGENERATED. DO NOT EDIT. -->

Below you find an overview of services available in the context of the VHP4Safety Platform.
[Additional services have been suggested](https://github.com/VHP4Safety/cloud/labels/service)
and users can [request additional services](https://github.com/VHP4Safety/cloud/issues/new/choose).
"""

def list = []

def dir = new File("service")
dir.eachFileRecurse (FileType.FILES) { file ->
    if (file.name.endsWith(".json") && file.name != "template.json") {
    list << file
  }
}

list = list.sort()

/* list.each { file ->
  fileContents = file.text
  def data = new JsonSlurper().parseText(fileContents)
  print "[${data.service}](#${data.id}) "
}
println "\n" */

for (item in list) {
  fileContents = item.text
  def data = new JsonSlurper().parseText(fileContents)
  if (data.VHPpersona)
    if (data.VHPpersona.persona1 == "true") {
      logo = ""
      if (data.screenshot) logo = "![${data.service} logo](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/${data.screenshot} \"Click on the image to go to the service\")\n"
    println """-------------------------------------------------------------------------------
${logo}
## ${data.service}

${data.description} [[more info](service/${data.id}.md)]

"""
      }
  }

println """
### Funding

VHP4Safety – the Virtual Human Platform for safety assessment project [NWA 1292.19.272](https://www.nwo.nl/projecten/nwa129219272) is part of the NWA research program ‘Research along Routes by Consortia (ORC)’, which is funded by the Netherlands Organization for Scientific Research
(NWO). The project started on June 1, 2021 with a budget of over 10 million Euros and will last for the duration of 5 years."""
