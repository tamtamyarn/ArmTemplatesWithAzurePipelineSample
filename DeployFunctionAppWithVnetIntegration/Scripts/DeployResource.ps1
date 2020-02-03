[CmdletBinding()]
param (
    [Parameter(Mandatory)][string]$ResourceGroupName,
    [Parameter(Mandatory)][string]$TemplateFile,
    [Parameter()][string]$TemplateParameterFile = $null,
    [Parameter()][string]$Environment = $null,
    [Parameter()][string]$TemplateFolder = "Templates",
    [Parameter()][string]$TemplateParameterFolder = "Parameters",
    [Parameter()][string]$Root = (Split-Path $PSScriptRoot -Parent)
)

$ErrorActionPreference = "Stop"

$TemplateFileFullPath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($Root, $TemplateFolder, $TemplateFile))

if ($TemplateParameterFile) {
    $TemplateParameterFileFullPath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($Root, $TemplateParameterFolder, $Environment, $TemplateParameterFile))    
    New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFileFullPath -TemplateParameterFile $TemplateParameterFileFullPath
}

if (!$TemplateParameterFile) {
    New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFileFullPath
}
