# Start VMs and convert disks to Premium SSD
Powershell script for Azure Automation that start all VMs of a given Resource Group updating algo all disks of VMs to Premium SSD disks. Good for start your lab or dev environment in a "Performance Mode". Choose only your target Resource Group. 
Use in conjunction with the script "Shutdown VMs and convert disks to Stardard HDD" (https://github.com/marcosoikawa/shutdown-vms-with-disks)

## Requirements

- Azure Account
- Azure Automation Service with managed identity configured (https://learn.microsoft.com/en-us/azure/automation/quickstarts/enable-managed-identity)


## Recommended Use

If you want to start your demo environment, dev/test resources, converting also disks to Premium SSD, starting environment in a "Performance Mode".
