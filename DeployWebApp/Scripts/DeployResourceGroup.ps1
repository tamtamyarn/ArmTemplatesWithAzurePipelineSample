[CmdletBinding()]
param (
    [Parameter(Mandatory)][string]$ResourceGroupName,
    [Parameter(Mandatory)][string]$ResourceGroupLocation
)

if ($null -eq (Get-AzResourceGroup -Name $ResourceGroupName -Verbose -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force -ErrorAction Stop
}
