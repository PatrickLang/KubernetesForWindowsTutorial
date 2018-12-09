

## Classroom labs

I'm giving this a look. It has an invitation URL you can use to create an account and log into a VM, which seems much easier than the normal DevTest labs experience.

https://docs.microsoft.com/en-us/azure/lab-services/classroom-labs/classroom-labs-overview 


Open questions

- [ ] limit to number of VMs?
- [ ] is VM startup fast enough?
- [ ] any way to automate setup instead of using a login / save template workflow



### VM sizing

This is a 'medium' size VM - looks like a standard_a4_v2

```powershell
curl.exe -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-08-01"
{"compute":{"location":"southcentralus","name":"ML-RefVm-548509","offer":"WindowsServer","osType":"Windows","placementGroupId":"","platformFaultDomain":"0","platformUpdateDomain":"0","publisher":"MicrosoftWindowsServer","resourceGroupName":"ml-lab-...-vms","sku":"2019-Datacenter-with-Containers","subscriptionId":"...","tags":"EnvironmentSettingName:Kubecon 2018 Windows Containers;LabName:kubecon 2018 windows containers;SubscriptionId:....;hidden-DevTestLabs-LabUId:...;hidden-DevTestLabs-LogicalResourceUId:...","version":"2019.0.20181122","vmId":"...","vmSize":"Standard_A4_v2"},"network":{"interface":[{"ipv4":{"ipAddress":[{"privateIpAddress":"10.0.0.4","publicIpAddress":""}],"subnet":[{"address":"10.0.0.0","prefix":"20"}]},"ipv6":{"ipAddress":[]},"macAddress":"..."}]}}
```