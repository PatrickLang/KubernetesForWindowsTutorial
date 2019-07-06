
## Prerequisites

- [.Net Core 2.2 SDK](https://dotnet.microsoft.com/download)
- Kubernetes cluster with Windows nodes
- A working container registry
  - If you're using Azure
    - [Set up ACR](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-azure-cli)
    - [Authenticate it to ACR](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-aks)
    - [Log in to ACR](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-azure-cli#log-in-to-registry) on your Windows machine
  - Otherwise, use `docker login` on your Windows machine, and be sure to set up a Kubernetes [image pull secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)
- [Windows Draft Pack](https://github.com/PatrickLang/WindowsDraftPacks)

### Installing the sample Windows & .Net Core draft pack

```
draft init
draft pack-repo add https://github.com/PatrickLang/WindowsDraftPacks
```


## Create a sample web app

First, make a new directory for the project. Name it something tasty :)

> Tip: Draft will use this directory name, including the case. Some Kubernetes objects are restricted to lowercase-only names. Using all lowercase here will help keep things from breaking later.

```powershell
mkdir jaffacake
cd jaffacake
```

Next, use `dotnet new` to create a new template project, then `draft create -p CSharpWindowsNetCore` to scaffold it.

```powershell
dotnet new mvc
draft create -p CSharpWindowsNetCore
```


## Update a few deployment parameters

Open the folder with Visual Studio code with `code .` (or another editor)

Find and modify `draft.toml`

1. Set the `namespace` to match the namespace you have access to
2. Add a line to set the ingress `set = ["ingress.enabled=true", "basedomain=test.ogfg.link"]`

Here's a full example: 

```toml
[environments]
  [environments.development]
    name = "jaffacake"
    namespace = "rascally"
    wait = true
    watch = false
    watch-delay = 2
    auto-connect = false
    dockerfile = "Dockerfile"
    chart = ""
    set = ["ingress.enabled=true", "basedomain=test.ogfg.link"]
```

## Make sure Helm is ready

Run `helm init` to install Tiller in your namespace. Tiller handles deployment steps for Helm charts. Be sure to set the namespace and service account to match the user shown in `kubectl config get-contexts`

```powershell
helm init --node-selectors "beta.kubernetes.io/os=linux" --tiller-namespace rascally --service-account rascally-user
```

## Configure draft to use the container registry

Set your draft config to use the same registry that you configured on your Kubernetes cluster.

`draft config set registry <registryFqdn>`

## Deploy it

Run `draft up`

It will build and push the Docker image to the private registry, then release it with Helm. The first build will probably take a few minutes as the Docker images are pulled, and the .Net Core packages are cached into a container layer.

```none
PS C:\Users\kkna2018\jaffacake> draft up
Draft Up Started: 'jaffacake': 01CYFB2WD0CNMPZV0EW6DSF2JF
jaffacake: Building Docker Image: SUCCESS ⚓  (105.0876s)
jaffacake: Pushing Docker Image: SUCCESS ⚓  (8.2328s)
jaffacake: Releasing Application: SUCCESS ⚓  (35.8252s)
Inspect the logs with `draft logs 01CYFB2WD0CNMPZV0EW6DSF2JF`
```

Now, the deployment will be listed with `helm list`, and you can get more details with `helm status`

```none
helm list
NAME            REVISION        UPDATED                         STATUS          CHART                   APP VERSION     NAMESPACE
jaffacake       1               Tue Dec 11 19:16:43 2018        DEPLOYED        jaffacake-v0.0.1                        rascally
PS C:\Users\kkna2018\jaffacake> helm status jaffacake
LAST DEPLOYED: Tue Dec 11 19:16:43 2018
NAMESPACE: rascally
STATUS: DEPLOYED

RESOURCES:
==> v1/Service
NAME                 AGE
jaffacake-jaffacake  1m

==> v1/Deployment
jaffacake-jaffacake  1m

==> v1beta1/Ingress
jaffacake-jaffacake  1m

==> v1/Pod(related)

NAME                                 READY  STATUS   RESTARTS  AGE
jaffacake-jaffacake-585fd7db4-crqwr  1/1    Running  0         1m


NOTES:

  http://jaffacake.test.ogfg.link to access your application
```

Open up your browser, and try it out!
