Login-AzureRmAccount

$tenantID = "b7f604a0-00a9-4188-9248-42f3a5aac2e9"
$subscriptionID = "dc2a4b35-5221-412c-bca8-cb90aef6fbfb"
$ResourceGroupLocation = "westus"
$ResourceGroupName = "EMJU-AZPR-DSE"
$DeploymentName = "DSEDeployment"

$DSETemplate = "templates\mainTemplate.json"
$DSEParameterFile = "parameters\prod.parameters.json"

Set-AzureRmContext -SubscriptionId $subscriptionID -TenantId $tenantID

New-AzureRmResourceGroup -Name $ResourceGroupName `
                       -Location $ResourceGroupLocation `

New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $ResourceGroupName -TemplateFile $DSETemplate -TemplateParameterFile $DSEParameterFile -Force -Verbose