// Copyright (C) 2025  Egon Willighagen
// License: MIT

@Grab(group='io.github.egonw.bacting', module='managers-ui', version='1.0.0')
@Grab(group='io.github.egonw.bacting', module='managers-rdf', version='1.0.0')

import java.text.SimpleDateFormat;
import java.util.Date;

workspaceRoot = ".."
ui = new net.bioclipse.managers.UIManager(workspaceRoot);
bioclipse = new net.bioclipse.managers.BioclipseManager(workspaceRoot);
rdf = new net.bioclipse.managers.RDFManager(workspaceRoot);


input = "/cloud/cloud.ttl"

store = rdf.createInMemoryStore()
rdf.importFile(store, input, "TURTLE")

sparql = """
PREFIX dc:      <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX rdfs:    <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema:    <https://schema.org/>
PREFIX foaf:    <http://xmlns.com/foaf/0.1/>

PREFIX resource: <https://resource.cloud.vhp4safety.nl/service/>
PREFIX resType: <https://resource.cloud.vhp4safety.nl/service//type/>


SELECT DISTINCT ?serviceLabel ?contact ?email WHERE {
  ?instance a resType:internal ; ^resource:hasInstance ?service .
  ?service rdfs:label ?serviceLabel .
  OPTIONAL {
    ?service resource:hasProvider ?provider .
    OPTIONAL { ?provider foaf:name ?contact }
    OPTIONAL { ?provider foaf:email ?email }
  }
}
"""

results = rdf.sparql(store, sparql)

outputFile = "/cloud/internalServices.tsv"
ui.renewFile(outputFile)

for (int col=1; col<=results.getColumnCount(); col++) {
  String result = results.getColumnName(col);
  ui.append(outputFile, (String)(result == null ? "" : result))
  if (col<results.getColumnCount()) ui.append(outputFile, (String)"\t");
}
ui.append(outputFile, (String)"\n")
for (int row=1; row<=results.getRowCount(); row++) {
  for (int col=1; col<=results.getColumnCount(); col++) {
    cellContent = results.get(row,col)
    ui.append(outputFile, (String)(cellContent == null ? "" : cellContent))
    if (col<results.getColumnCount()) ui.append(outputFile, (String)"\t")
  }
  ui.append(outputFile, (String)"\n")
}
