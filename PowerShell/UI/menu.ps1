

#
# Write-Host 'Read-Host'
# $favColor = Read-Host -Prompt 'What is your favorite color?'
# Write-Host "You choose: "$favColor


#
Write-Host 'Automation.Host.ChoiceDescription'
# $red = New-Object System.Management.Automation.Host.ChoiceDescription 'Red'
# $blue = New-Object System.Management.Automation.Host.ChoiceDescription 'Blue'
# $yellow = New-Object System.Management.Automation.Host.ChoiceDescription 'Yellow'
# $options = [System.Management.Automation.Host.ChoiceDescription[]]($red, $blue, $yellow)

$options = @()
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Red', 'This color is Red'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Blue', 'Color of the ocean'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Yellow', 'Like the Sun'

$title = 'Favorite color'
$message = 'What is your favorite color?'
$result = $host.ui.PromptForChoice($title, $message, $options, -1)

switch ($result) {
    0 { $resultVal = 'Red' }
    1 { $resultVal = 'Blue' }
    2 { $resultVal = 'Yellow' }
    default { $resultVal = '' }
}
Write-Host "You choose: "$resultVal