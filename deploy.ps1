Login-AzureRmAccount
 
$tenantID = "b7f604a0-00a9-4188-9248-42f3a5aac2e9"
$subscriptionID = "dc2a4b35-5221-412c-bca8-cb90aef6fbfb"
$subscriptionName = "EMJU"
$ResourceGroupLocation = "westus"

$subscriptionArgs = @()
$subscriptionArgs += ("-ResourceGroupLocation", $ResourceGroupLocation)
$subscriptionArgs += ("-SubscriptionID",$subscriptionID)
$subscriptionArgs += ("-SubscriptionName",$subscriptionName)
$subscriptionArgs += ("-TenantID",$tenantID)

$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","test")
$invokeArgs += ("-TemplateFile", "templates\mainTemplate.json")
$invokeArgs += ("-TemplateParametersFile","parameters\prod.parameters.json")
$invokeArgs += $subscriptionArgs

# This seems to be missing the command to actually invoke these arguments
