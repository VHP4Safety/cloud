# WikiPathways - AOP Portal

<!--- This file is autogenerated. Edit wikipathways_aop.json to make changes in this page. --->

An Adverse Outcome Pathway (AOP) portal for WikiPathways to highlight the molecular basis of AOPs or events in AOPs.

![WikiPathways - AOP Portal logo](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/wikipathways_aop.png)

## Documentation

* Service Introduction: To be added

* Workflow: To be added

* Demo: To be added

<h4 id='tess-widget-materials-header'></h4>

<div id='tess-widget-materials-list' class='tess-widget tess-widget-list'></div>
<script>
  function initTeSSWidgets() {
    var query = 'wikipathways_aop';
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

* Stage: <span class="glossary_term">[https://vhp4safety.github.io/glossary#VHP0000102](https://vhp4safety.github.io/glossary#VHP0000102)</span>

* Sub-stage: <span class="glossary_term">[https://vhp4safety.github.io/glossary#VHP0000023](https://vhp4safety.github.io/glossary#VHP0000023)</span>

* Development Cloud: Not available

* Login Required: No

* TRL: Not available

* Type: internal

* Contact: Marvin Martens (marvin.martens@maastrichtuniversity.nl)

* API Type: SPARQL

* Categories: To be added

* Targeted Users: To be added

* Relevant VHP4Safety Use Case: To be added

## Technical Tool Specifications

* Provider: [Maastricht University]()

* Citation: [10.3389/fgene.2018.00661](https://doi.org/10.3389/fgene.2018.00661)

* Version: Not available

* License: [CC0](https://creativecommons.org/share-your-work/public-domain/cc0/)

* Source Code: Not available

* Docker: Not available

* Bio.tools: [wikipathways](wikipathways)

* FAIRsharing: Not available

* TeSS: [WikiPathways](WikiPathways)

* RSD: Not available

* Wikipedia: [WikiPathways](WikiPathways)

<script type="application/ld+json">
  {
    "@context": "https://schema.org/",
    "@type": "SoftwareApplication",
    "http://purl.org/dc/terms/conformsTo": {
      "@type": "CreativeWork", "@id": "https://bioschemas.org/profiles/ComputationalTool/1.0-RELEASE"
    },
    "@id" : "https://vhp4safety.github.io/cloud/service/wikipathways_aop",
    "name": "WikiPathways - AOP Portal",
    "description": "An Adverse Outcome Pathway (AOP) portal for WikiPathways to highlight the molecular basis of AOPs or events in AOPs.",
    "url": "https://aop.wikipathways.org/"
  }
</script>
