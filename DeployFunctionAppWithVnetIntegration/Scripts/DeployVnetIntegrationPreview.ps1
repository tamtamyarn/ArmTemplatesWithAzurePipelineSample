[CmdletBinding()]
param (
    [Parameter(Mandatory)][string]$ResourceGroupName,
    [Parameter()][string]$TemplateParameterFolder = "Parameters",
    [Parameter(Mandatory)][string]$Environment,
    [Parameter(Mandatory)][string]$TemplateParameterFile
)

$ErrorActionPreference = "Stop"

$Root = (Convert-Path .)
$TemplateParameterFileFullPath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($Root, $TemplateParameterFolder, $Environment, $TemplateParameterFile))

$parameters = Get-Content $TemplateParameterFileFullPath -Encoding UTF8 -Raw | ConvertFrom-Json

if((az webapp vnet-integration list --name $parameters.appServiceName --resource-group $ResourceGroupName) -eq "[]")
{
    $ErrorActionPreference = "silentlycontinue"
    az webapp vnet-integration add --resource-group $ResourceGroupName --name $parameters.appServiceName --vnet $parameters.vnetName --subnet $parameters.subnetName
}