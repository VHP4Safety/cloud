# CDK Depict

A webservice the converts a SMILES into 2D depictions (SVG or PNG).

<img width="300" align="right"
     alt="screenshot of the service" 
     src="cdkdepict.png">
## VHP4Safety Service

* Development cloud: [https://cdkdepict.cloud.vhp4safety.nl/](https://cdkdepict.cloud.vhp4safety.nl/)
* Login required: No
* Implementation status: 
* TLR: TRL 8 - system complete and qualified
* Type: -
* Contact: Egon Willighagen
* API Type: REST
* Categories: -
* Targeted users: -
* Relevant VHP4Safety Use case: -

## Tool specifications

* Provided by: simolecule
* Citation: [https://doi.org/10.1186/s13321-017-0220-4](https://doi.org/10.1186/s13321-017-0220-4)
* Version: 1.9.2
* License: LGPL 2.1
* Source Code: [https://github.com/cdk/depict](https://github.com/cdk/depict)
* Docker: [https://hub.docker.com/r/simolecule/cdkdepict](https://hub.docker.com/r/simolecule/cdkdepict)
* Bio.tools: [https://bio.tools/cdk_depict](https://bio.tools/cdk_depict)
* TeSS: -

## Tool integration

- [ ] Utilises the VHP4Safety APIs to ensure that each service is accessible to our proposed interoperability layer.
- [ ] Is annotated according to the semantic interoperability layer concept using defined ontologies.
- [ ] Is containerised for easy deployment in virtual environments of VHP4Safety instances.
- [ ] Has documented scientific and technical background.
- [x] Is deployed into the VHP4Safety development environment.
- [ ] Is deployed into the VHP4Safety production environment.
- [x] Is listed in the VHP4Safety discovery services.
- [ ] Is listed in other central repositories like eInfraCentral, bio.tools and TeSS (ELIXIR).
- [ ] Provides legal and ethical statements on how the service can be used.

<script type="application/ld+json">
{
  "@context": "https://schema.org/",
  "@type": "SoftwareApplication",
  "http://purl.org/dc/terms/conformsTo": {
      "@type": "CreativeWork", "@id": "https://bioschemas.org/profiles/ComputationalTool/1.0-RELEASE"
  },
  "@id" : "https://vhp4safety.github.io/cloud/service/cdkdepict",
  "name": "CDK Depict", 
  "description": "A webservice the converts a SMILES into 2D depictions (SVG or PNG).",
  "url": "https://cdkdepict.cloud.vhp4safety.nl/",
  "softwareVersion": "1.9.2",
  "license": "https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html"
}
</script>
