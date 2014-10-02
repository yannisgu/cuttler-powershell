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
function New-Server
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$ServerName,
        [Parameter(Mandatory=$true)]
        [string]$ImageFamily,
        [Parameter(Mandatory=$true)]
        [string] $Region,
        [Parameter(Mandatory=$true)]
        [string] $InstanceSize
    )

    Begin
    {
    }
    Process
    {
        $ErrorActionPreference = "Stop"
        $regId = Get-Id $Region
        #$Global:storage = Get-AzureStorageAccount (Get-StorageName $regId)
        #$Global:image = Get-AzureVMImage | ? ImageFamily -eq $ImageFamily | Sort-Object -Property PublishedDate | select -last 1
        $password = New-SWRandomPassword -MinPasswordLength 24  -MaxPasswordLength 24
        $username = "cuttlerroot"
        New-AzureVMConfig -Name $ServerName -InstanceSize $InstanceSize -ImageName $image.ImageName | 
            Add-AzureProvisioningConfig -Windows -AdminUsername $username -Password $password -NoRDPEndpoint |
            Add-AzureEndpoint -Name HTTP -Protocol tcp -LocalPort 80 -PublicPort 80 |
            Add-AzureEndpoint -Name HTTPS -Protocol tcp -LocalPort 443 -PublicPort 443 |
            Out-Null
            #New-AzureVM -ServiceName $ServerName -AffinityGroup $regId
        while((Get-AzureVM $ServerName).PowerState -ne "Started") {
            sleep -s 1
        }
        $password
       
    }
    End
    {
    }
}

if($psISE) {
    New-Server -ServerName "cuttler" -ImageFamily "Windows Server 2012 R2 Datacenter" -Region "West Europe" -InstanceSize Small
}