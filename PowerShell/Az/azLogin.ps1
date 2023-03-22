
$options = @()
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Az', 'Azure Cli'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Pwsh', 'PowerShell (default)'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Both', 'Both'

$title = 'Azure Method'
$message = 'Login Protocol?'
$resultLogin = $host.ui.PromptForChoice($title, $message, $options, 1)

$options = @()
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Dev', 'BPB Dev-Test (Default)'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Prod', 'BPB Production'

$title = 'Azure Subscription'
$message = 'Subscription?'
$resultSub = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($resultLogin) {
    0 {
        $Method = 'AzCli' 
        az login
    }
    1 {
        $Method = 'Pwsh' 
        Connect-AzAccount
    }    
    2 {
        $Method = 'Both' 
        az login
        Connect-AzAccount
    }    
    default {
        $Method = 'Pwsh' 
        Connect-AzAccount
    }
}

azSwitch.ps1 -Method $Method -Sub $resultSub

