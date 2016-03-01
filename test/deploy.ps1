Login-AzureRmAccount

$tenantID = "b7f604a0-00a9-4188-9248-42f3a5aac2e9"
$subscriptionID = "ec4b8e6e-6a27-4430-a1ac-3ded010cb563"
$ResourceGroupLocation = "westus"
$ResourceGroupName = "EMJU-AZTESTBKPCOPY-DSE"
$DeploymentName = "TestDSEDeployment"

$DSETemplate = "templates\mainTemplate.json"
$DSEParameterFile = "parameters\perf.parameters.json"

Set-AzureRmContext -SubscriptionId $subscriptionID -TenantId $tenantID

New-AzureRmResourceGroup -Name $ResourceGroupName `
                       -Location $ResourceGroupLocation `

New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $ResourceGroupName -TemplateFile $DSETemplate -TemplateParameterFile $DSEParameterFile -Force -Verbose