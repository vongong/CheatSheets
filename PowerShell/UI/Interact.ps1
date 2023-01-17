$ChoiceArray = @()
$ChoiceArray += 'Apple'
$ChoiceArray += 'Orange'
$ChoiceArray += 'Banana'

$FruitChoices = [System.Management.Automation.Host.ChoiceDescription[]] $ChoiceArray
$FruitChoice  = $host.UI.PromptForChoice('', 'Choose your target Secondary Replica to failover to', $FruitChoices, 0) # -1 for no default

Write-Host "You choose: "$ChoiceArray[$FruitChoice]