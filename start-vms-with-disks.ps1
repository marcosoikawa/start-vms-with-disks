
Write-Verbose "https://github.com/marcosoikawa/start-vms-with-disks" -Verbose

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context
# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext
# If you have multiple subscriptions, set the one to use
# Select-AzSubscription -SubscriptionId "<SUBSCRIPTIONID>"

# Name of the resource group that contains the VM
$rgName = "Hiro-VMS"

#Type to convert the disks
$storageType = 'Premium_LRS'

$subscriptionName = $AzureContext.Subscription.Name
Write-Verbose "Subscription to work against: $subscriptionName" -Verbose
Write-Verbose "Resource Group to work against: $rgName" -Verbose

$vms = Get-AzVM -ResourceGroupName $rgName

Write-Verbose "------ Converting Disks ------" -Verbose

# Get all disks in the resource group of the VM
$vmDisks = Get-AzDisk -ResourceGroupName $rgName 

# For disks that belong to the selected VM, convert to Premium storage
foreach ($disk in $vmDisks)
{
    $diskName = $disk.Name
    Write-Verbose "Working on disk: $diskName" -Verbose
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Verbose "Updated!" -Verbose
}

Write-Verbose "------ Start Virtual Machines ------" -Verbose
foreach ($vm in $vms)
{
    $vmName = $vm.Name
    Write-Verbose "Starting VM: $vmName" -Verbose    
    Start-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name
}