
# Requesting and Adding New Services to the Cloud Catalog

Welcome to the Cloud Repository of [the VHP4Safety project](https://vhp4safety.nl/). In this repository, we share [a catalog of services](https://cloud.vhp4safety.nl/catalog.html) that are deemed useful for the users of the VHP4Safety platform. The collection of these services is created based on the requests of the platform users and the project members, which is then presented at [cloud.vhp4safety.nl](https://cloud.vhp4safety.nl/).

In this document, you can find how to make a request for a service addition to the catalog or how to add a service using this repository. 


## 1. Requesting a Service Addition

As the first option, you can make a request for a service addition through our GitHub repository. Note that this requires you to have a GitHub account (see [here](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github) to see how to create a GitHub account). 

You can simply make a request for a service addition by filling the form in the issue tracker, found [here](https://github.com/VHP4Safety/cloud/issues/new?template=new-tool-service-entry.yml). In the form, you will be asked to fill in a few things about the service you request. The type of the information is explained briefly in the form, e.g., we ask you to enter `A brief description for the service` under the `Service description` field. 

In order to add the service correctly, some fields are essential to fill in. That is, we ask you kindly to fill at least the `Add a title`, `Name of the service`, `Service description`, and `Service website` fields. These aside, filling `Name of the provider` and `E-mail address of the provider` fields greatly help us to correctly create an entry on the catalog for the service you request. 


## 2. Adding a Service via the Cloud Repository

As the second option, you can create an entry in the Cloud repository yourself to add the service you request. Note that this option requires you to handle [creating your own fork of the repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo) and [making a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests). Also note that this option requires you to have a Github account (see [here](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github) to see how to create a GitHub account). Unless you are familiar with these, please consider using the first option, requesting a service addition, explained above.

In order to add a service yourself, please first create your own fork of the [Cloud repository](https://github.com/VHP4Safety/cloud). Then, you can add an entry for the service you request by creating a `.json` file based on the [`template.json`](https://github.com/VHP4Safety/cloud/blob/main/docs/service/template.json). You can then enter the information related to the service you are creating in the `.json` file you are generating. The type of information you need to enter is explained in the commented sections in the `template.json` file. Please be careful with the points below if you choose this option to create an entry in the cloud catalog: 

1. Do __NOT__ remove the `template.json` file.
2. Name the `.json` file you generate using the name of the service, e.g. `bridgedb.json`.
3. Save the `.json` file you generate in the `/docs/service/` directory in the repository. 

We kindly ask you to enter at least the `id`, `service`, `description` and `url` fields to create the entry in the catalog correctly. Please also note that filling the information under the `provider` field greatly helps us to create the entry. 

You are also kindly asked to add a logo for the service, if available, in the `.png` format. Should you choose to do this, please store the `.png` file in the `/docs/service/` directory and enter the name of the of the file in the `screenshot` field of the `.json` file you generate. 

Please see other `.json` files in the `/docs/service/` directory to see other `.json` files as an example (for instance, see [`bridgedb.json`](https://github.com/VHP4Safety/cloud/blob/main/docs/service/bridgedb.json)).

Creating just the `.json` file will be sufficient to add the service in the catalog as the necessary Markdown files are generated automatically through the GitHub actions. Therefore, once you generate the `.json` file for the service you request, making a pull request to the Cloud repository is enough. We will be notified about your request and merge it in the repository.


## 3. Requesting a Service by Contacting Work Package 1.1.

As the final option, you can contact Work Package 1.1 under [Research Line 1](https://www.sciencrew.com/c/6621/a/329042509?title=RL1__Building_the_Virtual_Human_Platform) to make a request for a service. You can contact ozan.cinar@maastrichtuniversity.nl to make the request. You will then be asked the information that is necessary to create an entry in the catalog for the service you request and an issue will be created in the Cloud repository based on the information you provide. 

Please note that we ask you to take this option only if the two previous options are not available for you. We prefer to keep the person who requested or created the service in the version controlling enabled by GitHub to be able to keep track of changes in the repository. 

