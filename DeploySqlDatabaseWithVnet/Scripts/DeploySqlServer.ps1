[CmdletBinding()]
param (
    [Parameter(Mandatory)][string]$ResourceGroupName,
    [Parameter(Mandatory)][string]$TemplateFile,
    [Parameter()][string]$TemplateParameterFile = $null,
    [Parameter()][string]$Environment = $null,
    [Parameter()][string]$TemplateFolder = "Templates",
    [Parameter()][string]$TemplateParameterFolder = "Parameters",
    [Parameter()][string]$Root = (Split-Path $PSScriptRoot -Parent),
    [Parameter(Mandatory)][string]$AdministratorName,
    [Parameter(Mandatory)][string]$AdministratorPassword
)

$SecureAdministratorPassword = ConvertTo-SecureString -AsPlainText $AdministratorPassword -Force

$ErrorActionPreference = "Stop"

$TemplateFileFullPath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($Root, $TemplateFolder, $TemplateFile))

if ($TemplateParameterFile) {
    $TemplateParameterFileFullPath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($Root, $TemplateParameterFolder, $Environment, $TemplateParameterFile))    
    New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFileFullPath -TemplateParameterFile $TemplateParameterFileFullPath -administratorName $AdministratorName -administratorPassword $SecureAdministratorPassword 
}

if (!$TemplateParameterFile) {
    New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFileFullPath -administratorName $AdministratorName -administratorPassword $SecureAdministratorPassword
}
