# BridgeDb

<!--- This file is autogenerated. Edit bridgedb.json to make changes in this page. --->

A framework to map identifiers between various biological databases and related sources.

![BridgeDb logo](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/bridgedb.png)

## Documentation

* Service Introduction: [BridgeDb: Mapping Gene Identifiers](https://docs.vhp4safety.nl/en/latest/tutorials/bridgedb/gene_hgnc_name_to_ensembl.html)

* Workflow: [Information about chemicals](https://docs.vhp4safety.nl/en/latest/tutorials/cheminfo/intro.html)

* Demo: To be added

<h4 id='tess-widget-materials-header'></h4>

<div id='tess-widget-materials-list' class='tess-widget tess-widget-list'></div>
<script>
  function initTeSSWidgets() {
    var query = 'bridgedb';
    if (query.trim() != '') {
      TessWidget.Materials(document.getElementById('tess-widget-materials-list'),
                           'SimpleList',
                           {
                             opts: {
                               enableSearch: false
                             },
                             params: {
                               pageSize: 5,
                               q: query
                             }
                           });
      document.getElementById('tess-widget-materials-header').innerHTML = 'Documentation from ELIXIR TeSS'
    }
}
</script>
<script async='' defer='' src='https://elixirtess.github.io/TeSS_widgets/components/js/tess-widget-standalone.js' onload='initTeSSWidgets()'></script>


## VHP4Safety Service Metadata

* Stage: <span class="glossary_term">[https://vhp4safety.github.io/glossary#VHP0000149](https://vhp4safety.github.io/glossary#VHP0000149)</span>

* Sub-stage: <span class="glossary_term">[https://vhp4safety.github.io/glossary#VHP0000047](https://vhp4safety.github.io/glossary#VHP0000047)</span>

* Development Cloud: [https://bridgedb.cloud.vhp4safety.nl/](https://bridgedb.cloud.vhp4safety.nl/)

* Login Required: no

* TRL: Not available

* Type: internal

* Contact: Egon Willighagen ()

* API Type: REST

* Categories: To be added

* Targeted Users: To be added

* Relevant VHP4Safety Use Case: To be added

## Technical Tool Specifications

* Provider: [Dept. of Bioinformatics - BiGCaT, NUTRIM, Maastricht University]()

* Citation: [10.1186/1471-2105-11-5](https://doi.org/10.1186/1471-2105-11-5)

* Version: 2.3.3

* License: Apache-2.0

* Source Code: [https://github.com/bridgedb/BridgeDb](https://github.com/bridgedb/BridgeDb)

* Docker: [https://hub.docker.com/r/bigcatum/bridgedb](https://hub.docker.com/r/bigcatum/bridgedb)

* Bio.tools: [bridgedb](bridgedb)

* FAIRsharing: [10.25504/FAIRsharing.5ry74y](10.25504/FAIRsharing.5ry74y)

* TeSS: [bridgedb](bridgedb)

* RSD: [bridgedb-java](bridgedb-java)

* Wikipedia: Not available

<script type="application/ld+json">
  {
    "@context": "https://schema.org/",
    "@type": "SoftwareApplication",
    "http://purl.org/dc/terms/conformsTo": {
      "@type": "CreativeWork", "@id": "https://bioschemas.org/profiles/ComputationalTool/1.0-RELEASE"
    },
    "@id" : "https://vhp4safety.github.io/cloud/service/bridgedb",
    "name": "BridgeDb",
    "description": "A framework to map identifiers between various biological databases and related sources.",
    "url": "https://www.bridgedb.org/"
  }
</script>
