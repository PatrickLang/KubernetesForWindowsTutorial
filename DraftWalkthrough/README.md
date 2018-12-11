## Create a sample web app

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

Modify the last few lines to enable ingress.

```yaml
...
ingress:
  enabled: true
basedomain: "test.ogfg.link"
```

Full example:
```yaml
# Default values for c#.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.
replicaCount: 1
image:
  pullPolicy: IfNotPresent
service:
  name: dotnetcore
  type: ClusterIP
  externalPort: 8080
  internalPort: 80
resources:
  limits:
    cpu: 1
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi
ingress:
  enabled: true
basedomain: "test.ogfg.link"
```
