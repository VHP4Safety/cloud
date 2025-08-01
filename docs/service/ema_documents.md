# European Medicines Agency Documents

<!--- This file is autogenerated. Edit ema_documents.json to make changes in this page. --->

An online repository of official reports from the European Medicines Agency.

![European Medicines Agency Documents logo](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/ema_documents.png)

## Documentation

* Service Introduction: To be added

* Workflow: To be added

* Demo: To be added

<h4 id='tess-widget-materials-header'></h4>

<div id='tess-widget-materials-list' class='tess-widget tess-widget-list'></div>
<script>
  function initTeSSWidgets() {
    var query = 'ema_documents';
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

* Stage: <span class="glossary_term">[external exposure](external exposure)</span>

* Sub-stage: <span class="glossary_term">[compound characteristics](compound characteristics)</span>

* Development Cloud: Not available

* Login Required: no

* TRL: Not available

* Type: Not available

* Contact: Not available

* API Type: Not available

* Categories: To be added

* Targeted Users: To be added

* Relevant VHP4Safety Use Case: To be added

## Technical Tool Specifications

* Provider: [European Medicines Agency](https://www.ema.europa.eu/)

* Citation: Not available

* Version: Not available

* License: Not available

* Source Code: Not available

* Docker: Not available

* Bio.tools: Not available

* FAIRsharing: Not available

* TeSS: Not available

* RSD: Not available

* Wikipedia: Not available

<script type="application/ld+json">
  {
    "@context": "https://schema.org/",
    "@type": "SoftwareApplication",
    "http://purl.org/dc/terms/conformsTo": {
      "@type": "CreativeWork", "@id": "https://bioschemas.org/profiles/ComputationalTool/1.0-RELEASE"
    },
    "@id" : "https://vhp4safety.github.io/cloud/service/ema_documents",
    "name": "European Medicines Agency Documents",
    "description": "An online repository of official reports from the European Medicines Agency.",
    "url": "https://www.ema.europa.eu/en/search"
  }
</script>
