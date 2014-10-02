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
function Get-StorageName
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$BaseId

    )

    Begin
    {
    }
    Process
    {
        $baseId.Replace("-" , "")
    }
    End
    {
    }
}