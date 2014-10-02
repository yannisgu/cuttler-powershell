<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Initialize-Datacenter
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        $Region
    )

    Begin
    {
    }
    Process
    {
        $ErrorActionPreference = "Stop"
        $baseId = Get-Id -Region $Region
       
        $afGroup = Get-AzureAffinityGroup $baseId
        if(-not $afGroup) 
        {
            Write-Verbose "Create new affinity group $baseId"
            New-AzureAffinityGroup -Name $baseId -Location $Region | Out-Null
            $afGroup = Get-AzureAffinityGroup $baseId
        }
        $storageName = Get-StorageName $baseId
        $storage = Get-AzureStorageAccount $storageName -ErrorAction SilentlyContinue
        if(-not $storage) {
            Write-Verbose "Create storage account $storageName"
            New-AzureStorageAccount -StorageAccountName $storageName -AffinityGroup $afGroup.Name | Out-Null
            $storage = Get-AzureStorageAccount $storageName -ErrorAction SilentlyContinue
        }
    }
    End
    {
    }
}

if($psISE) {
    Initialize-Datacenter -Region "West Europe" -Verbose
}