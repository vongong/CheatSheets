
$options = @()
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Az', 'Azure Cli'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Pwsh', 'PowerShell (default)'

$title = 'Azure Method'
$message = 'Login Protocol?'
$result = $host.ui.PromptForChoice($title, $message, $options, 1)

switch ($result) {
    0 {
        $Method = 'AzCli' 
        az login
    }
    1 {
        $Method = 'Pwsh' 
        Connect-AzAccount
    }    
    default {
        $Method = 'Pwsh' 
        Connect-AzAccount
    }
}

azSwitch.ps1 -Method $Method