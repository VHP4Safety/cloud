# European Medicines Agency Documents

<!-- this file is autogenerated. edit ema_documents.json instead -->

An online repository of official reports from the European Medicines Agency.

![screenshot of %service%](https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/ema_documents.png "Click on the image to go to the service")

## Documentation

#### VHP4Safety Documentation

* Service introduction: []()
* Workflow: []()
* Demo: []()

<h4 id="tess-widget-materials-header"></h4>

<div id="tess-widget-materials-list" class="tess-widget tess-widget-list"></div>
<script>
function initTeSSWidgets() {
    var query = '';
    if (query.trim() != "") {
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
        document.getElementById('tess-widget-materials-header').innerHTML = "Documentation from ELIXIR TeSS"
    }
}
</script>
<script async="" defer="" src="https://elixirtess.github.io/TeSS_widgets/components/js/tess-widget-standalone.js" onload="initTeSSWidgets()"></script>

##  Service Metadata

*  cloud: [https://www.ema.europa.eu/en/search](https://www.ema.europa.eu/en/search) []()
* Login required: no
* Implementation status: 
* TRL: 
* Type: -
* Contact:  
* API Type: 
* Categories: -
* Targeted users: -
* Relevant VHP4Safety Use case: -

## Technical tool specifications

* Provided by: European Medicines Agency ([https://www.ema.europa.eu/](https://www.ema.europa.eu/))
* Citation: 
* Version: 
* License: 
* Source Code: 
* Docker: 
* Bio.tools: 
* FAIRsharing: 
* TeSS: 
* RSD: 
* Wikipedia: 

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
