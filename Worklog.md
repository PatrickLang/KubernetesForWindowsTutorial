

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

```
wmic cpu
AddressWidth  Architecture  AssetTag  Availability  Caption                               Characteristics  ConfigManagerErrorCode  ConfigManagerUserConfig  CpuStatus  CreationClassName  CurrentClockSpeed  CurrentVoltage  DataWidth  Description                           DeviceID  ErrorCleared  ErrorDescription  ExtClock  Family  InstallDate  L2CacheSize  L2CacheSpeed  L3CacheSize  L3CacheSpeed  LastErrorCode  Level  LoadPercentage  Manufacturer  MaxClockSpeed  Name                                      NumberOfCores  NumberOfEnabledCore  NumberOfLogicalProcessors  OtherFamilyDescription  PartNumber  PNPDeviceID  PowerManagementCapabilities  PowerManagementSupported  ProcessorId       ProcessorType  Revision  Role  SecondLevelAddressTranslationExtensions  SerialNumber  SocketDesignation  Status  StatusInfo  Stepping  SystemCreationClassName  SystemName       ThreadCount  UniqueId  UpgradeMethod  Version  VirtualizationFirmwareEnabled  VMMonitorModeExtensions  VoltageCaps
64            9             None      3             Intel64 Family 6 Model 45 Stepping 7                                                                    1          Win32_Processor    2195               14              64         Intel64 Family 6 Model 45 Stepping 7  CPU0                                      100       179                                             0            0                            6      50              GenuineIntel  2195           Intel(R) Xeon(R) CPU E5-2660 0 @ 2.20GHz  4                                   4                                                  None                                                  FALSE                     1F8BFBFF000206D7  3              11527     CPU   FALSE                                    None          None               OK      3                     Win32_ComputerSystem     ML-RefVm-548509                         6                       FALSE                          FALSE
```

```
Get-ComputerInfo
...
OsTotalVisibleMemorySize                                : 8388148
OsFreePhysicalMemory                                    : 5528228
OsTotalVirtualMemorySize                                : 10354228
OsFreeVirtualMemory                                     : 7548404
```