# Kubernetes for Windows Walkthroughs

This repo has step by step walkthroughs for two different use cases of Windows containers running on Kubernetes.

1. Lift & shift of an existing .Net Framework app using SQL Server
2. Starting a new application using devops tooling with Draft+Helm from the start

If you're reading this from Kubecon North America 2018, [click here](https://github.com/PatrickLang/kkna2018lab) for instructions on how to connect to your lab VM.

> After connecting, there are some important steps to get your KUBECONFIG. Keep reading on that repo to make sure you don't miss anything.

If you missed the session at Kubecon but want to build a similar lab for your team, check out the [LabVM](https://github.com/PatrickLang/KubernetesForWindowsTutorial/tree/master/LabVm) folder here for info on how they were set up.


## Tutorial 1 - Lift & Shift

This is an example "lift & shift" deployment that's been moved into a modern deployment workflow with no substantial changes to the app. It builds from a traditional build server with the Visual Studio 2017 command line tools, and is packaged up with Docker.

This works well as a cross-platform demo since premade containers are available for Microsoft SQL Server on Linux, and the web app remains on Windows.

This was deployed once by hand using the YAML files in k8s/*

It was also used as part of a build & release pipeline using the Helm chart in charts/fabrikamfiber

Source: [FabrikamFiber](https://github.com/PatrickLang/fabrikamfiber/tree/helm-2019-mssql-linux)

## Tutorial 2 - Creating a new app and deploying with Draft and Helm

This is a step by step guide to creating a new .Net Core app using a built-in template, along with Draft to scaffold it to Kubernetes.

Once you're logged into the Lab VM, visit [DraftWalkthrough](./DraftWalkthrough/README.md) for the step-by-step guide.


## Tutorial 3 - DevOps workflow with Draft and .Net Core


This is currently set up with Draft to build and run entirely in Windows containers.

Source: [eShopOnWeb](https://github.com/PatrickLang/eShopOnWeb/tree/patricklang/k8s-win#running-the-sample-on-kubernetes-using-draft)


## References

### Tools Used

ACS-Engine - [Getting started guide for Windows clusters](http://aka.ms/windowscontainers/kubernetes) is usually the right place to start. I did a lot of last minute work to move this forward to Windows Server 2019. Right now there isn't a known-good release that's been fully tested with Windows Server 2019, so I'll share the one I used

Helm - no changes

Draft - no changes

New draft packs were put together and are at https://github.com/patricklang/WindowsDraftPacks

### Azure DevTest Labs

This was used to automate rolling out the VMs. It makes it easy to deploy an existing VM, and add extra artifacts to it. It can also handle checkout/check-in of shared VMs but I didn't use that. I used the "Run PowerShell script" artifact to run the script in the gist above. Running unsigned code from GitHub is a bad idea, so you should copy the scripts and use a secured storage account instead. 


### Lab VM Setup
"Windows Server 2019 Datacenter with Containers" was used in Azure VMs. "with Containers" is not the Windows product name, it's just the VM in Azure that has Docker preinstalled and the base Windows images pulled. This saves >10 minutes of deployment time. It also puts VMs behind a NAT by default which saves time allocating public IPs.

If you're looking for a way to build your own VM for local use, check out these Packer scripts https://github.com/StefanScherer/packer-windows which build something similar

This set of scripts was run inside the VM to install all needed dev tools for the class including Visual Studio 2017, VSCode, Kubectl, Helm, and Draft https://github.com/PatrickLang/KubernetesForWindowsTutorial/tree/master/LabVm
