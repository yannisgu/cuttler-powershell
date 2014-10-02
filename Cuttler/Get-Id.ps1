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
function Get-Id
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$Region

    )

    Begin
    {
    }
    Process
    {
        "cuttler-" + ($Region -replace " ", "-").ToLower()
    }
    End
    {
    }
}