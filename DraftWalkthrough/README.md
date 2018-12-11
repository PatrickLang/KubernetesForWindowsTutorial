## Create a sample web app

First, make a new directory for the project. Name it something tasty :)

```powershell
mkdir jaffacake
cd jaffacake
```

Next, use `dotnet new` to create a new template project, then `draft create -p CSharpWindowsNetCore` to scaffold it.

```powershell
dotnet new mvc
draft create -p CSharpWindowsNetCore
```

Now, modify `draft.toml`

1. Set the `namespace` to match the namespace you have access to
2. Add a line to set the ingress `set = ["ingress.enabled=true", "basedomain=test.ogfg.link"]`

Here's a full example: 

```toml
[environments]
  [environments.development]
    name = "webbcd"
    namespace = "h"
    wait = true
    watch = false
    watch-delay = 2
    auto-connect = false
    dockerfile = "Dockerfile"
    chart = ""
    set = ["ingress.enabled=true", "basedomain=test.ogfg.link"]
```

## Deploy it

Run `draft up`

```none
Draft Up Started: 'webbcd': 01CYD9T0XG5C0XBJQTJP9CEEPK
webbcd: Building Docker Image: SUCCESS ⚓  (1.0002s)
webbcd: Pushing Docker Image: SUCCESS ⚓  (3.3824s)
webbcd: Releasing Application: SUCCESS ⚓  (20.8183s)
Inspect the logs with `draft logs 01CYD9T0XG5C0XBJQTJP9CEEPK`
```

Now, the deployment will be listed with `helm list`, and you can get more details with `helm status`

```none
PS C:\repos\webbcd> helm list
NAME    REVISION        UPDATED                         STATUS          CHART           APP VERSION     NAMESPACE
webbcd  1               Tue Dec 11 00:14:06 2018        DEPLOYED        webbcd-v0.0.1                   h

PS C:\repos\webbcd> helm status webbcd
LAST DEPLOYED: Tue Dec 11 00:14:06 2018
NAMESPACE: h
STATUS: DEPLOYED

RESOURCES:
==> v1/Deployment
NAME           AGE
webbcd-webbcd  31s

==> v1beta1/Ingress
webbcd-webbcd  31s

==> v1/Pod(related)

NAME                            READY  STATUS   RESTARTS  AGE
webbcd-webbcd-5b77664959-zkbg2  1/1    Running  0         31s

==> v1/Service

NAME           AGE
webbcd-webbcd  31s


NOTES:

  http://webbcd.test.ogfg.link to access your application
